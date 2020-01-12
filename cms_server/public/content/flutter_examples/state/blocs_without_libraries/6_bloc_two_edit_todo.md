---
title: "Create bloc two: Add/Edit Tasks"
author: "Eric"
category: "Flutter State Management Example Apps"
subSection: "Blocs without Libraries"
tags:
    - flutter
    - state management
    - bloc
    - rxdart
---

In this lesson, I'd like to simply show a second example of a bloc, as well as where the bloc is consumed. This is meant to be a another example, and because it's lessons are similar to the previous bloc lesson in this tutorial, it will be light in the explanation.

There are three differences in this bloc that are worth pointing out:

1. This bloc uses an _imperative_ approach. It defines state that can live a long time. It updates this state right in the bloc, and then emits the changes.
2. This bloc deals entirely with editing a task _in memory_. It isn't concerned with any repositories or outside API. It's only inputs come from the UI, and it's only consumers are also the UI. Therefor, there is more logic happening right in the bloc than before.
3. It's inputs aren't _technically_ streams. This is an instance in which I've broken the rules. The inputs are instance methods. Importantly, though, these methods defer to streams.  The purpose of this is to make the code more readable (both in the UI and in the bloc) while still only using one StreamController. Because this bloc deals only with outputs that are single `Task` objects, but the inputs are caused by different events, these functions all funnel into the same stream controller. In this sense, the inputs are more or less still just sinks. None of the functions return any values to be used by the UI, which is the greater point. 


```dart
import 'package:calendar_app_repository/calendar_app_repository.dart';
import 'package:rxdart/rxdart.dart';


class EditTodoBloc {
  // This bloc uses an imperative approach, in order to show a different style.
  // importantly, though, it's inputs are still sinks and outputs still streams
  Task _newTask;

  // BehaviorSubject is a super-powered StreamController in the rxdart package:
  // 
  // A broadcast StreamController that caches the latest added value or error. 
  // When a new listener subscribes to the Stream, the latest value or error 
  // will be emitted to the listener. Furthermore, you can synchronously 
  // read the last emitted value.
  // 
  BehaviorSubject<Task> _todoSink;
  ValueStream<Task> todo;

  // The sink and stream are created in the 
  // constructor in order to use the `seeded` factory
  // on BehaviorSubject. It ensures that there's always 
  // a value in the stream, even before anything has been added
  EditTodoBloc({Task seed}) {
    _newTask = seed ?? Task('');
    _todoSink = BehaviorSubject<Task>.seeded(seed ?? _newTask);
    todo = _todoSink.stream;
  }

  // all of these methods work similarly
  // they copy the task with a new value for a given
  // property, and then they add that new task to the sink.
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
    _todoSink.add(_newTask);
  }

  void dispose() {
    _todoSink.close();
  }
}
``` 

