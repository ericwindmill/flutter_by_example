import 'package:calendar_app_repository/calendar_app_repository.dart';

class TodoListBloc {
  final TodoRepository _repository;

  TodoListBloc(this._repository);

  // inputs
  addTodo(Todo todo) => _repository.addNewTodo(todo);
  deleteTodo(Todo todo) => _repository.deleteTodo(todo);

  toggleTodo(Todo todo) {
    final toggled = Todo.copyWithToggle(todo);
    // the output of this bloc will emit a new stream event
    // when the [_repository] is finished.
    return _repository.updateTodo(toggled);
  }

  // outputs
  Stream<List<Todo>> get todos => _repository.todos;
}
