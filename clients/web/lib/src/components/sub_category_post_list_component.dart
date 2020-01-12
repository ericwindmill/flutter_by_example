import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';

import 'package:angular_bloc/angular_bloc.dart';
import 'package:angular_router/angular_router.dart';
import 'package:common/common.dart';
import 'package:web/src/routes/route_paths.dart';

@Component(
  selector: 'sub-category-post-list',
  templateUrl: 'sub_category_post_list_component.html',
  styleUrls: ['sub_category_post_list_component.css'],
  directives: [
    NgIf,
    NgFor,
    MaterialListComponent,
    MaterialListItemComponent,
  ],
  providers: [],
  pipes: [BlocPipe],
)
class SubCategoryPostListComponent {
  Router _router;
  bool get contentLoaded => (posts.isNotEmpty);

  SubCategoryPostListComponent(this._router);

  @Input()
  List<PostFrontmatter> posts;

  void onSelectPost(PostFrontmatter post) {
    var path = RoutePaths.post.toUrl(parameters: {idParam: post.path});
    _router.navigate(path);
  }
}
