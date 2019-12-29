import 'package:calendar_app_repository/src/mock_web_client.dart';
import 'package:rxdart/subjects.dart';

import 'model/todo.dart';

/// This is a _reactive_ class that talks to a web-client.
/// The API of this class is written in a way that allows your
/// app to consume the data in a reactive way, which means
/// it behaves similarly to Firestore.
class TodoRepository {
  final WebClient client;
  final BehaviorSubject<List<Todo>> _subject;
  bool _loaded = false;

  TodoRepository(this.client, {List<Todo> seed})
      : _subject = BehaviorSubject<List<Todo>>.seeded(seed);

  Stream<List<Todo>> get todos {
    if (!_loaded) _loadTodos();

    return _subject.stream;
  }

  void _loadTodos() {
    _loaded = true;

    client.fetchTodos().then((todos) {
      _subject.add([..._subject.value, ...todos]);
    });
  }

  Future<void> addNewTodo(Todo todo) async {
    final newTodos = [..._subject.value, todo];
    _subject.add([..._subject.value, todo]);
    await client.postTodos(newTodos);
  }

  Future<void> deleteTodo(Todo todo) async {
    final newTodos = _subject.value.where((t) => t.description != todo.description);
    _subject.add(newTodos);
    await client.postTodos(newTodos);
  }

  Future<void> updateTodo(Todo todo) async {
    final newTodos = [
      ..._subject.value.where((t) => t.description != todo.description),
      todo,
    ];
    _subject.add(newTodos);
    await client.postTodos(newTodos);
  }
}
