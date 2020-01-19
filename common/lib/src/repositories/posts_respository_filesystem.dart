import 'dart:convert';
import 'package:common/common.dart';
import 'package:http/http.dart';

import 'package:common/src/models/post_configuration.dart';
import 'package:common/src/repositories/posts_repository_base.dart';

//const String baseUrl = 'http://localhost:8888';
const String baseUrl = 'https://flutter-by-example-api.herokuapp.com';

class FilesystemBrowserPostsRepository extends PostRepository {
  Client client;

  FilesystemBrowserPostsRepository() {
    client = Client();
  }

  @override
  Future<List<PostConfiguration>> loadAllPosts() async {
    return [];
  }

  @override
  Future<PostConfiguration> loadMarkdownPostByPageId(String pageId) async {
    try {
      final reqUrl = "$baseUrl/posts/$pageId.md";
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
    List<PostCategory> allPosts = [];
    try {
      var reqUrl = "$baseUrl/";
      var response = await client.get(reqUrl);
      var body = response.body;
      List postsByCategory = json.decode(body);
      allPosts = postsByCategory.map((dynamic posts) => new PostCategory.fromJson(posts)).toList();
      return allPosts;
    } catch (e) {
      print("Respoitory.LoadAllPostsByCategory.error: $e");
    }
    return allPosts;
  }
}
