import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:common/common.dart';
import 'package:common/src/repositories/posts_repository_base.dart';
import 'package:common/src/utils/path_utils.dart';
import './bloc.dart';

class TableOfContentsBloc extends Bloc<TableOfContentsEvent, TableOfContentsState> {
  final PostRepository repository;

  TableOfContentsBloc({this.repository});

  @override
  TableOfContentsState get initialState => InitialTableOfContentsState([]);

  @override
  Stream<TableOfContentsState> mapEventToState(
    TableOfContentsEvent event,
  ) async* {
    if (event is LoadTableOfContents) {
      List<PostCategory> allPosts = await repository.loadTableOfContents();
      List<PostCategory> sorted = sortPosts(allPosts);
      yield new TableOfContentsLoadedState(sorted);
    }
  }
}
