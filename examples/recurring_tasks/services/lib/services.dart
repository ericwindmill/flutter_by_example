library todos_repository;

export 'src/firestore_repository.dart';
export 'src/todos_repository_base.dart';

import 'package:models/models.dart';

// TODO: remove
List<Task> mockTasks = [
  Task(assignee: user, description: 'Complete taxes'),
  ScheduledTask(
    assignee: user,
    description: 'Do laundry',
    schedule: Schedule(
      dueDate: DateTime.now().add(Duration(days: 5)),
      frequency: Duration(days: 7),
    ),
  ),
  ScheduledTask(
    assignee: user,
    description: 'Pay bills',
    schedule: Schedule(
      dueDate: DateTime(2020, 4, 1),
      frequency: Duration(days: 30),
    ),
  ),
  Task(assignee: user, description: 'Complete article'),
];

User user = User('Phoebe');
