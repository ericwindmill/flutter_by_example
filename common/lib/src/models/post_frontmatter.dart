
import 'package:json_annotation/json_annotation.dart';

part 'post_frontmatter.g.dart';

@JsonSerializable()
class PostFrontmatter {
  String title;
  String author;
  DateTime createdAt;

  PostFrontmatter({this.title, this.author}) {
    createdAt = DateTime.now();
  }

  factory PostFrontmatter.fromJson(Map<String, dynamic> json) => _$PostFrontmatterFromJson(json);
  Map<String, dynamic> toJson() => _$PostFrontmatterToJson(this);
}