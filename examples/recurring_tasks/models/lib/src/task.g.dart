// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Task _$TaskFromJson(Map<String, dynamic> json) {
  return Task(
    description: json['description'] as String,
    assignee: json['assignee'] == null
        ? null
        : User.fromJson(json['assignee'] as Map<String, dynamic>),
    isComplete: json['isComplete'] as bool,
  );
}

Map<String, dynamic> _$TaskToJson(Task instance) => <String, dynamic>{
      'description': instance.description,
      'assignee': instance.assignee?.toJson(),
      'isComplete': instance.isComplete,
    };
