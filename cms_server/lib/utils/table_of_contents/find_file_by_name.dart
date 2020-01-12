import 'dart:io';

import 'package:aqueduct/aqueduct.dart';
import 'package:cms_server/utils/logging/pretty_log.dart';

Future<FileSystemEntity> findFileInFilesystemByFileName(
  Directory root,
  String targetPath,
) async {
  final List<Directory> queue = [];
  FileSystemEntity foundFile;

  try {
    final Stream<FileSystemEntity> files = root.list();
    await files.forEach((FileSystemEntity f) async {
      if (f is Directory) {
        queue.add(f);
      } else {
        final int segmentsCount = f.path.split("/").length;
        final String fileName = f.path.split("/")[segmentsCount - 1];
        if (targetPath == fileName) {
          foundFile = f;
        }
      }
    });
    while (queue.isNotEmpty && foundFile == null) {
      foundFile = await findFileInFilesystemByFileName(
        queue.removeLast(),
        targetPath,
      );
    }
  } catch (e, s) {
    prettyLog(LogRecord(
      Level.WARNING,
      "Error parsing filesystem",
      "TocBuilder.findFileInFilesystemByFileName",
      e,
      s,
    ));
  }
// if never found, this will be null
  return foundFile;
}
