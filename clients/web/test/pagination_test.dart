import 'package:common/common.dart';
import 'package:test/test.dart';
import 'package:web/src/app/repositories/posts_respository_filesystem.dart';
import 'package:web/src/app/repositories/table_of_contents_mem_cache.dart';

import '../lib/src/app/use_case/table_of_contents/pagination.dart';

void main() {
  group('Pagination', () {
    setUpAll(() async {
      // This should be stubbed if this is ever run in CI
      await FilesystemBrowserPostsRepository(MemCache()).loadTableOfContents();
    });

    group('.getForFrontmatter', () {
      final frontmatter = PostFrontmatter(
        category: 'Flutter State and Logic Example Apps',
        subSection: 'Brick: Offline First with Rest',
        title: 'Adding a Model',
      );

      test('#previousPost', () {
        final pagination = Pagination.getForFrontmatter(frontmatter);
        expect(pagination.previousPost.title, 'Adding a Repository');
      });

      test('#nextPost', () {
        final pagination = Pagination.getForFrontmatter(frontmatter);
        expect(pagination.nextPost.title, 'Generating Code');
      });
    });
  });
}
