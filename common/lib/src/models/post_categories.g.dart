// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_categories.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostCategory _$PostCategoryFromJson(Map<String, dynamic> json) {
  return PostCategory(
      json['title'] as String,
      (json['posts'] as List)
          ?.map((e) => e == null
              ? null
              : PostFrontmatter.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

Map<String, dynamic> _$PostCategoryToJson(PostCategory instance) =>
    <String, dynamic>{'title': instance.title, 'posts': instance.posts};
