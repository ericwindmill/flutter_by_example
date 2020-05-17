import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';

class Person {
  Person({this.name, this.initialAge});

  final String name;
  final int initialAge;

  Stream<String> get age async* {
    var i = initialAge;
    while (i < 85) {
      await Future.delayed(Duration(seconds: 1), () {
        i++;
      });
      yield i.toString();
    }
  }
}

void main() {
  runApp(
    StreamProvider<String>(
      create: (_) => Person(name: 'Yohan', initialAge: 25).age,
      initialData: 25.toString(),
      catchError: (_, error) => error.toString(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Future Provider"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Consumer<String>(
            builder: (context, String age, child) {
              return Column(
                children: <Widget>[
                  Text("Watch Yohan Age..."),
                  Text("name: Yohan"),
                  Text("age: $age"),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
