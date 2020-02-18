import 'package:models/models.dart';

abstract class TasksRepository {
  Stream<List<Task>> get tasks;
  addTask(Task todo);
}
