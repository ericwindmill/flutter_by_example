import 'package:flutter/material.dart';

class ScreenContainer extends StatelessWidget {
  const ScreenContainer({
    Key key,
    this.title,
    this.body,
  }) : super(key: key);

  final Widget title;
  final Widget body;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: title ?? Text(''),
      ),
      body: body,
    );
  }
}
