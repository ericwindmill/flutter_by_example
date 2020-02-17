import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:models/models.dart';

import './todos_repository_base.dart';

class FirestoreTasksRepository implements TasksRepository {
  @override
  Stream<List<Task>> get tasks => null;

  @override
  addTask(Task task) {
    Firestore.instance.collection('tasks').document().setData(task.toJson());
  }
}
