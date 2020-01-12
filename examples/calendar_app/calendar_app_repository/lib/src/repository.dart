import 'package:calendar_app_repository/src/mock_web_client.dart';
import 'package:rxdart/subjects.dart';
import 'model/todo.dart';

/// This is a _reactive_ class that talks to a web-client.
/// The API of this class is written in a way that allows your
/// app to consume the data in a reactive way, which means
/// it behaves similarly to Firestore.
class TodoRepository {
  final WebClient client;
  final BehaviorSubject<List<Task>> _subject;
  bool _loaded = false;

  TodoRepository(this.client, {List<Task> seed})
      : _subject = BehaviorSubject<List<Task>>.seeded(seed ?? []);

  Stream<List<Task>> get todos {
    if (!_loaded) _loadTodos();

    return _subject.stream;
  }

  List<Task> get snapshot => _subject.value ?? [];

  void _loadTodos() {
    _loaded = true;

    client.fetchTodos().then((todos) {
      _subject.add([..._subject?.value, ...todos]);
    });
  }

  Future<void> addNewTodo(Task todo) async {
    final newTodos = [..._subject.value, todo];
    _subject.add([..._subject.value, todo]);
    await client.postTodos(newTodos);
  }

  Future<void> deleteTodo(Task todo) async {
    final newTodos = _subject.value.where((t) => t.description != todo.description);
    _subject.add(newTodos);
    await client.postTodos(newTodos);
  }

  Future<void> updateTodo(Task todo) async {
    final todos = _subject.value;
    final todoToUpdate = todos.firstWhere((t) => t.description == todo.description);
    final index = todos.indexOf(todoToUpdate);
    todos.replaceRange(index, index + 1, [todo]);
    _subject.add(todos);
    await client.postTodos(todos);
  }
}
