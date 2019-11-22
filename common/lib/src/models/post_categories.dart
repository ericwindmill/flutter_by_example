import 'package:common/common.dart';
import 'package:json_annotation/json_annotation.dart';

part 'post_categories.g.dart';

// would love to see this in a yaml config. But not today.
class PostOrder {
  static const int Dart = 1;
  static const int Flutter = 2;
  static const int AdvancedTopics = 3;
  static const int ExampleApp = 4;
  static const int ETC = 5;

  static final Map<String, int> postOrder = {
    "Dart": PostOrder.Dart,
    "Flutter": PostOrder.Flutter,
    "AdvancedTopics": PostOrder.AdvancedTopics,
    "ExampleApp": PostOrder.ExampleApp,
    "etc": PostOrder.ETC,
  };

  static int fromString(String s) {
    return postOrder[s];
  }
}



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
