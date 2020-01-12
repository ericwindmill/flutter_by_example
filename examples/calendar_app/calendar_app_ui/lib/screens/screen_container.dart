import 'package:flutter/material.dart';

class ScreenContainer extends StatelessWidget {
  const ScreenContainer({
    Key key,
    this.title,
    this.body,
    this.floatingActionButton,
  }) : super(key: key);

  final Widget title;
  final Widget body;
  final Widget floatingActionButton;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: title ?? Text(''),
      ),
      body: body,
      floatingActionButton: floatingActionButton,
    );
  }
}
