import 'package:blocs_without_libraries/app/blocs/edit_todo_bloc.dart';
import 'package:blocs_without_libraries/app/blocs/todos_bloc.dart';
import 'package:flutter/material.dart';

class BlocProvider extends InheritedWidget {
  final TodoListBloc todoListBloc;
  final EditTodoBloc editTodoBloc;

  const BlocProvider({
    Key key,
    @required Widget child,
    this.todoListBloc,
    this.editTodoBloc,
  })  : assert(child != null),
        super(key: key, child: child);

  static BlocProvider of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<BlocProvider>();
  }

  @override
  bool updateShouldNotify(BlocProvider old) {
    return true;
  }
}
