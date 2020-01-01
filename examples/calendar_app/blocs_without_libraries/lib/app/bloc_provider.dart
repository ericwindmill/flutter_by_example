import 'package:blocs_without_libraries/app/blocs/todos_bloc.dart';
import 'package:flutter/material.dart';

class BlocProvider extends InheritedWidget {
  final TodoListBloc todoListBloc;

  const BlocProvider({
    Key key,
    @required Widget child,
    this.todoListBloc,
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
