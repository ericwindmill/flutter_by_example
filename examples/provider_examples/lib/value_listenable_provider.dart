import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Value Notifier'),
        ),
        body: Center(
          child: HighlightedText(),
        ),
      ),
    );
  }
}

class HighlightedText extends StatelessWidget {
  final ValueNotifier<bool> isHighlighted = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: ValueListenableBuilder(
        valueListenable: isHighlighted,
        builder: (BuildContext context, bool b, Widget child) {
          return Container(
            color: b ? Colors.yellow.shade200 : Colors.white,
            child: Text('This is some cool text'),
          );
        },
      ),
      onTap: () {
        isHighlighted.value = true;
      },
    );
  }
}
