import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:common/src/repositories/posts_repository_base.dart';
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
      final toc = await repository.loadAllPostsByCategory();
      toc.forEach((postCategory) {
        print(postCategory);
        postCategory.subCategories.forEach((postSubCategory) {
          postSubCategory.posts.sort((a, b) => b.order);
        });
      });
      yield new TableOfContentsLoadedState(toc);
    }
  }
}
