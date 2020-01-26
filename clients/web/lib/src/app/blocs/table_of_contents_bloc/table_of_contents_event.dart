import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class TableOfContentsEvent extends Equatable {
  TableOfContentsEvent([List props = const []]) : super(props);
}

class LoadTableOfContents extends TableOfContentsEvent {}

