import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class PageConfigurationBlocEvent extends Equatable {
  PageConfigurationBlocEvent([List props = const []]) : super(props);
}

class LoadSinglePage extends PageConfigurationBlocEvent {
  final String postId;

  LoadSinglePage(this.postId);
}

class LoadAllPageFrontmatter extends PageConfigurationBlocEvent {

}