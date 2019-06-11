import 'dart:io';
import 'package:angel_server/src/pretty_logging.dart';
import 'package:angel_server/angel_server.dart';
import 'package:angel_container/mirrors.dart';
import 'package:angel_framework/angel_framework.dart';
import 'package:angel_hot/angel_hot.dart';
import 'package:logging/logging.dart';

main() async {
  // Watch the config/ and web/ directories for changes, and hot-reload the server.
  hierarchicalLoggingEnabled = true;

  var hot = HotReloader(() async {
    var logger = Logger.detached('angel_server')
      ..level = Level.ALL
      ..onRecord.listen(prettyLog);
    var app = Angel(logger: logger, reflector: MirrorsReflector());
    await app.configure(configureServer);

    app.mimeTypeResolver
      ..addExtension('', 'text/plain')
      ..addExtension('dart', 'text/dart')
      ..addExtension('lock', 'text/plain')
      ..addExtension('markdown', 'text/plain')
      ..addExtension('md', 'text/plain')
      ..addExtension('yaml', 'text/plain');

    return app;
  }, [
    Directory('config'),
    Directory('lib'),
  ]);

  var server = await hot.startServer('127.0.0.1', 3000);
  print(
      'angel_server server listening at http://${server.address.address}:${server.port}');
}
