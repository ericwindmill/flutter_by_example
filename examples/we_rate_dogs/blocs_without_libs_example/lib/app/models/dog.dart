import 'package:uuid/uuid.dart';

class Dog {
  final String id;
  final String name;
  final String location;
  final String description;
  String imageUrl;
  int rating = 10;

  Dog({
    this.name,
    this.location,
    this.description,
    this.imageUrl,
  }) : id = Uuid().v4();

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Dog &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          imageUrl == other.imageUrl &&
          rating == other.rating;

  @override
  int get hashCode => name.hashCode ^ imageUrl.hashCode ^ rating.hashCode;
}
