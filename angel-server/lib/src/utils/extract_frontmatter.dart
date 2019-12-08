import 'package:common/common.dart';
import 'package:yaml/yaml.dart';

/// todo: validate frontmatter!
/// ensure that:
///  each field is included and correct
///  the "category" and "subcategory" are valid options
///

PostFrontmatter extractFrontmatterOnly(String fileContents, String path) {
  const separator = '---';
  var lines = fileContents.split('\n');
  if (!lines.first.startsWith(separator)) return null;
  int first;
  int last;
  for (var i = 0; i < lines.length; i++) {
    if (lines[i].startsWith(separator)) {
      if (first == null) {
        first = i;
        continue;
      }
      last = i;
      continue;
    }
  }
  if (first == null || last == null) return null;
  var yamlStr = lines.getRange(first + 1, last).join('\n');
  var yaml = loadYaml(yamlStr);
  if (yaml is! Map) {
    throw ('unexpected metadata');
  }

  PostFrontmatter frontmatter = PostFrontmatter(
    author: (yaml["author"] ?? "No author") as String,
    title: (yaml["title"] ?? "No title") as String,
    category: (yaml["category"] ?? "No title") as String,
    subSection: (yaml["subSection"] ?? "No subsection") as String,
    order: (yaml["order"] ?? -1) as int,
    createdAt: (yaml["createdAt"]) as String,
    path: path,
  );

  return frontmatter;
}

PostConfiguration buildPost(String fileContents, String path) {
  const separator = '---';
  var lines = fileContents.split('\n');
  if (!lines.first.startsWith(separator)) return null;
  int first;
  int last;
  for (var i = 0; i < lines.length; i++) {
    if (lines[i].startsWith(separator)) {
      if (first == null) {
        first = i;
        continue;
      }
      last = i;
      continue;
    }
  }
  if (first == null || last == null) return null;
  var yamlStr = lines.getRange(first + 1, last).join('\n');
  var yaml = loadYaml(yamlStr);
  if (yaml is! Map) {
    throw ('unexpected metadata');
  }

  var mdContent = lines.getRange(last + 1, lines.length).join('\n');

  PostFrontmatter frontmatter = PostFrontmatter(
    author: (yaml["author"] ?? "No author") as String,
    title: (yaml["title"] ?? "No title") as String,
    category: (yaml["category"] ?? "No title") as String,
    subSection: (yaml["subSection"] ?? "No subsection") as String,
    order: (yaml["order"] ?? -1) as int,
    createdAt: (yaml["createdAt"]) as String,
    path: path,
  );

  lines.removeRange(first, last + 1);
  return PostConfiguration(content: mdContent, frontmatter: frontmatter, id: path);
}
