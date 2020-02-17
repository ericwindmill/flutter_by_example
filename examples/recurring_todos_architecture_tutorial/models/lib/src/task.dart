import 'package:models/src/user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'task.g.dart';

@JsonSerializable()
class Task {
  Task({
    this.description,
    this.assignee,
    this.isComplete,
  });

  final String description;
  final User assignee;
  final bool isComplete;

  factory Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);
  Map<String, dynamic> toJson() => _$TaskToJson(this);
}
