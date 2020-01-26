import 'package:common/common.dart';
import 'package:common/src/models/models.dart';
import 'package:web/src/app/repositories/table_of_contents_mem_cache.dart';
import 'package:web/src/app/table_of_contents.dart';

class Pagination {
  PostFrontmatter previousPost;
  PostFrontmatter nextPost;
  String _nextTitle;
  String _previousTitle;

  Pagination.getForFrontmatter(PostFrontmatter frontmatter) {
    _getPreviousAndNextPostTitlesForFrontmatter(frontmatter);
    previousPost = _previousPost(frontmatter);
    nextPost = _nextPost(frontmatter);
  }

  void _getPreviousAndNextPostTitlesForFrontmatter(PostFrontmatter frontmatter) {
    final sortedPostNames =
        TABLE_OF_CONTENTS[frontmatter.category][frontmatter.subSection].toList();
    sortedPostNames.forEach((String postTitle) {
      final postPosition = sortedPostNames.indexOf(frontmatter.title);
      if (postPosition > -1) {
        if (postPosition > 0) {
          _previousTitle = sortedPostNames[postPosition - 1];
        }
        if (postPosition < sortedPostNames.length - 1) {
          _nextTitle = sortedPostNames[postPosition + 1];
        }
      }
      // micro optimization
      if (_previousTitle != null || _nextTitle != null) return;
    });
  }

  PostFrontmatter _previousPost(PostFrontmatter frontmatter) {
    return MemCache().flatTableOfContents?.firstWhere((PostFrontmatter f) {
      return f.title == _previousTitle;
    }, orElse: () => null);
  }

  PostFrontmatter _nextPost(PostFrontmatter frontmatter) {
    return MemCache().flatTableOfContents?.firstWhere((PostFrontmatter f) {
      return f.title == _nextTitle;
    }, orElse: () => null);
  }
}
