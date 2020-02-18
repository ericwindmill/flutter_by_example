import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:models/models.dart';
import 'package:rxdart/subjects.dart';

import './todos_repository_base.dart';

class FirestoreTasksRepository implements TasksRepository {
  FirestoreTasksRepository() {
    Firestore.instance.collection('tasks').snapshots().listen((QuerySnapshot snapshot) {
      final tasks = snapshot.documents.map((DocumentSnapshot doc) {
        if (doc.data['schedule'] != null) return ScheduledTask.fromJson(doc.data);
        return Task.fromJson(doc.data);
      });

      _tasksStreamController.add(tasks);
    });
  }

  BehaviorSubject<List<Task>> _tasksStreamController = BehaviorSubject<List<Task>>();

  @override
  Stream<List<Task>> get tasks => _tasksStreamController.stream;

  @override
  addTask(Task task) {
    Firestore.instance.collection('tasks').document().setData(task.toJson());
  }

  dispose() {
    _tasksStreamController.close();
  }
}
