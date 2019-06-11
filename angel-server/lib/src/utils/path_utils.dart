import 'dart:io';

class PathUtils {
  static String getFileName(FileSystemEntity f) {
    var segments = f.uri.pathSegments;
    return segments[segments.length - 1];
  }
}
