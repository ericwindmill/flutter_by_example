import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:common/common.dart';
import 'package:common/src/blocs/page_configuration_event.dart';
import 'package:common/src/repositories/posts_repository_base.dart';
import './bloc.dart';

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
      print("mapStateToEvent: $event");
      var postConfig = await repository.loadPostByPageId(event.postId);
      yield new PageConfigurationBlocStateLoaded(postConfig);
    } else if (event is LoadAllPageFrontmatter) {
      var frontmatters = await repository.loadAllPostsFrontmatter();
      yield new AllPageFrontmatterStateLoaded(null, frontmatters);
    }
  }
}
