import 'package:angular/angular.dart';
import 'package:angular_bloc/angular_bloc.dart';
import 'package:angular_components/angular_components.dart';
import 'package:common/common.dart';
import 'package:web/src/directives/markdown_directive.dart';

import 'mail_chimp_form_component.dart';

@Component(
  selector: 'markdown-content',
  templateUrl: 'markdown_content_component.html',
  styleUrls: ['markdown_content_component.css'],
  directives: [
    MarkdownDirective,
    NgIf,
    MailChimpFormComponent,
    MaterialSpinnerComponent,
  ],
  providers: [],
  pipes: [BlocPipe],
)
class MarkdownContentComponent {
  bool get contentLoaded => (state is PageConfigurationBlocStateLoaded);

  @Input()
  PageConfigurationBlocState state;

  MarkdownContentComponent();
}
