import 'package:common/common.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class TableOfContentsState extends Equatable {
  final List<PostCategory> tableOfContents;
  TableOfContentsState(this.tableOfContents, [List props = const []])
      : super(props);
}

class InitialTableOfContentsState extends TableOfContentsState {
  final List<PostCategory> tableOfContents;
  InitialTableOfContentsState(this.tableOfContents) : super(tableOfContents);
}

class TableOfContentsLoadedState extends TableOfContentsState {
  final List<PostCategory> tableOfContents;
  TableOfContentsLoadedState(this.tableOfContents) : super(tableOfContents);
}
