import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';
import 'package:angular_bloc/angular_bloc.dart';
import 'package:angular_router/angular_router.dart';
import 'package:web/src/app/blocs/post_configuration_bloc/bloc.dart';
import 'package:web/src/app/repositories/posts_respository_filesystem.dart';
import 'package:web/src/components/post_header_component.dart';
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
    routerDirectives
  ],
  providers: [FilesystemBrowserPostsRepository],
  pipes: [BlocPipe],
)
class PostPageComponent implements OnActivate, OnDestroy {
  PageConfigurationBloc pageBloc;
  final FilesystemBrowserPostsRepository _postsRepository;
  Location location;
  Router _router;

  PostPageComponent(this._postsRepository, this.location, this._router);

  @override
  void onActivate(_, RouterState current) async {
    pageBloc = PageConfigurationBloc(repository: _postsRepository);
    final id = getPostId(current.parameters);
    await pageBloc.dispatch(LoadSinglePage(id));
  }

  @override
  void ngOnDestroy() {
    pageBloc.dispose();
  }

  void navigateHome() {
    _router.navigate('/');
  }
}
