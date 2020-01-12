import 'package:angular/angular.dart';

import 'package:angular_bloc/angular_bloc.dart';

import 'package:angular_router/angular_router.dart';
import 'package:common/common.dart';

@Component(
  selector: 'post-header',
  templateUrl: 'post_header_component.html',
  styleUrls: ['post_header_component.css'],
  directives: [NgIf, routerDirectives],
  providers: [],
  pipes: [BlocPipe, commonPipes],
)
class PostHeaderComponent implements OnInit {
  Router _router;

  PostHeaderComponent(this._router);

  bool get contentLoaded => (state is PageConfigurationBlocStateLoaded);

  @Input()
  PageConfigurationBlocState state;

  @override
  void ngOnInit() {}

  void navigateToHome() {
    _router.navigate("/");
  }
}
