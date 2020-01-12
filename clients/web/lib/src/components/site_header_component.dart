import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';

@Component(
  selector: 'site-header',
  templateUrl: 'site_header_component.html',
  styleUrls: ['site_header_component.css'],
  directives: [routerDirectives],
  providers: [],
  pipes: [],
)
class SiteHeaderComponent {
  Router _router;
  SiteHeaderComponent(this._router);
  
  navigateHome() {
    _router.navigate("/");
  }
}
