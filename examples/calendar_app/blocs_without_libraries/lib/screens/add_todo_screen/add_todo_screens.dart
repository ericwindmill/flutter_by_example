import 'package:blocs_without_libraries/app/bloc_provider.dart';
import 'package:blocs_without_libraries/screens/add_todo_screen/widgets/body_container.dart';
import 'package:calandar_app_ui/screens/screen_container.dart';
import 'package:calendar_app_repository/calendar_app_repository.dart';
import 'package:flutter/material.dart';

class AddAndEditTodoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of(context).editTodoBloc;
    return StreamBuilder<Task>(
      stream: bloc.todo,
      builder: (context, snapshot) {
        if (!snapshot.hasData) return CircularProgressIndicator();
        return ScreenContainer(
          title: Text('Add Todo'),
          body: FormContainer(),
          floatingActionButton: FloatingActionButton.extended(
            label: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text('Save'),
            ),
            onPressed: () {
              BlocProvider.of(context).todoListBloc.addTask(bloc.todo.value);
              bloc.clearAddEditForm();
              Navigator.of(context).pop();
            },
          ),
        );
      },
    );
  }
}
