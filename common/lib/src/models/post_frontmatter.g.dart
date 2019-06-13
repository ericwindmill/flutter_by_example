// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_frontmatter.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostFrontmatter _$PostFrontmatterFromJson(Map<String, dynamic> json) {
  return PostFrontmatter(
      title: json['title'] as String,
      author: json['author'] as String,
      path: json['path'] as String,
      category: json['category'] as String)
    ..createdAt = json['createdAt'] == null
        ? null
        : DateTime.parse(json['createdAt'] as String);
}

Map<String, dynamic> _$PostFrontmatterToJson(PostFrontmatter instance) =>
    <String, dynamic>{
      'title': instance.title,
      'author': instance.author,
      'path': instance.path,
      'category': instance.category,
      'createdAt': instance.createdAt?.toIso8601String()
    };
