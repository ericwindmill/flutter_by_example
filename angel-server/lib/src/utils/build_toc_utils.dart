import 'dart:io' as prefix0;

import 'package:angel_server/src/utils/path_utils.dart';
import 'package:file/file.dart';

import 'package:angel_static/angel_static.dart';
import 'package:logging/logging.dart';

import '../pretty_logging.dart';

class TableOfContentsBuilder {
  static Future<List<FileSystemEntity>> build(VirtualDirectory vDir) async {
    Directory root = await vDir.source.childDirectory("content");
    List<FileSystemEntity> posts = await _parseFilesystem(root);
    return posts;
  }

  static File buildFilePath(FileSystemEntity f, VirtualDirectory vDir) {
    try {
      FilePath filePath = PathUtils.getFileName(f);
      var dir = vDir.source;
      for (var subDir in filePath.subDirs) {
        dir = dir.childDirectory(subDir);
      }
      return dir.childFile(filePath.fileName);
    } catch (e, s) {
      prettyLog(LogRecord(
        Level.WARNING,
        "Error building file path",
        "TocBuilder._buildFilePath",
        e,
        s,
      ));
    }
    return null;
  }

  static Future<FileSystemEntity> findFileInFilesystemByFileName(
      Directory root, String targetPath) async {
    List<Directory> queue = [];
    FileSystemEntity foundFile;
    try {
      Stream<FileSystemEntity> files = root.list();
      await files.forEach((FileSystemEntity f) async {
        if (f is Directory) {
          queue.add(f);
        } else {
          int segmentsCount = f.path.split("/").length;
          String fileName = f.path.split("/")[segmentsCount - 1];
          if (targetPath == fileName) {
            foundFile = f;
          }
          ;
        }
      });
      if (queue.isNotEmpty && foundFile == null) {
        foundFile = await findFileInFilesystemByFileName(
            queue.removeLast(), targetPath);
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

  static Future<List<FileSystemEntity>> _parseFilesystem(Directory root) async {
    List<FileSystemEntity> returnFiles = [];
    List<Directory> queue = [];
    try {
      Stream<FileSystemEntity> files = root.list();
      await files.forEach((FileSystemEntity f) async {
        if (f is Directory) {
          queue.add(f);
        } else {
          returnFiles.add(f);
        }
      });

      if (queue.isNotEmpty) {
        List<FileSystemEntity> subDirFiles =
            await _parseFilesystem(queue.removeLast());
        returnFiles.addAll(subDirFiles);
      }

      return returnFiles;
    } catch (e, s) {
      prettyLog(LogRecord(
        Level.WARNING,
        "Error parsing filesystem",
        "TocBuilder._parseFilesystem",
        e,
        s,
      ));
    }
    return [];
  }
}
