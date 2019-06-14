import 'dart:io';

class PathUtils {
  static FilePath getFileName(FileSystemEntity f) {
    var segments = f.uri.pathSegments;

    return FilePath(
      segments[segments.length - 1],
      segments.getRange(1, segments.length - 1).toList(),
    );
  }

  static String removeFileExtension(String fileName) {
    // naive solution
    // Todo: implement a solution that works for all files
    var fileNameSplit = fileName.split(".");
    return fileNameSplit.getRange(0, fileNameSplit.length - 1).join("");
  }
}

class FilePath {
  final String fileName;
  final List<String> subDirs;

  FilePath(this.fileName, this.subDirs);
}
