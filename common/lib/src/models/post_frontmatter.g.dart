// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_frontmatter.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostFrontmatter _$PostFrontmatterFromJson(Map<String, dynamic> json) {
  return PostFrontmatter(
      title: json['title'] as String, author: json['author'] as String)
    ..createdAt = json['createdAt'] == null
        ? null
        : DateTime.parse(json['createdAt'] as String);
}

Map<String, dynamic> _$PostFrontmatterToJson(PostFrontmatter instance) =>
    <String, dynamic>{
      'title': instance.title,
      'author': instance.author,
      'createdAt': instance.createdAt?.toIso8601String()
    };
