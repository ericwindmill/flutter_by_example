import 'dart:html';

import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';

import 'package:angular_bloc/angular_bloc.dart';
import 'package:angular_router/angular_router.dart';
import 'package:common/common.dart';
import 'package:web/src/routes/route_paths.dart';

import 'sub_category_post_list_component.dart';

@Component(
  selector: 'category-post-list',
  templateUrl: 'category_post_list_component.html',
  styleUrls: ['category_post_list_component.css'],
  directives: [
    NgIf,
    NgFor,
    SubCategoryPostListComponent,
  ],
  providers: [],
  pipes: [BlocPipe],
)
class CategoryPostListComponent {
  bool get contentLoaded => subCategories?.isNotEmpty;

  @Input()
  List<PostSubCategory> subCategories;

  CategoryPostListComponent();
}
