import 'dart:convert';
import 'package:common/common.dart';
import 'package:http/http.dart';

import 'package:common/src/models/post_configuration.dart';
import 'package:web/src/app/repositories/posts_repository_base.dart';
import 'package:web/src/app/repositories/table_of_contents_mem_cache.dart';
import 'package:web/src/app/use_case/table_of_contents/pagination.dart';

const String baseUrl = 'http://localhost:8888';
//const String BASE_URL = 'https://flutter-by-example-api.herokuapp.com';

class FilesystemBrowserPostsRepository extends PostRepository {
  final Client client;
  final MemCache memCache;

  FilesystemBrowserPostsRepository(this.memCache) : client = Client();

  @override
  Future<List<PostConfiguration>> loadAllPosts() async {
    return [];
  }

  @override
  Future<PostConfiguration> loadMarkdownPostByPageId(String pageId) async {
    try {
      final reqUrl = '$baseUrl/posts/$pageId.md';
      final response = await client.get(reqUrl);
      final body = response.body;
      var post = await PostConfiguration.fromJson(json.decode(body));
      return post;
    } catch (e, s) {
      print(e);
      print(s);
    }
    return null;
  }

  @override
  Future<List<PostCategory>> loadTableOfContents() async {
    var allPosts = [];
    try {
      var reqUrl = '$baseUrl/';
      var response = await client.get(reqUrl);
      var body = response.body;
      List postsByCategory = json.decode(body);
      allPosts = postsByCategory.map((dynamic posts) => PostCategory.fromJson(posts)).toList();
      memCache.tableOfContents = allPosts;
      return allPosts;
    } catch (e) {
      print('Respoitory.LoadAllPostsByCategory.error: $e');
    }
  }
}
