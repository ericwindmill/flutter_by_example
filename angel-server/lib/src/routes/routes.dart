library angel_server.src.routes;

import 'dart:convert';
import 'dart:io' as prefix0;

import 'package:angel_framework/angel_framework.dart';
import 'package:angel_server/src/pretty_logging.dart';
import 'package:angel_server/src/utils/extract_frontmatter.dart';
import 'package:angel_server/src/utils/path_utils.dart';
import 'package:angel_static/angel_static.dart';
import 'package:common/common.dart';
import 'package:file/file.dart';
import 'package:angel_cors/angel_cors.dart';
import 'package:logging/logging.dart';
import 'controllers/controllers.dart' as controllers;

AngelConfigurer configureServer(FileSystem fileSystem) {
  return (Angel app) async {
    await app.configure(controllers.configureServer);
    app.fallback(cors());

    app.get('/', (req, res) => res.render('hello'));

    var vDir =
        VirtualDirectory(app, fileSystem, source: fileSystem.directory('web'),
            callback: (File f, RequestContext req, ResponseContext resp) async {
      String content = await f.readAsString();
      PostConfiguration post = buildPost(content, req.path);
      return post;
    });

    /// This service returns all posts, but they're grouped by category
    /// naive
    /// todo: support sub-directories in the "web/content" dir
    ///
    /// todo: posts should be grouped by category: Dart, Flutter, Advanced, Example
    /// todo:   AND by sub-category (i.e. Dart: Async, or Example: Redux-Auth
    ///
    app.get('/toc', (req, res) async {
      Map<String, PostCategory> posts = <String, PostCategory>{};
      await vDir.source
          .childDirectory("content")
          .list()
          .forEach((FileSystemEntity f) async {
        File file;
        try {
          var fileName = PathUtils.getFileName(f);
          file = vDir.source.childDirectory("content").childFile(fileName);
          String content = file.readAsStringSync();
          PostFrontmatter frontmatter = extractFrontmatterOnly(
              content, PathUtils.removeFileExtension(fileName));
          posts.putIfAbsent(frontmatter.category,
              () => PostCategory(frontmatter.category, [frontmatter]));
        } catch (e, s) {
          prettyLog(LogRecord(Level.WARNING, "Error reading files for toc",
              "App.get.toc", e, s));
        }
      });
      List<PostCategory> asList = posts.values.toList();
      return asList;
    });

    app.fallback(vDir.handleRequest);

    app.fallback((req, res) => throw AngelHttpException.notFound());

    var oldErrorHandler = app.errorHandler;
    app.errorHandler = (e, req, res) async {
      if (req.accepts('text/html', strict: true)) {
        if (e.statusCode == 404 && req.accepts('text/html', strict: true)) {
          await res
              .render('error', {'message': 'No file exists at ${req.uri}.'});
        } else {
          await res.render('error', {'message': e.message});
        }
      } else {
        return await oldErrorHandler(e, req, res);
      }
    };
  };
}
