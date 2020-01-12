---
title: "Calendar App introduction"
author: "Eric"
category: "Flutter State Management Example Apps"
subSection: "Blocs without Libraries"
tags:
    - flutter
    - state management
    - example app
---

For the state management portion of FlutterByExample, we've created a twist on the classic Todo app. In addition to working like a basic todo app, it also has 'due date' and 'repeating' task features.  

These images show the todo app in it's most basic form: with a list of todos -- some checked and some not.

<img src="images/calendar_app/calendar_app_home.png" alt="drawing" style="width:200px;"/>
<img src="images/calendar_app/calendar_app_home_2.png" alt="drawing" style="width:200px;"/>

Notice the calendar at the top of the screen. When one of the days are tapped, it displays only the tasks that are due that day.

<img src="images/calendar_app/calendar_app_friday_selected.png" alt="drawing" style="width:200px;"/>

You can also add new todos. When adding new todos, you can set a one time due date (using the DatePicker widget), or you can set the todo to be a repeating task, and select the days it should repeat.

<img src="images/calendar_app/calendar_app_add_todo.png" alt="drawing" style="width:200px;"/>
<img src="images/calendar_app/calendar_app_add_todo_datepicker.png" alt="drawing" style="width:200px;"/>
<img src="images/calendar_app/calendar_app_add_todo_repeating_true.png" alt="drawing" style="width:200px;"/>
 
 
Once you create a new todo, you'll see it appear in the list. In this image, you can see that it repeats every Friday:

<img src="images/calendar_app/calendar_app_friday_selected_2.png" alt="drawing" style="width:200px;"/>

### Using a mock back-end

This calendar app, regardless of the state-management pattern being used, communicates with outside API's via a class called the `TodoRepository`. It's job is to talk to the data store on behalf of the Flutter app, and then return the responses to the app. This class looks like this:

<div class="aside">For now, the implementation of this class isn't important. I'm showing you this only so you have context in future lessons that will refer to this repository. The important note is that this repository is _reactive_, and closely imitates Firestore. Whenever the data store is updated, it emits new information via a Stream of a List of Tasks.</div>

```dart
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
```