import 'dart:async';

import 'package:blocs_without_libs_example/app/models/dog.dart';
import 'package:blocs_without_libs_example/app/repository/dog_repository.dart';

enum DogBlocAction {
  fetchDogs,
  selectDog,
}

class AllDogsBloc {
  AllDogsBloc() {
    _allDogsSink.onListen = () {
      final dogs = DogRepository().get();
      _allDogsSink.add(dogs);
    };

    selectedDog.listen((d) => print('AllDogsBloc.selectedDog.listen.added ${d.name}'));
    print('closed? ${_selectedDogSink.isClosed}');
    print('has listener? ${_selectedDogSink.hasListener}');
  }
  StreamController<List<Dog>> _allDogsSink = StreamController<List<Dog>>.broadcast();

  Stream<List<Dog>> get allDogs => _allDogsSink.stream;

  StreamController<Dog> _selectedDogSink = StreamController<Dog>.broadcast();

  Stream<Dog> get selectedDog => _selectedDogSink.stream;

  void selectDog(Dog dog) {
    print('adding dog ${dog.name} to sink');
    _selectedDogSink.add(dog);
  }

  void dispose() {
    _allDogsSink.close();
    _selectedDogSink.close();
  }
}
