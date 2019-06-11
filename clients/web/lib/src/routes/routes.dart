import 'package:angular_router/angular_router.dart';
import 'package:web/src/routes/route_paths.dart';
import '../pages/post_page_component.template.dart' as post_page_component;

class Routes {
  static final posts = RouteDefinition(
    routePath: RoutePaths.posts,
    component: post_page_component.PostPageComponentNgFactory,
  );
  static final post = RouteDefinition(
    routePath: RoutePaths.post,
    component: post_page_component.PostPageComponentNgFactory,
  );
  static final all = <RouteDefinition>[post, posts];
}
