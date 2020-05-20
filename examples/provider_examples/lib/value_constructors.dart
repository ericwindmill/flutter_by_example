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
    ChangeNotifierProvider(
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Provider Class'),
      ),
      body: Center(
        child: PersonsNameLabel(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Provider.of<Person>(context, listen: false).increaseAge(),
      ),
    );
  }
}

class PersonsNameLabel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider<String>.value(
      value: Provider.of<Person>(context).name,
      builder: (BuildContext context, Widget child) {
        return Text(context.watch<String>());
      },
    );
  }
}
