import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:common/src/repositories/posts_repository_base.dart';
import './bloc.dart';

class TableOfContentsBloc
    extends Bloc<TableOfContentsEvent, TableOfContentsState> {
  final PostRepository repository;

  TableOfContentsBloc({this.repository});

  @override
  TableOfContentsState get initialState => InitialTableOfContentsState([]);

  @override
  Stream<TableOfContentsState> mapEventToState(
    TableOfContentsEvent event,
  ) async* {
    if (event is LoadTableOfContents) {
      var toc = await repository.loadAllPostsByCategory();
      yield new TableOfContentsLoadedState(toc);
    }
  }
}
