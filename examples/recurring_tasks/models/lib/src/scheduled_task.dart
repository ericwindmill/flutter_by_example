import 'package:json_annotation/json_annotation.dart';
import 'package:models/src/schedule.dart';
import 'package:models/src/task.dart';
import 'package:models/src/user.dart';

part 'scheduled_task.g.dart';

@JsonSerializable()
class ScheduledTask extends Task {
  final Schedule schedule;

  ScheduledTask({
    this.schedule,
    String description,
    bool isComplete = false,
    User assignee,
  }) : super(
          description: description,
          assignee: assignee,
          isComplete: isComplete,
        );

  factory ScheduledTask.fromJson(Map<String, dynamic> json) => _$ScheduledTaskFromJson(json);
  Map<String, dynamic> toJson() => _$ScheduledTaskToJson(this);
}
