import 'dart:io';

class PathUtils {
  static String getFileName(FileSystemEntity f) {
    var segments = f.uri.pathSegments;
    return segments[segments.length - 1];
  }

  static String removeFileExtension(String fileName) {
    // naive solution
    // Todo: implement a solution that works for all files
    var fileNameSplit = fileName.split(".");
    return fileNameSplit.getRange(0, fileNameSplit.length - 1).join("");
  }
}
