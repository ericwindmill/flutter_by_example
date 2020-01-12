---
title: "Consume the second bloc's streams"
author: "Eric"
category: "Flutter State Management Example Apps"
subSection: "Blocs without Libraries"
tags:
    - flutter
    - state management
    - stream builder
    - bloc
---

This is going to be extremely similar to the previous example. It's just more examples so you can get used to seeing stream builders in action.

```dart
/// The container for the screen is similar to the previous example.
/// In this example, though, you can see both blocs being used in one widget
class AddAndEditTodoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // grab a reference to this bloc here, because 
    // it's the primary bloc used in this screen. It
    // will provide the stream we need in the stream builder.
    final bloc = BlocProvider.of(context).editTodoBloc;
    return StreamBuilder<Task>(
      // use the bloc
      stream: bloc.todo,
      builder: (context, snapshot) {
        // protect against null data
        if (!snapshot.hasData) return CircularProgressIndicator();
        return ScreenContainer(
          title: Text('Add Todo'),
          // Most of the logic is in this widget,
          // which you can see on github at https://github.com/ericwindmill/flutter_by_example/tree/master/examples/calendar_app/blocs_without_libraries/lib/screens/add_todo_screen
          body: FormContainer(),
          floatingActionButton: FloatingActionButton.extended(
            label: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text('Save'),
            ),
            // This is the interesting part in which we use two blocs
            onPressed: () {
              // The [TodoListBloc] is the only one that communicates with the
              // repository. Therefor, we'll use it to add the new task to
              // the repository when the floating action button is tapped.
              BlocProvider.of(context).todoListBloc.addTask(bloc.todo.value);
              // we also need to clear the form, so that it's blank
              // when we return to this screen to add another task
              // this is done on the primary bloc for this screen, the EditTodoBloc
              bloc.clearAddEditForm();
              // finally, pop back to the todolist page.
              Navigator.of(context).pop();
            },
          ),
        );
      },
    );
  }
}
```

