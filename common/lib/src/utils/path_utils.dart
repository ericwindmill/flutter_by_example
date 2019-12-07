// would love to see this in a yaml config. But not today.
import 'package:common/common.dart';
import 'package:common/src/models/post_frontmatter.dart';
import 'package:common/src/utils/table_of_contents.dart';

// TODO: optimize this if it's slow AF.
// This is very brute force
// the loops should not be hitting each node multiple times
sortPosts(List<PostCategory> allPosts) {
  try {
    /// these are used as temporary storage to sort portions
    /// of the final sort. They are often cleared
    List<PostCategory> sorted = [];
    List<PostSubCategory> sortedForCategory = [];
    List<PostFrontmatter> sortedForSubcategory = [];
    // Post category
    List<String> sortedCategoryTitles = TABLE_OF_CONTENTS.keys.toList();
    sortedCategoryTitles.forEach((String categoryTitle) {
      print("sort.categoryTitle loop :: $categoryTitle");
      PostCategory categoryObject = allPosts.firstWhere((c) {
        var categoryTitleFromObject = c.title.toLowerCase().trim();
        var categoryTitleFromToC = categoryTitle.toLowerCase().trim();
        return categoryTitleFromObject == categoryTitleFromToC;
      });
      // subcategory
      List<String> sortedSubcategoryTitles = TABLE_OF_CONTENTS[categoryTitle].keys.toList();
      sortedSubcategoryTitles.forEach((String subcategoryTitle) {
        print("sort.subcategoryTitle loop :: $subcategoryTitle");
        PostSubCategory postSubCategoryObject = categoryObject.subCategories.firstWhere((s) {
          var subcategoryTitleFromObject = s.title.toLowerCase().trim();
          var subcategoryTitleFromToC = subcategoryTitle.toLowerCase().trim();
          return subcategoryTitleFromToC == subcategoryTitleFromObject;
        });

        // posts
        List<String> sortedPostNames = TABLE_OF_CONTENTS[categoryTitle][subcategoryTitle].toList();
        sortedPostNames.forEach((String postTitle) {
          print("sort.postName loop :: $postTitle");
          PostFrontmatter post = postSubCategoryObject.posts.firstWhere((p) {
            var postTitleFromObject = p.title.toLowerCase().trim();
            var postTitleFromToC = postTitle.toLowerCase().trim();
            return postTitleFromObject == postTitleFromToC;
          });
          sortedForSubcategory.add(post);
        });
        // now that posts are sorted for this particular subcategory,
        // update the original object and clear the temp storage
        postSubCategoryObject.posts = sortedForSubcategory.sublist(0);
        sortedForSubcategory.clear();

        sortedForCategory.add(postSubCategoryObject);
      });
      print("4:");
      // now that [subcategories] are sorted for this particular subcategory,
      // update the original object and clear the temp storage
      categoryObject.subCategories = sortedForCategory.sublist(0);
      sorted.add(categoryObject);
      sortedForCategory.clear();
    });
    print("5");
    return sorted;
  } catch (e, s) {
    print(e);
    print(s);
  }
}
