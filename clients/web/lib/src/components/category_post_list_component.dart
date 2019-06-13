import 'dart:html';

import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';

import 'package:angular_bloc/angular_bloc.dart';
import 'package:angular_router/angular_router.dart';
import 'package:common/common.dart';
import 'package:web/src/routes/route_paths.dart';

@Component(
  selector: 'category-post-list',
  templateUrl: 'category_post_list_component.html',
  styleUrls: ['category_post_list_component.css'],
  directives: [
    NgIf,
    NgFor,
    MaterialListComponent,
    MaterialListItemComponent,
  ],
  providers: [],
  pipes: [BlocPipe],
)
class CategoryPostListComponent implements OnActivate {
  final Router _router;
  bool get contentLoaded => posts.isNotEmpty;

  @Input()
  List<PostFrontmatter> posts;

  CategoryPostListComponent(this._router);

  void onSelectPost(PostFrontmatter post) {
    var path = RoutePaths.post.toUrl(parameters: {idParam: post.path});
    _router.navigate(path);
  }

  @override
  void onActivate(RouterState previous, RouterState current) {
    print(this.posts);
  }
}
