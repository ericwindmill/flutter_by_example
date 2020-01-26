// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_configuration.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostConfiguration _$PostConfigurationFromJson(Map<String, dynamic> json) {
  return PostConfiguration(
    id: json['id'] as String,
    frontmatter: json['frontmatter'] == null
        ? null
        : PostFrontmatter.fromJson(json['frontmatter'] as Map<String, dynamic>),
    content: json['content'] as String,
  );
}

Map<String, dynamic> _$PostConfigurationToJson(PostConfiguration instance) =>
    <String, dynamic>{
      'id': instance.id,
      'frontmatter': instance.frontmatter,
      'content': instance.content,
    };
