---
title: "Create bloc one"
author: "Eric"
category: "Flutter State Management Example Apps"
subSection: "Blocs without Libraries"
tags:
    - flutter
    - state management
    - blocs
    - blocs without libraries
---

<div class="aside">This portion of FlutterByExample is all about state management. Thus, we'll dive right into blocs in this tutorial, and not focus much on UI. If you're not familiar with Flutter as a UI library, I suggest you go back and start at an earlier tutorial.</div>

In this app, there are two blocs: a `TodoListBloc` and an `AddTodoBloc`. 

The todo list bloc is responsible for connecting a repository to the the todo list page of the app. In other words, the UI will get all of it's state about which tasks exist from this bloc, which will pull it's data from an API. It is also responsible for telling the API whenever a task is marked as complete (or incomplete). In short, it's the middleman between the data (source of truth) and the UI displaying that data.

<img src="images/calendar_app/calendar_app_home.png" alt="drawing" style="width:400px;"/>

Looking at the finished app, we know that this bloc needs to handle a few tasks:

* fetching all tasks from the repository, and delivering them to the UI
* marking tasks as complete or incomplete, 
* ensuring the UI is displaying the correct tasks when a date is selected on the calendar

For now, let's only worry about creating a bloc that can handle the simplest task: fetching tasks from the repository and emitting them via _streams_.

### The initial bloc stream

```dart
class TodoListBloc {
  // The [TodoRepository] class represents a service that
  // handles the data. It could be a class that talks to an
  // API or directly to Firebase. In this case, it talks
  // to a _reactive_ data store similar to Firestore. 
  final TodoRepository _repository;
  // inputs
  // TODO:

  // outputs
  // This output is a [Stream] that simply emits a list of tasks
  // when the _repository is aware of new todos, it emits them. The bloc
  // in this case, is a middleman. As this bloc grows, you'll see why this
  // is better than the repository being exposed to the UI directly.
  Stream<List<Task>> get todos =>  _repository.todos;
}
```

### Add a sink to the bloc

Now that we can emit a list of todos, which will be eventually used by the UI, we need a way to toggle the completion status of the todos. This will be done via a `Sink`, which we'll add the previous TodoListBloc code.

```dart
class TodoListBloc {
  final TodoRepository _repository;
  // inputs
  void toggleTaskComplete(Task todo) async {
    // toggleComplete is a method on the `Task` class which returns
    // a new instance of `Task` that is the same, except Task.completed
    // is flipped from false to true (or vise-versa).
    final toggled = todo.toggleComplete();

    // When the repository is updated, it will then
    // emit a new event via it's `TodoRepository.todos` stream property.
    // Thus, we don't need to return anything here, because we're consuming
    // the repository todos in the output below.
    _repository.updateTodo(toggled);
  }

  // outputs
  // when `toggleTaskComplete` is called, the repository
  // will emit a new event
  Stream<List<Task>> get todos =>  _repository.todos;
}
```

### A second sink and stream

Finally, here's additional code, used to manage which date on the calendar is selected in the app UI. We will return to this code later in the tutorial.

```dart
class TodoListBloc {
  final TodoRepository _repository;
  // inputs
  void toggleTaskComplete(Task todo) async {
    final toggled = todo.toggleComplete();
    _repository.updateTodo(toggled);
  }

  /// [BehaviorSubject] is a class from the `rxdart` package. It's similar to a 
  /// StreamController, with a few extra perks. We'll return to this later.
  BehaviorSubject<DateTime> selectedDateControllerSink = BehaviorSubject<DateTime>();

  // outputs
  Stream<List<Task>> get todos =>  _repository.todos;
  Stream<DateTime> get selectedDate => selectedDateControllerSink.stream;
}
```