import 'package:angular_router/angular_router.dart';

const idParam = 'id';

class RoutePaths {
  static final home = RoutePath(path: "/index", useAsDefault: true);
  static final posts = RoutePath(path: "posts");
  static final post = RoutePath(path: "posts/:$idParam");
  static final contributors = RoutePath(path: '/contributors');
}

String getPostId(Map<String, String> parameters) => parameters[idParam];
