import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';
import 'package:angular_bloc/angular_bloc.dart';
import 'package:angular_router/angular_router.dart';
import 'package:common/common.dart';
import 'package:web/src/components/post_header_component.dart';
import 'package:web/src/components/post_page_header_component.dart';
import 'package:web/src/directives/markdown_directive.dart';
import 'package:web/src/components/markdown_content_component.dart';
import 'package:web/src/routes/route_paths.dart';

@Component(
  selector: 'post-page',
  templateUrl: 'post_page_component.html',
  styleUrls: ['post_page_component.css'],
  directives: [
    MaterialFabComponent,
    MarkdownDirective,
    MarkdownContentComponent,
    NgIf,
    PostHeaderComponent,
    PostPageHeaderComponent,
  ],
  providers: [FilesystemBrowserPostsRepository],
  pipes: [BlocPipe],
)
class PostPageComponent implements OnActivate, OnDestroy {
  PageConfigurationBloc pageBloc;
  final FilesystemBrowserPostsRepository _postsRepository;
  Location location;

  PostPageComponent(this._postsRepository, this.location);

  @override
  void onActivate(_, RouterState current) async {
    pageBloc = new PageConfigurationBloc(repository: _postsRepository);
    final id = getPostId(current.parameters);
    await pageBloc.dispatch(new LoadSinglePage(id));
  }

  @override
  void ngOnDestroy() {
    pageBloc.dispose();
  }
}
