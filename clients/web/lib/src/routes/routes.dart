import 'package:angular_router/angular_router.dart';
import 'package:web/src/routes/route_paths.dart';
import '../pages/post_page_component.template.dart' as post_page_component;
import '../pages/index_page_component.template.dart' as index_page_component;
import '../pages/contributors_page_component.template.dart' as contributors_page_component;

class Routes {
  static final home = RouteDefinition(
    routePath: RoutePaths.home,
    component: index_page_component.IndexPageComponentNgFactory,
  );
  static final posts = RouteDefinition(
    routePath: RoutePaths.posts,
    component: post_page_component.PostPageComponentNgFactory,
  );
  static final post = RouteDefinition(
    routePath: RoutePaths.post,
    component: post_page_component.PostPageComponentNgFactory,
  );
  static final contributors = RouteDefinition(
    routePath: RoutePaths.contributors,
    component: contributors_page_component.ContributorsPageComponentNgFactory,
  );
  static final all = <RouteDefinition>[home, post, posts, contributors];
}
