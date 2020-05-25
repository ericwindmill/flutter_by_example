import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:common/common.dart';
import 'package:web/src/app/repositories/posts_repository_base.dart';
import 'package:web/src/app/use_case/table_of_contents/pagination.dart';

import 'bloc.dart';

class PageConfigurationBloc extends Bloc<PageConfigurationBlocEvent, PageConfigurationBlocState> {
  final PostRepository repository;

  PageConfigurationBloc({this.repository});

  @override
  PageConfigurationBlocState get initialState => InitialPageConfigurationBlocState(
    PostConfiguration(
            id: '',
            frontmatter: PostFrontmatter(title: 'PostOne', author: 'Eric'),
            content: ''),
      );

  @override
  Stream<PageConfigurationBlocState> mapEventToState(
    PageConfigurationBlocEvent event,
  ) async* {
    if (event is LoadSinglePage) {
      var postConfig = await repository.loadMarkdownPostByPageId(event.postId);
      final pagination = Pagination.getForFrontmatter(postConfig.frontmatter);
      postConfig.frontmatter.previousPost = pagination.previousPost;
      postConfig.frontmatter.nextPost = pagination.nextPost;
      print('yielding');
      yield PageConfigurationBlocStateLoaded(postConfig);

    }
  }
}
