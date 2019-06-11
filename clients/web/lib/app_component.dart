import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';
import 'package:common/common.dart';
import 'src/routes/route_paths.dart';
import 'src/routes/routes.dart';

@Component(
    selector: 'my-app',
    styleUrls: ['app_component.css'],
    template: '''
    <router-outlet [routes]="Routes.all"></router-outlet>
  ''',
    directives: [routerDirectives],
    providers: const [FilesystemBrowserPostsRepository],
    exports: [RoutePaths, Routes])
class AppComponent {}
