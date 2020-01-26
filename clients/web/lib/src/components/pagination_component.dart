import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';
import 'package:angular_router/angular_router.dart';
import 'package:common/common.dart';

@Component(
  selector: 'pagination',
  templateUrl: 'pagination_component.html',
  styleUrls: ['pagination_component.css'],
  directives: [
    NgIf,
    MaterialIconComponent,
    RouterLink,
  ],
  providers: [],
  pipes: [],
)
class PaginationComponent {
  @Input()
  PostFrontmatter previous;

  @Input()
  PostFrontmatter next;

  PaginationComponent();
}
