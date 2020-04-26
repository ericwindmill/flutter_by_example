import 'package:angular/angular.dart';

import 'package:angular_bloc/angular_bloc.dart';

import 'package:angular_router/angular_router.dart';
import 'package:web/src/app/blocs/post_configuration_bloc/page_configuration_state.dart';
import 'package:web/src/components/slim_nav_header_component.dart';

@Component(
  selector: 'post-header',
  templateUrl: 'post_header_component.html',
  styleUrls: ['post_header_component.css'],
  directives: [
    NgIf,
    routerDirectives,
    SlimNavHeaderComponent,
  ],
  providers: [],
  pipes: [BlocPipe, commonPipes],
)
class PostHeaderComponent {
  PostHeaderComponent();

  bool get contentLoaded => (state is PageConfigurationBlocStateLoaded);

  @Input()
  PageConfigurationBlocState state;
}
