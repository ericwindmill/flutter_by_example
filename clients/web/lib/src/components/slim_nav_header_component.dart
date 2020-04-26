import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';

@Component(
  selector: 'slim-nav-header',
  templateUrl: 'slim_nav_header_component.html',
  styleUrls: ['slim_nav_header_component.css'],
  directives: [NgIf, routerDirectives],
  providers: [],
  pipes: [commonPipes],
)
class SlimNavHeaderComponent {
  final Router _router;

  SlimNavHeaderComponent(this._router);

  void navigateToHome() {
    _router.navigate('/');
  }
}
