import 'package:json_annotation/json_annotation.dart';

part 'post_frontmatter.g.dart';

@JsonSerializable()
class PostFrontmatter {
  String title;
  String author;
  String path; // i.e. "content/title_of_post"
  String category;
  DateTime createdAt;

  PostFrontmatter({this.title, this.author, this.path, this.category}) {
    createdAt = DateTime.now();
  }

  factory PostFrontmatter.fromJson(Map<String, dynamic> json) =>
      _$PostFrontmatterFromJson(json);
  Map<String, dynamic> toJson() => _$PostFrontmatterToJson(this);

  @override
  String toString() {
    return 'PostFrontmatter{title: $title, author: $author, path: $path, createdAt: $createdAt}';
  }
}
