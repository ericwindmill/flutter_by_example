import 'package:json_annotation/json_annotation.dart';

part 'post_frontmatter.g.dart';

@JsonSerializable()
class PostFrontmatter {
  String title;
  String author;
  String path; // i.e. "content/title_of_post"
  String category;
  String subSection;
  String createdAt;
  int order;
  List<String> tags;
  PostFrontmatter nextPost;
  PostFrontmatter previousPost;

  PostFrontmatter({
    this.title,
    this.author,
    this.path,
    this.category,
    this.subSection,
    this.order,
    this.tags,
    this.createdAt,
  }) {
    // original publish date for "we rate dogs" examples
    createdAt ??= DateTime(2018, 3, 18).toString();
  }

  DateTime get createAtDateTime => DateTime.parse(createdAt);

  factory PostFrontmatter.fromJson(Map<String, dynamic> json) => _$PostFrontmatterFromJson(json);
  Map<String, dynamic> toJson() => _$PostFrontmatterToJson(this);

  @override
  String toString() {
    return 'PostFrontmatter{title: $title, author: $author, path: $path, createdAt: $createdAt}';
  }
}
