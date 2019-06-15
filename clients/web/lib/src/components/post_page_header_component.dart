import 'dart:html';

import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';

import 'package:angular_bloc/angular_bloc.dart';
import 'package:common/common.dart';

@Component(
  selector: 'post-page-header',
  templateUrl: 'post_page_header_component.html',
  styleUrls: ['post_page_header_component.css'],
  directives: [],
  providers: [],
  pipes: [BlocPipe],
)
class PostPageHeaderComponent implements OnInit, OnDestroy {

  @override
  void ngOnInit() {}

  @override
  void ngOnDestroy() {}
}