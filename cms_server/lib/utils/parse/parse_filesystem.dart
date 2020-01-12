import 'dart:io';

/// turn a tree of files into a flat list of files
Future<List<FileSystemEntity>> parseFilesystem(Directory root) async {
  final List<FileSystemEntity> returnFiles = [];
  final List<Directory> queue = [];
  try {
    final Stream<FileSystemEntity> files = root.list().asBroadcastStream();
    await for (FileSystemEntity f in files) {
      if (f is Directory) {
        queue.add(f);
      } else {
        returnFiles.add(f);
      }
    }

    while (queue.isNotEmpty) {
      final List<FileSystemEntity> subDirFiles = await parseFilesystem(queue.removeLast());
      returnFiles.addAll(subDirFiles);
    }
  } catch (error, stacktrace) {
    print(error);
    print(stacktrace);
  }

  return returnFiles;
}
