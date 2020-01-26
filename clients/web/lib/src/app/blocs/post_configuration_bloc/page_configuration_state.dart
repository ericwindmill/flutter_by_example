import 'package:common/common.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class PageConfigurationBlocState extends Equatable {
  final PostConfiguration pageConfiguration;
  final List<PostCategory> frontmatters;

  PageConfigurationBlocState(this.pageConfiguration, this.frontmatters, [List props = const []])
      : super(props);
}

class InitialPageConfigurationBlocState extends PageConfigurationBlocState {
  final PostConfiguration pageConfiguration;

  InitialPageConfigurationBlocState(this.pageConfiguration) : super(pageConfiguration, [], []);
}

class PageConfigurationBlocStateLoaded extends PageConfigurationBlocState {
  final PostConfiguration pageConfiguration;
  final bool paginationLoaded;

  PageConfigurationBlocStateLoaded(this.pageConfiguration, {this.paginationLoaded = false})
      : super(pageConfiguration, [], []);
}

class AllPageFrontmatterStateLoaded extends PageConfigurationBlocState {
  final List<PostCategory> postByCategory;
  AllPageFrontmatterStateLoaded(PostConfiguration pageConfiguration, this.postByCategory)
      : super(pageConfiguration, postByCategory);
}
