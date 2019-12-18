import 'package:flutter/material.dart';
import 'package:blocs_without_libs_example/widgets/dogs_list.dart';

class DogsListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text( 'We Rate Dogs'),
      ),
      body: DogList(),
    );
  }
}
