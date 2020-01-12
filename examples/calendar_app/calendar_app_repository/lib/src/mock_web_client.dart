import 'package:calendar_app_repository/calendar_app_repository.dart';

import 'model/todo.dart';

/// A mock class that represents an API. It is responsible for fetching and
/// persisting data to and from the cloud.
/// Since we're trying to keep this example simple, it doesn't communicate with
/// a real server but simply emulates the functionality.
///
/// Each method should complete exactly one task, which corresponds to "C.R.U.D."
/// For example, the `update` methods should update the mock-database, but not return the updated data.
class WebClient {
  final Duration delay;

  WebClient({this.delay = const Duration(milliseconds: 1000)});

  Future<List<Task>> fetchTodos() async {
    return Future.delayed(
      delay,
      () => _allTodos,
    );
  }

  Future<bool> postTodos(List<Task> todos) async {
    _allTodos = todos;
    return Future.value(true);
  }
}

List<Task> _allTodos = [
  Task(
    'Take trashcans to street',
    dueDate: DateTime.now(),
  ),
  Task(
    'turn in chapter 12 revision',
  ),
  Task(
    're-write web app in Flutter',
  ),
  Task('Pet Wallace and Phoebe',
      repeatingDays: {DayOfWeek.Monday, DayOfWeek.Tuesday, DayOfWeek.Saturday, DayOfWeek.Friday}),
  Task(
    'file taxes',
  ),
];
