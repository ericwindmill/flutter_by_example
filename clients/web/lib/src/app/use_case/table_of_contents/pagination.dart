import 'package:common/common.dart';
import 'package:common/src/models/models.dart';
import 'package:web/src/app/repositories/table_of_contents_mem_cache.dart';
import 'package:web/src/app/table_of_contents.dart';

class Pagination {
  final PostFrontmatter previousPost;
  final PostFrontmatter nextPost;

  Pagination._({
    this.previousPost,
    this.nextPost,
  });

  factory Pagination.getForFrontmatter(PostFrontmatter frontmatter) {
    return Pagination._(
      previousPost: _previousPost(frontmatter),
      nextPost: _nextPost(frontmatter),
    );
  }

  static PostFrontmatter _previousPost(PostFrontmatter currentPost) {
    final sortedPostNames = TABLE_OF_CONTENTS[currentPost.category]
            [currentPost.subSection]
        .toList();
    final postPosition = sortedPostNames.indexOf(currentPost.title);

    // If post can't be found or if it's the first in the sub section
    if (postPosition <= 0 || sortedPostNames.length == 1) return null;

    return _findInTableOfContents(sortedPostNames[postPosition - 1]);
  }

  static PostFrontmatter _nextPost(PostFrontmatter currentPost) {
    final sortedPostNames = TABLE_OF_CONTENTS[currentPost.category]
            [currentPost.subSection]
        .toList();
    final postPosition = sortedPostNames.indexOf(currentPost.title);

    // if post can't be found or if the sub section only has one value
    if (postPosition < 0 || sortedPostNames.length == 1) return null;

    // if post is last in sub section
    if (postPosition == (sortedPostNames.length - 1)) return null;

    return _findInTableOfContents(sortedPostNames[postPosition + 1]);
  }

  static PostFrontmatter _findInTableOfContents(String postTitle) {
    return MemCache().flatTableOfContents?.firstWhere((PostFrontmatter f) {
      return f.title == postTitle;
    }, orElse: () => null);
  }
}
