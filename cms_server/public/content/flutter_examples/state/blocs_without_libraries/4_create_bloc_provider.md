---
title: "Create a bloc provider"
author: "Eric"
category: "Flutter State and Logic Example Apps"
subSection: "Blocs without Libraries"
tags:
    - flutter
    - state management
    - inherited widget
    - bloc
---

In order to use the blocs in your Flutter UI, you need to be able to access the blocs through-out your app. For example, you want to be able to do something like this in a widget:

```dart
class MyWidget extends StatelessWidget {

  Widget build(BuildContext context) {
    var myBloc = ???; // todo: access bloc somehow
    return Text(myBloc.titleStream.value);
  }
}
```

There are a couple ways you could accomplish this. For example, you could create an instance of the bloc in the widget you're using:

```dart
class MyWidget extends StatelessWidget {

  Widget build(BuildContext context) {
    var myBloc = TodoListBloc(repository: TodoRepository());
    return Text(myBloc.titleStream.value);
  }
}
```

This won't work. What if you want to update a todo in a different widget? You'd be using a new instance of `TodoRepository` each time, so your data wouldn't persist from one piece of the app to another. 

To solve that problem, we can "lift state up" -- or create the bloc and repository high in the widget tree, and then pass it down the tree to the widgets that need it.

```dart
class MyWidget extends StatelessWidget {
  final TodoListBloc bloc;

  MyWidget(this.bloc);

  Widget build(BuildContext context) {
    var myBloc = TodoListBloc(repository: TodoRepository());
    return Text(myBloc.titleStream.value);
  }
}
```

This will work. *However*, it's very cumbersome. You'd need to be passing the bloc through every widget in-between the root of your app and the leaf widgets that need the bloc. 

Luckily, Flutter's `InheritedWidget` is designed to solve this exact problem. I'll use an `InheritedWidget` to create a _bloc provider_. Provider is a term you'll see a lot in the Flutter world. In Flutter, it's used to describe a class that is used to inject other objects throughout your widget tree or scope, even when you're much further down the widget tree than where the objects are created. 

In the calendar app, this is the `BlocProvider` class:

```dart
import 'package:blocs_without_libraries/app/blocs/edit_todo_bloc.dart';
import 'package:blocs_without_libraries/app/blocs/todos_bloc.dart';
import 'package:flutter/material.dart';

// InheritedWidget objects have the ability to be
// searched for anywhere 'below' them in the widget tree.
class BlocProvider extends InheritedWidget {

  // these blocs are the objects that we want to access throughout the app
  final TodoListBloc todoListBloc;
  final EditTodoBloc editTodoBloc;

  /// Inherited widgets require a child widget
  /// which they implicitly return in the same way
  /// all widgets return other widgets in their 'Widget.build' method.
  const BlocProvider({
    Key key,
    @required Widget child,
    this.todoListBloc,
    this.editTodoBloc,
  })  : assert(child != null),
        super(key: key, child: child);

  /// this method is used to access an instance of
  /// an inherited widget from lower in the tree.
  /// `BuildContext.dependOnInheritedWidgetOfExactType` is a built in
  /// Flutter method that does the hard work of traversing the tree for you
  static BlocProvider of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<BlocProvider>();
  }

  @override
  bool updateShouldNotify(BlocProvider old) {
    return true;
  }
}
```

You also must add an instance of this `BlocProvider` to the app. This is done in the `main.dart` file in the calendar app.

```dart
void main() {
  var _repository = TodoRepository(WebClient());

  runApp(
    /// Bloc provider is a widget, so it can be used
    /// as the root of your Flutter app!
    BlocProvider(
      todoListBloc: TodoListBloc(_repository),
      editTodoBloc: EditTodoBloc(seed: Task('')),
      child: BlocsWithoutLibrariesApp(),
    ),
  );
}
```

And finally, you need to access your blocs via the `BlocProvider` throughout your app.

```dart
class MyWidget extends StatelessWidget {

  Widget build(BuildContext context) {
    /// So long as there is an instance of `BlocProvider` above this widget
    /// in the widget tree, and that `BlocProvider` is a subclass of `InheritedWidget`
    /// this method will look up the tree, find the first occurrence of this widget
    /// and return it. [todoListBloc] is just a property on that widget.
    var myBloc = BlocProvider.of(context).todoListBloc;
    return Text(myBloc.titleStream.value);
  }
}
```
