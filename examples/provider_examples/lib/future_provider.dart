import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';

class Person {
  Person({this.name, this.age});

  final String name;
  int age;
}

class Home {
  final String city = "Portland";

  Future<String> get fetchAddress {
    final address = Future.delayed(Duration(seconds: 2), () {
      return '1234 North Commercial Ave.';
    });

    return address;
  }
}

void main() {
  runApp(
    Provider<Person>(
      create: (_) => Person(name: 'Yohan', age: 25),
      child: FutureProvider<String>(
        create: (context) => Home().fetchAddress,
        initialData: "fetching address...",
        child: MyApp(),
      ),
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
          child: Consumer<Person>(
            builder: (context, Person person, child) {
              return Column(
                children: <Widget>[
                  Text("User profile:"),
                  Text("name: ${person.name}"),
                  Text("age: ${person.age}"),
                  Consumer<String>(builder: (context, String address, child) {
                    return Text("address: $address");
                  }),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
