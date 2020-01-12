import 'package:calendar_app_repository/calendar_app_repository.dart';

class Task {
  Task(
    this.description, {
    this.complete = false,
    this.repeatingDays,
    this.lastCompleted,
    this.dueDate,
    this.isRepeating = false,
  }) {
    repeatingDays ??= {};
  }

  final String description;
  final bool complete;
  final DateTime lastCompleted;
  final DateTime dueDate;
  Set<DayOfWeek> repeatingDays;
  final bool isRepeating;

  int get daysSinceLastCompleted {
    if (lastCompleted == null) return 0;
    return DateTime.now().difference(lastCompleted).inDays;
  }

  Task toggleComplete() => copyWith(complete: !complete);

  Task copyWith({
    String description,
    bool complete,
    DateTime lastCompleted,
    DateTime dueDate,
    Set<DayOfWeek> repeatingDays,
    bool isRepeating,
  }) {
    return Task(
      description ?? this.description,
      complete: complete ?? this.complete,
      isRepeating: isRepeating ?? this.isRepeating,
      lastCompleted: lastCompleted ?? this.lastCompleted,
      repeatingDays: repeatingDays ?? this.repeatingDays,
      dueDate: dueDate ?? this.dueDate,
    );
  }
}
