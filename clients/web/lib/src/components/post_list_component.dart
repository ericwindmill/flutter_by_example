import 'dart:html';

import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';

import 'package:angular_bloc/angular_bloc.dart';
import 'package:common/common.dart';

@Component(
  selector: 'post-list',
  templateUrl: 'post_list_component.html',
  styleUrls: ['post_list_component.css'],
  directives: [NgIf, NgFor],
  providers: [],
  pipes: [BlocPipe],
)
class PostListComponent implements OnInit, OnDestroy {
  bool get contentLoaded => (state is AllPageFrontmatterStateLoaded);

  @Input()
  PageConfigurationBlocState state;

  PostListComponent();

  @override
  void ngOnInit() {}

  @override
  void ngOnDestroy() {}
}
