class Todo {
  final String description;
  final bool complete;
  final Duration repetitionInterval;

  bool get isRepeating => repetitionInterval != null;

  Todo(
    this.description, {
    this.complete = false,
    this.repetitionInterval,
  });

  factory Todo.copyWithToggle(Todo todo) {
    return Todo(
      todo.description,
      complete: !todo.complete,
    );
  }
}
