import 'package:models/models.dart';

abstract class TodosRepository {
  Stream<List<RecurringTodo>> get todos;
  upsertTodo(RecurringTodo todo);
}
