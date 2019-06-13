import 'package:common/common.dart';
import 'package:json_annotation/json_annotation.dart';

part 'post_categories.g.dart';

Map<String, int> postOrder = {
  "Dart": 1,
  "Flutter": 2,
  "AdvancedTopics": 3,
  "ExampleApp": 4,
  "etc": 5
};

@JsonSerializable()
class PostCategory {
  final String title;
  final String description;
  final int order;
  final List<PostSubCategory> subCategories;

  PostCategory(this.title, this.description, this.subCategories, this.order);

  factory PostCategory.fromJson(Map<String, dynamic> json) =>
      _$PostCategoryFromJson(json);
  Map<String, dynamic> toJson() => _$PostCategoryToJson(this);

  @override
  String toString() {
    return 'PostCategory{title: $title, description: $description, subCategories: $subCategories}';
  }
}

@JsonSerializable()
class PostSubCategory {
  final String title;
  final List<PostFrontmatter> posts;

  PostSubCategory(this.title, this.posts);

  factory PostSubCategory.fromJson(Map<String, dynamic> json) =>
      _$PostSubCategoryFromJson(json);
  Map<String, dynamic> toJson() => _$PostSubCategoryToJson(this);

  @override
  String toString() {
    return 'PostSubCategory{title: $title, posts: $posts}';
  }
}
