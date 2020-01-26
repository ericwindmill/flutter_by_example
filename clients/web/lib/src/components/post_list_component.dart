import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';

import 'package:angular_bloc/angular_bloc.dart';
import 'package:angular_router/angular_router.dart';
import 'package:common/common.dart';
import 'package:web/src/app/blocs/post_configuration_bloc/page_configuration_state.dart';
import 'package:web/src/routes/route_paths.dart';

@Component(
  selector: 'post-list',
  templateUrl: 'post_list_component.html',
  styleUrls: ['post_list_component.css'],
  directives: [
    NgIf,
    NgFor,
    MaterialListComponent,
    MaterialListItemComponent,
  ],
  providers: [],
  pipes: [BlocPipe],
)
class PostListComponent {
  final Router _router;
  bool get contentLoaded => (state is AllPageFrontmatterStateLoaded);

  @Input()
  PageConfigurationBlocState state;

  PostListComponent(this._router);

  void onSelectPost(PostFrontmatter post) {
    var path = RoutePaths.post.toUrl(parameters: {idParam: post.path});
    _router.navigate(path);
  }
}
