import 'dart:convert';
import 'package:common/src/models/post_frontmatter.dart';
import 'package:http/http.dart';

import 'package:common/src/models/post_configuration.dart';
import 'package:common/src/repositories/posts_repository_base.dart';

class FilesystemBrowserPostsRepository extends PostRepository {
  Client client;

  FilesystemBrowserPostsRepository() {
    client = new Client();
  }

  @override
  Future<List<PostConfiguration>> loadAllPosts() async {
    return [];
  }

  @override
  Future<PostConfiguration> loadPostByPageId(String pageId) async {
    var reqUrl = "http://localhost:3000/content/$pageId.md";
    var response = await client.get(reqUrl);
    var body = response.body;
    return new PostConfiguration.fromJson(json.decode(body));
  }

  @override
  Future<List<PostFrontmatter>> loadAllPostsFrontmatter() async {
    var reqUrl = "http://localhost:3000/toc";
    var response = await client.get(reqUrl);
    var body = response.body;
    Iterable list = json.decode(body);
    return list.map((j) => new PostFrontmatter.fromJson(j)).toList();
  }
}
