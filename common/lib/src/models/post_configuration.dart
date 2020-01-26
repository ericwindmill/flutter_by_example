import 'package:common/src/models/post_frontmatter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'post_configuration.g.dart';

@JsonSerializable()
class PostConfiguration {
  final String id;
  PostFrontmatter frontmatter;
  final String content;

  PostConfiguration({
    this.id,
    this.frontmatter,
    this.content,
  });

  factory PostConfiguration.fromJson(Map<String, dynamic> json) =>
      _$PostConfigurationFromJson(json);
  Map<String, dynamic> toJson() => _$PostConfigurationToJson(this);

  @override
  String toString() {
    return 'PostConfiguration{id: $id, frontmatter: $frontmatter, content: $content}';
  }
}
