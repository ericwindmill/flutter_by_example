import 'dart:async';

import 'package:calendar_app_repository/calendar_app_repository.dart';
import 'package:rxdart/rxdart.dart';

class TodoListBloc {
  final TodoRepository _repository;

  TodoListBloc(this._repository) {
    selectedDateControllerSink.stream.listen((date) {
      final tasksForDay = _repository.snapshot.where((Task t) {
        bool dueDateMatch = t.dueDate == date || false;
        bool repeatsOnWeekDay = t.repeatingDays?.contains(DayOfWeek.values[date.weekday]);
        return dueDateMatch || repeatsOnWeekDay;
      }).toList();

      tasksForDate.add(tasksForDay);
    });
  }

  // inputs
  void addTask(Task todo) => _repository.addNewTodo(todo);
  void deleteTask(Task todo) => _repository.deleteTodo(todo);

  void toggleTaskComplete(Task todo) async {
    final toggled = todo.toggleComplete();
    // the output of this bloc will emit a new stream event
    // when the [_repository] is finished.
    return await _repository.updateTodo(toggled);
  }

  BehaviorSubject<DateTime> selectedDateControllerSink = BehaviorSubject<DateTime>();
  BehaviorSubject<List<Task>> tasksForDate = BehaviorSubject<List<Task>>();

  refreshTaskDate(Task todo) {
    print(todo.description);
  }

  // outputs
  Stream<List<Task>> get todos {
    if (tasksForDate.hasValue) return tasksForDate.stream;
    return _repository.todos;
  }

  Stream<DateTime> get selectedDate => selectedDateControllerSink.stream;

  void dispose() {
    selectedDateControllerSink.close();
    tasksForDate.close();
  }
}
