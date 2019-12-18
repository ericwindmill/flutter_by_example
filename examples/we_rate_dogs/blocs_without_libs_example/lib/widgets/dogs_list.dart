import 'package:blocs_without_libs_example/app/bloc_provider.dart';
import 'package:blocs_without_libs_example/app/models/dog.dart';
import 'package:flutter/material.dart';
import 'dog_card.dart';

class DogList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of(context).dogBloc;
    return StreamBuilder<List<Dog>>(
      stream: bloc.allDogs,
      builder: (context, snapshot) {
        return ListView.builder(
          itemCount: snapshot.data.length,
          itemBuilder: (context, int) {
            return DogCard(snapshot.data[int]);
          },
        );
      },
    );
  }
}
