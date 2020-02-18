// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scheduled_task.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ScheduledTask _$ScheduledTaskFromJson(Map<String, dynamic> json) {
  return ScheduledTask(
    schedule: json['schedule'] == null
        ? null
        : Schedule.fromJson(json['schedule'] as Map<String, dynamic>),
    description: json['description'] as String,
    isComplete: json['isComplete'] as bool,
    assignee: json['assignee'] == null
        ? null
        : User.fromJson(json['assignee'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$ScheduledTaskToJson(ScheduledTask instance) =>
    <String, dynamic>{
      'description': instance.description,
      'assignee': instance.assignee?.toJson(),
      'isComplete': instance.isComplete,
      'schedule': instance.schedule?.toJson(),
    };
