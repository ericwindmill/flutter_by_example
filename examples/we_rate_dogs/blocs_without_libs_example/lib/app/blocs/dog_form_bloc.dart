import 'dart:async';

import 'package:blocs_without_libs_example/app/models/dog.dart';
import 'package:blocs_without_libs_example/app/repository/dog_repository.dart';

class DogRatingBloc {
  StreamController<Dog> _dogSink = StreamController<Dog>();

  Stream get dog => _dogSink.stream;

  updateDog(Dog updatedDog) {
    DogRepository().update(updatedDog);
    _dogSink.add(updatedDog);
  }

  void dispose() {
    _dogSink.close();
  }
}
