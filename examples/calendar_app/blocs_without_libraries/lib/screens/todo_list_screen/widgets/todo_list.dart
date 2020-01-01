import 'package:blocs_without_libraries/app/bloc_provider.dart';
import 'package:calendar_app_repository/calendar_app_repository.dart';
import 'package:flutter/material.dart';

class TodoList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of(context).todoListBloc;
    return StreamBuilder(
      stream: bloc.todos,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData) return Center(child: CircularProgressIndicator());
        return ListView.builder(
          itemCount: snapshot.data.length,
          itemBuilder: (BuildContext context, int index) {
            Todo todo = snapshot.data[index];
            return CheckboxListTile(
              value: todo.complete,
              title: Text(todo.description),
              onChanged: (bool b) => bloc.toggleTodo(todo),
            );
          },
        );
      },
    );
  }
}
