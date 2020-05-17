import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';

class Person with ChangeNotifier {
  Person({this.name, this.age});

  final String name;
  int age;

  void increaseAge() {
    this.age++;
    notifyListeners();
  }
}

void main() {
  runApp(
    ProxyProvider(
      create: (_) => Person(name: "Yohan", age: 25),
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
    return Consumer<Person>(
      builder: (context, person, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text("${person.name} -- ${person.age} yrs old"),
          ),
          body: child,
          floatingActionButton: FloatingActionButton(
            onPressed: () => person.increaseAge(),
          ),
        );
      },
      child: Center(
        child: Text('Hi this represents a huge widget! Like a scrollview with 500 children!'),
      ),
    );
  }
}
