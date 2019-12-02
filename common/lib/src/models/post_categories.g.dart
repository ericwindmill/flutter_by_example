// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_categories.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostCategory _$PostCategoryFromJson(Map<String, dynamic> json) {
  return PostCategory(
      title: json['title'] as String,
      description: json['description'] as String,
      subCategories: (json['subCategories'] as List)
          ?.map((e) => e == null
              ? null
              : PostSubCategory.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      order: json['order'] as int);
}

Map<String, dynamic> _$PostCategoryToJson(PostCategory instance) =>
    <String, dynamic>{
      'title': instance.title,
      'description': instance.description,
      'order': instance.order,
      'subCategories': instance.subCategories
    };

PostSubCategory _$PostSubCategoryFromJson(Map<String, dynamic> json) {
  return PostSubCategory(
      title: json['title'] as String,
      posts: (json['posts'] as List)
          ?.map((e) => e == null
              ? null
              : PostFrontmatter.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

Map<String, dynamic> _$PostSubCategoryToJson(PostSubCategory instance) =>
    <String, dynamic>{'title': instance.title, 'posts': instance.posts};
