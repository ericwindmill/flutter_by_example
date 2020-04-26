import 'package:angular/angular.dart';
import 'package:web/src/components/contributor_profile_list_tile_component.dart';
import 'package:web/src/components/slim_nav_header_component.dart';

@Component(
  selector: 'contributors-page',
  templateUrl: 'contributors_page_component.html',
  styleUrls: ['contributors_page_component.css'],
  directives: [
    SlimNavHeaderComponent,
    ContributorProfileListTile,
  ],
  providers: [],
  pipes: [],
)
class ContributorsPageComponent {}
