import 'package:cms_server/cms_server.dart';
import 'package:cms_server/utils/logging/pretty_log.dart';
import 'package:cms_server/utils/parse/parse_frontmatter.dart';
import 'package:cms_server/utils/table_of_contents/find_file_by_name.dart';

const String rootContentDirectory = 'public/content/';

class ContentController extends Controller {
  @override
  FutureOr<RequestOrResponse> handle(Request request) async {
    try {
      prettyLog(LogRecord(Level.WARNING, 'WTF', 'DOUBLE'));
      final rootDir = Directory.fromUri(Uri(path: rootContentDirectory));
      final fileName = request.path.segments.last;
      final FileSystemEntity foundFile = await findFileInFilesystemByFileName(rootDir, fileName);
      if (foundFile == null) prettyLog(LogRecord(Level.WARNING, 'WTF', 'file not found'));
      final file = File(foundFile.path);
      final content = file.readAsStringSync();
      final postConfig = buildPost(content, file.path);
      return Response.ok(postConfig.toJson())..contentType = ContentType.json;
    } catch (e, s) {
      prettyLog(LogRecord(
        Level.WARNING,
        'Error finding file by name',
        'ContentController.handle',
        e,
        s,
      ));
      return Response.notFound();
    }
  }
}
