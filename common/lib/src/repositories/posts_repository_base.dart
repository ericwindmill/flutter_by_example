import 'package:common/src/models/post_configuration.dart';

abstract class PostRepository {
  Future<PostConfiguration> loadPostByPageId(String pageId);
  Future<List<PostConfiguration>> loadAllPosts();
}