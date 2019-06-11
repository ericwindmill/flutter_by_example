import 'dart:html';

import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';

import 'package:angular_bloc/angular_bloc.dart';
import 'package:common/common.dart';

@Component(
  selector: 'post-header',
  templateUrl: 'post_header_component.html',
  styleUrls: ['post_header_component.css'],
  directives: [NgIf],
  providers: [],
  pipes: [BlocPipe],
)
class PostHeaderComponent implements OnInit {
  bool get contentLoaded => (state is PageConfigurationBlocStateLoaded);

  @Input()
  PageConfigurationBlocState state;

  @override
  void ngOnInit() {}
}
