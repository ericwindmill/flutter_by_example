import 'package:blocs_without_libraries/app/bloc_provider.dart';
import 'package:blocs_without_libraries/app/blocs/edit_todo_bloc.dart';
import 'package:blocs_without_libraries/app/blocs/todos_bloc.dart';
import 'package:blocs_without_libraries/screens/add_todo_screen/add_todo_screens.dart';
import 'package:blocs_without_libraries/screens/todo_list_screen/todo_list_screen.dart';
import 'package:calendar_app_repository/calendar_app_repository.dart';
import 'package:flutter/material.dart';

void main() {
  var _repository = TodoRepository(WebClient());

  runApp(
    BlocProvider(
      todoListBloc: TodoListBloc(_repository),
      editTodoBloc: EditTodoBloc(seed: Task('')),
      child: BlocsWithoutLibrariesApp(),
    ),
  );
}

class BlocsWithoutLibrariesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/': (BuildContext context) => TodoListScreen(),
        '/add': (BuildContext context) => AddAndEditTodoScreen(),
      },
    );
  }
}
