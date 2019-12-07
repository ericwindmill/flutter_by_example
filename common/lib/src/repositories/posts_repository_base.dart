import 'package:common/common.dart';
import 'package:common/src/models/post_configuration.dart';

abstract class PostRepository {
  Future<PostConfiguration> loadMarkdownPostByPageId(String pageId);
  Future<List<PostConfiguration>> loadAllPosts();
  Future<List<PostCategory>> loadTableOfContents();
}