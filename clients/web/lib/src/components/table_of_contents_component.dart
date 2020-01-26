import 'package:angular/angular.dart';
import 'package:angular_bloc/angular_bloc.dart';
import 'package:web/src/app/blocs/table_of_contents_bloc/table_of_contents_state.dart';
import 'package:web/src/components/category_post_list_component.dart';

@Component(
  selector: 'table-of-contents',
  templateUrl: 'table_of_contents_component.html',
  styleUrls: ['table_of_contents_component.css'],
  directives: [NgFor, NgIf, CategoryPostListComponent],
  providers: [],
  pipes: [BlocPipe],
)
class TableOfContentsComponent {
  bool get contentLoaded => (state is TableOfContentsLoadedState);

  @Input()
  TableOfContentsState state;

  TableOfContentsComponent();
}

