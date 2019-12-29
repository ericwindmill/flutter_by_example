import 'package:blocs_without_libs_example/app/blocs/all_dogs_bloc.dart';
import 'package:blocs_without_libs_example/app/blocs/dog_form_bloc.dart';
import 'package:flutter/material.dart';

class BlocProvider extends InheritedWidget {
  final Widget child;
  final AllDogsBloc dogBloc;
  final DogRatingBloc ratingBloc;

  BlocProvider({
    Key key,
    this.child,
    this.dogBloc,
    this.ratingBloc,
  }) : super(key: key);

  static BlocProvider of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(BlocProvider) as BlocProvider);
  }

  @override
  bool updateShouldNotify(BlocProvider oldWidget) =>
      dogBloc != oldWidget.dogBloc || ratingBloc != oldWidget.ratingBloc;
}
