import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';
import 'package:web/src/app/repositories/posts_respository_filesystem.dart';
import 'package:web/src/app/repositories/table_of_contents_mem_cache.dart';
import 'package:web/src/components/site_header_component.dart';
import 'src/routes/route_paths.dart';
import 'src/routes/routes.dart';

@Component(selector: 'my-app', styleUrls: [
  'app_component.css',
], template: '''
    <router-outlet [routes]="Routes.all"></router-outlet>
  ''', directives: [
  routerDirectives,
  SiteHeaderComponent
], providers: [
  FilesystemBrowserPostsRepository,
  MemCache
], exports: [
  RoutePaths,
  Routes
])
class AppComponent {}
