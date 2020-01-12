import 'package:calendar_app_repository/calendar_app_repository.dart';
import 'package:rxdart/rxdart.dart';

class EditTodoBloc {
  Task _newTask;
  BehaviorSubject<Task> _todoSink;
  ValueStream<Task> todo;

  EditTodoBloc({Task seed}) {
    _newTask = seed ?? Task('');
    _todoSink = BehaviorSubject<Task>.seeded(seed ?? _newTask);
    todo = _todoSink.stream;
  }

  void updateTodoDescription(String updatedDescription) {
    _newTask = _newTask.copyWith(description: updatedDescription);
    _todoSink.add(_newTask);
  }

  void updateDueByDate(DateTime dueDate) {
    _newTask = _newTask.copyWith(dueDate: dueDate);
    _todoSink.add(_newTask);
  }

  void toggleRepetitionDay(DayOfWeek day, bool v) {
    var currentRepetitionDays = _newTask.repeatingDays..add(day);
    if (!v) currentRepetitionDays.remove(day);

    _newTask = _newTask.copyWith(repeatingDays: currentRepetitionDays);
    _todoSink.add(_newTask);
  }

  void toggleIsRepeating(bool v) {
    _newTask = _newTask.copyWith(isRepeating: v);
    _todoSink.add(_newTask);
  }

  void clearAddEditForm() {
    _newTask = Task(
      '',
      dueDate: null,
      repeatingDays: null,
      isRepeating: false,
    );
  }

  void dispose() {
    _todoSink.close();
  }
}
