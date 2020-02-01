import 'package:angular/angular.dart';
import 'package:web/src/components/mail_chimp_form_component.dart';
import 'package:web/src/components/social_links_component.dart';

@Component(
  selector: 'post-footer',
  templateUrl: 'post_footer_component.html',
  styleUrls: ['post_footer_component.css'],
  directives: [
    MailChimpFormComponent,
    SocialLinksComponent,
  ],
  providers: [],
  pipes: [],
)
class PostFooterComponent {}
