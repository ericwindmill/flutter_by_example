import 'package:flutter/material.dart';

class App extends StatefulWidget {
  final Widget child;

  const App({
    Key key,
    this.child,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => AppState();

  static AppState state(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(_InheritedStateContainer)
            as _InheritedStateContainer)
        .data;
  }
}

class AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return new _InheritedStateContainer(
      data: this,
      child: widget.child,
    );
  }
}

class _InheritedStateContainer extends InheritedWidget {
  final AppState data;

  _InheritedStateContainer({
    Key key,
    @required this.data,
    @required Widget child,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(_InheritedStateContainer old) => old.data != data;
}
