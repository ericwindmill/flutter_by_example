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
      List<PostCategory> toc = await repository.loadAllPostsByCategory();

      toc.forEach((postCategory) {
        postCategory.subCategories.sort((a, b) {
          final aOrder = SubCategoriesOrder.fromString(a.title) ?? 0;
          final bOrder = SubCategoriesOrder.fromString(b.title) ?? 0;
          return aOrder.compareTo(bOrder);
        });

        postCategory.subCategories.forEach((postSubCategory) {
          postSubCategory.posts.sort((a, b) {
            return a.order.compareTo(b.order);
          });
        });
      });
      yield new TableOfContentsLoadedState(toc);
    }
  }
}
