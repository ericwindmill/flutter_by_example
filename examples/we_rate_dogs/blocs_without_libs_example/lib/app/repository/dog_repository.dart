import 'dart:convert';
import 'dart:io';

import 'package:blocs_without_libs_example/app/models/dog.dart';

class DogRepository {
  /// Set up a singleton
  static final DogRepository singleton = DogRepository._();

  factory DogRepository() {
    return singleton;
  }

  DogRepository._();

  // set up repository
  initialize() async {
    await _eagerLoad();
  }

  // interaction methods
  List<Dog> get() => _allDogs;

  void update(Dog updatedDog) {
    var dogToUpdate = _allDogs.firstWhere((Dog d) => d.id == updatedDog.id);
    _allDogs.remove(dogToUpdate);
    _allDogs.add(updatedDog);
  }

  // private "faker" properties
  static var _allDogs = <Dog>[
    Dog(name: 'Ruby', location: 'Portland, OR, USA', description: 'Ruby is a very good girl.'),
    Dog(name: 'Rex', location: 'Seattle, WA, USA', description: 'A Very Good Boy'),
    Dog(name: 'Rod Stewart', location: 'Prague, CZ', description: 'A Very Good Boy'),
    Dog(name: 'Herbet', location: 'Dallas, TX, USA', description: 'A Very Good Boy'),
    Dog(name: 'Sherbert', location: 'Tokyo, JP', description: 'A Very Good Girl'),
    Dog(name: 'Buddy', location: 'North Pole, Earth', description: 'A Very Good Girl'),
  ];

  _eagerLoad() async {
    for (var dog in _allDogs) {
      dog.imageUrl = await _getImageUrl();
    }
  }

  Future<String> _getImageUrl() async {
    // Get an Image
    HttpClient http = new HttpClient();
    try {
      var uri = new Uri.http('dog.ceo', '/api/breeds/image/random');
      var request = await http.getUrl(uri);
      var response = await request.close();
      var responseBody = await response.transform(utf8.decoder).join();
      var decoded = json.decode(responseBody);
      var url = decoded['message'];
      return url;
    } catch (exception) {
      print(exception);
      return null;
    }
  }
}
