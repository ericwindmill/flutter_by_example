import 'dart:async';
import 'dart:io';

import 'package:aqueduct/aqueduct.dart';
import 'package:cms_server/utils/parse/parse_filesystem.dart';
import 'package:cms_server/utils/parse/parse_frontmatter.dart';
import 'package:cms_server/utils/paths/utils.dart';
import 'package:common/common.dart';

class TableOfContentsController extends Controller {
  @override
  FutureOr<RequestOrResponse> handle(Request request) async {
    ///  Eventually return this:
    final Map<String, PostCategory> posts = <String, PostCategory>{};

    /// Start with the root of the content folder
    final root = Directory.fromUri(Uri(path: 'public/'));

    /// Get Files as a flat list. i.e: [File file1, File file2, etc...]
    final files = await parseFilesystem(root);

    // try to extract the file from from the [FileSystemEntity]
    for (var f in files) {
      /// eventually we will return this file.
      File file;

      try {
        /// Extract the file
        final FilePath filePath = PathUtils.getFileName(f);
        file = File.fromUri(Uri(path: f.path));

        /// Read the file and extract frontmatter
        final content = file.readAsStringSync();
        final frontmatter = extractFrontmatterOnly(
          content,
          PathUtils.removeFileExtension(filePath.fileName),
        );

        /// Now I have a frontmatter object, and I need to place it in
        /// a sub category, which needs to be placed in a category
        final categoryTitle = frontmatter?.category;
        final subCategoryTitle = frontmatter?.subSection;

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
        final bool categoryExists = posts[categoryTitle] != null;

        if (categoryExists) {
          final PostSubCategory subCategory = posts[categoryTitle]
              .subCategories
              .firstWhere((PostSubCategory s) => s.title == subCategoryTitle, orElse: () => null);

          if (subCategory != null) {
            /// category: exists, subcategory: exists
            subCategory.posts.add(frontmatter);
          } else {
            /// category: exists, subcategory: doesn't exist
            /// create new sub category with frontmatter
            final newSub = PostSubCategory(
              title: subCategoryTitle,
              posts: [frontmatter],
            );

            /// add subcategory to category
            posts[categoryTitle].subCategories.add(newSub);
          }
        } else {
          /// subcategory cannot logically exist
          /// create new subcategory with frontmatter
          final s = PostSubCategory(
            title: subCategoryTitle,
            posts: [frontmatter],
          );

          /// create new category with new sub
          final c = PostCategory(
            title: categoryTitle,
            description: "",
            subCategories: [s],
          );

          /// add it to the posts
          posts[categoryTitle] = c;
        }
      } catch (e, s) {
        print(e);
        print(s);
      }
    }

    final asList = posts.values.toList();
    return Response.ok(asList);
  }
}
