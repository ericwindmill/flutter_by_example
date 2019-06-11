import 'package:angular_router/angular_router.dart';

const idParam = 'id';

class RoutePaths {
  static final posts = new RoutePath(path: "posts");
  static final post = new RoutePath(path: "posts/:$idParam");
}

String getPostId(Map<String, String> parameters) {
  final id = parameters[idParam];
  print(id);
  return id == null ? null : id;
}
