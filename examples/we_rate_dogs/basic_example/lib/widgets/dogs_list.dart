import 'package:basic_example/models/dog.dart';
import 'package:flutter/material.dart';

import 'dog_card.dart';

class DogList extends StatelessWidget {
  final List<Dog> doggos;

  DogList(this.doggos);

  ListView _buildList(context) {
    return  ListView.builder(
      itemCount: doggos.length,
      itemBuilder: (context, int) {
        return  DogCard(doggos[int]);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildList(context);
  }
}