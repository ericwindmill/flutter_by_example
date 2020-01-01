import 'package:blocs_without_libraries/app/bloc_provider.dart';
import 'package:calendar_app_repository/calendar_app_repository.dart';
import 'package:flutter/material.dart';

class AddNewTodoInput extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of(context).todoListBloc;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: "Add a new todo",
                border: OutlineInputBorder(),
              ),
            ),
          ),
          IconButton(
            icon: Icon(
              Icons.add_circle,
              color: Colors.blue,
            ),
            onPressed: () {
              bloc.addTodo(
                Todo(_controller.text),
              );
              _controller.clear();
            },
          ),
        ],
      ),
    );
  }
}
