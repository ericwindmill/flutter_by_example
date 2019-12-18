import 'dart:async';

import 'package:blocs_without_libs_example/app/models/dog.dart';
import 'package:blocs_without_libs_example/app/repository/dog_repository.dart';

enum DogBlocAction {
  fetchDogs,
}

class DogBloc {
  StreamController<List<Dog>> streamController = StreamController<List<Dog>>();

  Stream<List<Dog>> get allDogs => streamController.stream;

  add(DogBlocAction action) {
    switch(action) {
      case DogBlocAction.fetchDogs:
        streamController.add(DogRepository.get());
        break;
    }
  }

  dispose() {
    streamController.close();
  }
}
