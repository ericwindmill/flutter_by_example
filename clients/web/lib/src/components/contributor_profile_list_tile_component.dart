import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';

@Component(
  selector: 'contributor-profile-list-tile',
  templateUrl: 'contributor_profile_list_tile_component.html',
  styleUrls: ['contributor_profile_list_tile_component.css'],
  directives: [MaterialIconComponent, NgIf, coreDirectives],
  providers: [],
  pipes: [],
)
class ContributorProfileListTile {
  @Input()
  String firstName;

  @Input()
  String lastName;

  @Input()
  String location;

  @Input()
  String imagePath;

  @Input()
  String twitter;

  @Input()
  String website;

  @Input()
  String github;

  String get avatar {
    return firstName[0] + lastName[0];
  }

  String get name => '$firstName $lastName';

  String get githubHref => 'https://github.com/$github';
  String get websiteHref => 'https://$website';
  String get twitterHref => 'https://twitter.com/$twitter';
}
