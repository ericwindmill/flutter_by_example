library angel_server.src.routes;

import 'dart:async';
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

final RegExp _straySlashes = RegExp(r'(^/+)|(/+$)');

AngelConfigurer configureServer(FileSystem fileSystem) {
  return (Angel app) async {
    await app.configure(controllers.configureServer);

    // cors is disabled for ~ALL~ requests
    // Todo: for production, remove this and make each request handle cors
    app.fallback(cors());

    /// index route renders a Jael template from 'views/hello.jael'
    app.get('/', (req, res) => res.render('hello'));

    /// Virtual directory is used to interact with the Filesystem
    /// Note that Angel uses 'package:file' rather than 'package:io'.
    var vDir = VirtualDirectory(
      app,
      fileSystem,
      source: fileSystem.directory('web'),
      callback: (File f, RequestContext req, ResponseContext resp) async {
        print("vDir.callback: $f");
        String content = await f.readAsString();
        PostConfiguration post = buildPost(content, req.path);
        return post;
      },
    );

    /// This service returns all posts ~frontmatter~
    /// It doesnt care about the post itself.
    /// Grouped by category and sub category
    ///
    ///
    /// The payload looks like this:
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
    app.get('/toc', (req, res) async {
      ///  Eventually return this:
      Map<String, PostCategory> posts = <String, PostCategory>{};

      /// Get Files as a flat list. i.e: [File file1, File file2, etc...]
      List<FileSystemEntity> files = await TableOfContentsBuilder.build(vDir);
      files.forEach((FileSystemEntity f) {
        /// eventually we will return this file.
        File file;

        try {
          /// Extract the file
          FilePath filePath = PathUtils.getFileName(f);
          file = TableOfContentsBuilder.buildFilePath(f, vDir);

          /// Read the file and extract frontmatter
          String content = file.readAsStringSync();
          PostFrontmatter frontmatter =
              extractFrontmatterOnly(content, PathUtils.removeFileExtension(filePath.fileName));

          /// Now I have a frontmatter object, and I need to place it in
          /// a sub category, which needs to be placed in a category
          var categoryTitle = frontmatter.category;
          var subCategoryTitle = frontmatter.subSection;

          /// Each Frontmatter has a 'subcategory' and a 'category'. These
          /// are used by the client to render the Table of Contents correctly.
          ///
          /// At this point, we're adding each Frontmatter to the 'posts' variable,
          /// and ensuring along the way that each category and subcategory exists
          /// in the Map.
          ///
          /// possible outcomes:
          /// category: exists, subcategory: exists
          /// category: exists, subcategory: doesn't exist
          /// category: doesn't exists, subcategory: doesn't exist
          ///
          /// Note: It is logically impossible for a subcategory to
          /// exist and it's parent category to not exist.
          ///
          bool categoryExists = posts[categoryTitle] != null;

          if (categoryExists) {
            PostSubCategory subCategory = posts[categoryTitle]
                .subCategories
                .firstWhere((PostSubCategory s) => s.title == subCategoryTitle, orElse: () => null);
            if (subCategory != null) {
              /// category: exists, subcategory: exists
              subCategory.posts.add(frontmatter);
            } else {
              /// category: exists, subcategory: doesn't exist
              /// create new sub category with frontmatter
              final newSub = PostSubCategory(subCategoryTitle, [frontmatter]);

              /// add subcategory to category
              posts[categoryTitle].subCategories.add(newSub);
            }
          } else {
            /// subcategory cannot logically exist
            /// create new subcategory with frontmatter
            final s = PostSubCategory(subCategoryTitle, [frontmatter]);

            /// create new category with new sub
            final c = PostCategory(categoryTitle, "", [s], PostOrder.fromString(categoryTitle));

            /// add it to the posts
            posts[categoryTitle] = c;
          }
        } catch (e, s) {
          prettyLog(LogRecord(
            Level.WARNING,
            "Error reading files for toc",
            "App.get.toc",
            e,
            s,
          ));
        }
      });
      List<PostCategory> asList = posts.values.toList();
      asList.sort((a, b) => a.order);
      return asList;
    });

    /// Anytime a request comes through to a route that isn't defined,
    /// It'll be passed through the following "fallback" methods in the order
    /// they're defined.
    ///
    app.fallback(
      (RequestContext req, ResponseContext res) => serveLocalFile(req, res, vDir),
    );

    app.fallback((req, res) => throw AngelHttpException.notFound());

    var oldErrorHandler = app.errorHandler;
    app.errorHandler = (e, req, res) async {
      if (req.accepts('text/html', strict: true)) {
        if (e.statusCode == 404 && req.accepts('text/html', strict: true)) {
          await res.render('error', {'message': 'No file exists at ${req.uri}.'});
        } else {
          await res.render('error', {'message': e.message});
        }
      } else {
        return await oldErrorHandler(e, req, res);
      }
    };
  };
}

FutureOr<dynamic> serveLocalFile(
    RequestContext req, ResponseContext res, VirtualDirectory vDir) async {
  try {
    int segmentsCount = req.path.split("/").length;
    String fileName = req.path.split("/")[segmentsCount - 1];
    FileSystemEntity foundFile = await TableOfContentsBuilder.findFileInFilesystemByFileName(
        vDir.source.childDirectory("content"), fileName);
    if (foundFile == null) return false;
    var path = foundFile.uri.path.replaceAll(_straySlashes, '');
    var stat = await vDir.fileSystem.stat(foundFile.absolute.path);
    return await vDir.serveStat(foundFile.absolute.path, path, stat, req, res);
  } catch (e, s) {
    prettyLog(LogRecord(
      Level.WARNING,
      "Error reading files for toc",
      "App.get.toc",
      e,
      s,
    ));
  }
}
