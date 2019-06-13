import 'dart:html';

import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';

import 'package:angular_bloc/angular_bloc.dart';
import 'package:angular_router/angular_router.dart';
import 'package:common/common.dart';
import 'package:web/src/components/category_post_list_component.dart';

@Component(
  selector: 'table-of-contents',
  templateUrl: 'table_of_contents_component.html',
  styleUrls: ['table_of_contents_component.css'],
  directives: [NgFor, NgIf, CategoryPostListComponent],
  providers: [],
  pipes: [BlocPipe],
)
class TableOfContentsComponent implements OnActivate  {
  bool get contentLoaded => (state is TableOfContentsLoadedState);

  @Input()
  TableOfContentsState state;

  TableOfContentsComponent() {
    print(state ?? "constructor null");
  }

  @override
  void onActivate(RouterState previous, RouterState current) {
    print(state.tableOfContents ?? "toc null");
  }

  @override
  void ngOnInit() {
    print(state?.tableOfContents ?? "oninit null");
  }
}
