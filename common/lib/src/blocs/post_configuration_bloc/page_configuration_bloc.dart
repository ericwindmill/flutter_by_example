import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:common/common.dart';
import 'package:common/src/blocs/post_configuration_bloc/page_configuration_event.dart';
import 'package:common/src/repositories/posts_repository_base.dart';
import 'package:common/src/blocs/post_configuration_bloc/bloc.dart';

class PageConfigurationBloc
    extends Bloc<PageConfigurationBlocEvent, PageConfigurationBlocState> {
  final PostRepository repository;

  PageConfigurationBloc({this.repository});

  @override
  PageConfigurationBlocState get initialState =>
      InitialPageConfigurationBlocState(
        new PostConfiguration(
            id: "post_one",
            frontmatter: new PostFrontmatter(title: "PostOne", author: "Eric"),
            content: "# test post \n # yeeeet"),
      );

  @override
  Stream<PageConfigurationBlocState> mapEventToState(
    PageConfigurationBlocEvent event,
  ) async* {
    if (event is LoadSinglePage) {
      var postConfig = await repository.loadMarkdownPostByPageId(event.postId);
      yield new PageConfigurationBlocStateLoaded(postConfig);
    }
  }
}
