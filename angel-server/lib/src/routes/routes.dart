library angel_server.src.routes;

import 'package:angel_framework/angel_framework.dart';
import 'package:angel_server/src/utils/extract_frontmatter.dart';
import 'package:angel_static/angel_static.dart';
import 'package:common/common.dart';
import 'package:file/file.dart';
import 'package:angel_cors/angel_cors.dart';
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
