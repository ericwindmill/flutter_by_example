import 'package:blocs_without_libs_example/app/blocs/dog_bloc.dart';
import 'package:flutter/material.dart';

class BlocProvider extends InheritedWidget {
  final Widget child;
  final DogBloc dogBloc;

  BlocProvider({
    Key key,
    this.child,
    this.dogBloc,
  }) : super(key: key);

  static BlocProvider of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(BlocProvider) as BlocProvider);
  }

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;
}
