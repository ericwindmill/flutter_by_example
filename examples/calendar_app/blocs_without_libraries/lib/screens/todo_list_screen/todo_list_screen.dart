import 'package:blocs_without_libraries/screens/todo_list_screen/widgets/add_new_input.dart';
import 'package:blocs_without_libraries/screens/todo_list_screen/widgets/todo_list.dart';
import 'package:calandar_app_ui/screens/screen_container.dart';
import 'package:flutter/material.dart';

class TodoListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenContainer(
      title: Text('Todo'),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(child: TodoList()),
          AddNewTodoInput(),
        ],
      ),
    );
  }
}
