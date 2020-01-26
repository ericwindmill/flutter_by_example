import 'package:common/src/models/models.dart';

class MemCache {
  static final MemCache _instance = MemCache._();

  List<PostCategory> tableOfContents = [];

  List<PostFrontmatter> get flatTableOfContents {
    return tableOfContents.expand((f) {
      return f.subCategories.expand((s) {
        return s.posts;
      }).toList();
    }).toList();
  }

  factory MemCache() {
    return _instance;
  }

  MemCache._();

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MemCache &&
          runtimeType == other.runtimeType &&
          tableOfContents == other.tableOfContents;

  @override
  int get hashCode => tableOfContents.hashCode;
}
