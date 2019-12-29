import 'package:flutter/material.dart';
import 'package:blocs_without_libs_example/screens/dog_list_page.dart';

class DogAppWithBlocs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'We Rate Dogs',
      theme: ThemeData(brightness: Brightness.dark),
      home: DogsListPage(),
    );
  }
}
