import 'package:angular/angular.dart';
import 'package:angular_bloc/angular_bloc.dart';
import 'package:angular_components/angular_components.dart';
import 'package:common/common.dart';
import 'package:web/src/app/blocs/post_configuration_bloc/page_configuration_state.dart';
import 'package:web/src/components/pagination_component.dart';
import 'package:web/src/components/post_footer_component.dart';
import 'package:web/src/directives/markdown_directive.dart';

@Component(
  selector: 'markdown-content',
  templateUrl: 'markdown_content_component.html',
  styleUrls: ['markdown_content_component.css'],
  directives: [
    MarkdownDirective,
    NgIf,
    PostFooterComponent,
    PaginationComponent,
    MaterialSpinnerComponent,
  ],
  providers: [],
  pipes: [BlocPipe],
)
class MarkdownContentComponent {
  bool get contentLoaded {
    print(state);
    return (state is PageConfigurationBlocStateLoaded);
  }

  @Input()
  PageConfigurationBlocState state;

  PostFrontmatter get previous {
    return state.pageConfiguration.frontmatter.previousPost;
  }

  PostFrontmatter get next {
    return state.pageConfiguration.frontmatter.nextPost;
  }

  MarkdownContentComponent();
}
