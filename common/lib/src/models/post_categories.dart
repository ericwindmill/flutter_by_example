import 'package:common/common.dart';
import 'package:json_annotation/json_annotation.dart';

part 'post_categories.g.dart';

@JsonSerializable()
class PostCategory {
  final String title;
  final List<PostFrontmatter> posts;

  PostCategory(this.title, this.posts);

  factory PostCategory.fromJson(Map<String, dynamic> json) =>
      _$PostCategoryFromJson(json);
  Map<String, dynamic> toJson() => _$PostCategoryToJson(this);
}
