import 'package:models/models.dart';

import './todos_repository_base.dart';

class FirestoreTodosRepository implements TodosRepository {
  @override
  Stream<List<RecurringTodo>> get todos => null;

  @override
  upsertTodo(RecurringTodo todo) {
    return null;
  }
}
