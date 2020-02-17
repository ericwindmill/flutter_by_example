import 'package:flutter/material.dart';
import 'package:todos_repository/todos_repository.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Text('yo'),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            FirestoreTasksRepository().addTask(mockTasks[0]);
            FirestoreTasksRepository().addTask(mockTasks[1]);
            FirestoreTasksRepository().addTask(mockTasks[2]);
            FirestoreTasksRepository().addTask(mockTasks[3]);
          },
        ),
      ),
    );
  }
}
