---
title: "Using StreamBuilders with blocs"
author: "Eric"
category: "Flutter State Management Example Apps"
subSection: "Blocs without Libraries"
tags:
    - stream builder
    - state management
    - inherited widget
    - bloc
---

Now, it's time to jump into some Flutter specific code, where we can consume the `TodoListBloc` data with a `StreamBuilder` widget.  Specifically, let's start by looking at the `TodoList` widget that I made for that project.

<img src="images/calendar_app/calendar_app_todo_list_annotation.png" alt="calendar app" style="width:500px;border-radius: 0"/>

### Bloc code reminder

Here's the bloc code that we care about, as a reminder before we dive into the Flutter code.

```dart
import 'dart:async';

import 'package:calendar_app_repository/calendar_app_repository.dart';
import 'package:rxdart/rxdart.dart';

class TodoListBloc {
  final TodoRepository _repository;

  TodoListBloc(this._repository) {
    // ...
  }

  // inputs
  void toggleTaskComplete(Task todo) async {
    final toggled = todo.toggleComplete();
    // the output of this bloc will emit a new stream event
    // when the [_repository] is finished.
    return await _repository.updateTodo(toggled);
  }

  BehaviorSubject<DateTime> selectedDateControllerSink = BehaviorSubject<DateTime>();
  BehaviorSubject<List<Task>> tasksForDate = BehaviorSubject<List<Task>>();

  // outputs
  // NB:  This is the output that we care about in this example
  Stream<List<Task>> get todos {
    return _repository.todos;
  }

  Stream<DateTime> get selectedDate => selectedDateControllerSink.stream;

  void dispose() {
    selectedDateControllerSink.close();
  }
}
```

### Adding a StreamBuilder

`StreamBuilder` is a widget that knows to re-build and re-render each time a stream it's listening to emits a new event. You'll tell it what stream to listen to, and what widgets to build when that stream is updated. Using a `StreamBuilder` will be familiar is you know the `builder` pattern used in Flutter. 

<div class="aside">
As a recap, `builder` is a pattern on many Flutter widgets that allow you to use a callback to create widgets, rather than the standard means of passing a widget to `Widget.child` in the build method. 
</div>

```dart
import 'package:blocs_without_libraries/app/bloc_provider.dart';
import 'package:calandar_app_ui/widgets/widgets.dart';
import 'package:calendar_app_repository/calendar_app_repository.dart';
import 'package:flutter/material.dart';

class TodoList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Grab a reference to the bloc using the bloc provider
    final bloc = BlocProvider.of(context).todoListBloc;

    // return a StreamBuilder
    // which requires a `builder` callback to be passed in
    // as well as `stream` to listen to
    // The type declaration on StreamBuilder is used to tell 
    // it what type of data to expect from the Stream
    return StreamBuilder<List<Task>>(
      // pass it the `todos` stream on the bloc
      stream: bloc.todos,
      // Builder callback will be passed the BuildContext,
      // as well as an [AsyncSnapshot], which is _current_ data
      // emitted from the Stream (in this case a List of Tasks
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        // If there isn't any data, return early to prevent the app from crashing
        if (!snapshot.hasData) return Center(child: CircularProgressIndicator());
  
        // ListView.builder is another widget that relies on the builder pattern
        return ListView.builder(
          // `snapshot.data` is the actual List<Task> object from the stream.
          itemCount: snapshot.data.length,
          // `itemBuilder` is required, and should return a widget 
          // that's used created for each iteration of the `ListView.builder`
          // the index that's passed in to this callback will be increased with
          // each iteration
          itemBuilder: (BuildContext context, int index) {
            // grab a reference to the task for brevity
            // remember that the `snapshot.data` is a list of todos.
            Task todo = snapshot.data[index];
            // now we can finally use the task object itself
            // which we're getting from the Bloc.todos stream.
            return TodoListTile(
              task: todo,
              onCheckboxToggle: (bool v) => bloc.toggleTaskComplete(todo),
              onRefreshed: () => bloc.refreshTaskDate(todo),
            );
          },
        );
      },
    );
  }
}
```

`StreamBuilder` is used several times in this app. You can find many more examples in the <a href="https://github.com/ericwindmill/flutter_by_example/tree/master/examples/calendar_app/blocs_without_libraries/lib">source code</a>.