// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schedule.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Schedule _$ScheduleFromJson(Map<String, dynamic> json) {
  return Schedule(
    dueDate: json['dueDate'] == null
        ? null
        : DateTime.parse(json['dueDate'] as String),
    frequency: json['frequency'] == null
        ? null
        : Duration(microseconds: json['frequency'] as int),
  );
}

Map<String, dynamic> _$ScheduleToJson(Schedule instance) => <String, dynamic>{
      'dueDate': instance.dueDate?.toIso8601String(),
      'frequency': instance.frequency?.inMicroseconds,
    };
