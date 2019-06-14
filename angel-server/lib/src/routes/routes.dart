library angel_server.src.routes;

import 'package:angel_framework/angel_framework.dart';
import 'package:angel_server/src/pretty_logging.dart';
import 'package:angel_server/src/utils/build_toc_utils.dart';
import 'package:angel_server/src/utils/extract_frontmatter.dart';
import 'package:angel_server/src/utils/path_utils.dart';
import 'package:angel_static/angel_static.dart';
import 'package:common/common.dart';
import 'package:file/file.dart';
import 'package:angel_cors/angel_cors.dart';
import 'package:logging/logging.dart';
import 'controllers/controllers.dart' as controllers;

AngelConfigurer configureServer(FileSystem fileSystem) {
  return (Angel app) async {
    await app.configure(controllers.configureServer);
    app.fallback(cors());

    app.get('/', (req, res) => res.render('hello'));

    var vDir =
        VirtualDirectory(app, fileSystem, source: fileSystem.directory('web'),
            callback: (File f, RequestContext req, ResponseContext resp) async {
      String content = await f.readAsString();
      PostConfiguration post = buildPost(content, req.path);
      return post;
    });

    /// This service returns all posts, but they're grouped by category
    app.get('/toc', (req, res) async {
      ///  Eventually return this:
      Map<String, PostCategory> posts = <String, PostCategory>{};

      ///  It should look like:
      /// {
      ///    "Dart": PostCategory(
      ///     "title": "Dart",
      ///     "description" : "...",
      ///     "subCategories" : [
      ///        PostSubCategory(
      ///          "title": "Async Dart"
      ///          "posts": [
      ///             PostFrontmatter(...),
      ///             PostFrontmatter(...)
      ///           ],
      ///        ),
      ///        PostSubCategory(...),
      ///     ],
      ///   ),
      ///   "Flutter": ....
      /// }
      ///

      // Get Files as a flat list
      List<FileSystemEntity> files = await TableOfContentsBuilder.build(vDir);
      files.forEach((FileSystemEntity f) {
        File file;
        try {
          // Extract the file
          FilePath filePath = PathUtils.getFileName(f);
          file = TableOfContentsBuilder.buildFilePath(f, vDir);

          /// Read the file and extract frontmatter
          String content = file.readAsStringSync();
          PostFrontmatter frontmatter = extractFrontmatterOnly(
              content, PathUtils.removeFileExtension(filePath.fileName));

          /// Now I have a frontmatter object, and I need to place it in
          /// a sub category, which needs to be placed in a category
          var categoryTitle = frontmatter.category;
          var subCategoryTitle = frontmatter.subSection;

          /// possible outcomes:
          /// category: exists, subcategory: exists
          /// category: exists, subcategory: doesn't exist
          /// category: doesn't exists, subcategory: doesn't exist
          ///
          bool categoryExists = posts[categoryTitle] != null;

          print(categoryTitle);
          print(subCategoryTitle);

          if (categoryExists) {
            PostSubCategory subCategory = posts[categoryTitle]
                .subCategories
                .firstWhere((PostSubCategory s) => s.title == subCategoryTitle,
                    orElse: () => null);
            if (subCategory != null) {
              /// category: exists, subcategory: exists
              subCategory.posts.add(frontmatter);
            } else {
              /// category: exists, subcategory: doesn't exist
              // create new sub category with frontmatter
              final newSub = PostSubCategory(subCategoryTitle, [frontmatter]);
              // add subcategory to category
              posts[categoryTitle].subCategories.add(newSub);
            }
          } else {
            /// subcategory cannot logically exist
            // create new subcategory with frontmatter
            final s = PostSubCategory(subCategoryTitle, [frontmatter]);
            // create new category with new sub
            final c =
                PostCategory(categoryTitle, "", [s], postOrder[categoryTitle]);
            // add it to the posts
            posts[categoryTitle] = c;
          }
        } catch (e, s) {
          prettyLog(LogRecord(Level.WARNING, "Error reading files for toc",
              "App.get.toc", e, s));
        }
      });
      List<PostCategory> asList = posts.values.toList();
      return asList;
    });

    app.fallback(vDir.handleRequest);

    app.fallback((req, res) => throw AngelHttpException.notFound());

    var oldErrorHandler = app.errorHandler;
    app.errorHandler = (e, req, res) async {
      if (req.accepts('text/html', strict: true)) {
        if (e.statusCode == 404 && req.accepts('text/html', strict: true)) {
          await res
              .render('error', {'message': 'No file exists at ${req.uri}.'});
        } else {
          await res.render('error', {'message': e.message});
        }
      } else {
        return await oldErrorHandler(e, req, res);
      }
    };
  };
}
