import 'dart:convert';
import 'package:http/http.dart';

import 'package:common/src/models/post_configuration.dart';
import 'package:common/src/repositories/posts_repository_base.dart';

class FilesystemBrowserPostsRepository extends PostRepository {
  Client client;
  FilesystemBrowserPostsRepository() {
    client = new Client();
  }

  @override
  Future<List<PostConfiguration>> loadAllPosts() {
    // TODO: implement loadAllPosts
    return null;
  }

  @override
  Future<PostConfiguration> loadPostByPageId(String pageId) async {
    var reqUrl = "http://localhost:3000/content/$pageId.md";
    print(reqUrl);
    var response = await client.get(reqUrl);
    var body = response.body;
    return new PostConfiguration.fromJson(json.decode(body));
  }
}
