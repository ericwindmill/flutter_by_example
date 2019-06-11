import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import '../models/models.dart';

@immutable
abstract class PageConfigurationBlocState extends Equatable {
  final PostConfiguration pageConfiguration;

  PageConfigurationBlocState(this.pageConfiguration, [List props = const []])
      : super(props);
}

class InitialPageConfigurationBlocState extends PageConfigurationBlocState {
  final PostConfiguration pageConfiguration;

  InitialPageConfigurationBlocState(this.pageConfiguration)
      : super(pageConfiguration, []);
}

class PageConfigurationBlocStateLoaded extends PageConfigurationBlocState {
  final PostConfiguration pageConfiguration;

  PageConfigurationBlocStateLoaded(this.pageConfiguration)
      : super(pageConfiguration, []);
}
