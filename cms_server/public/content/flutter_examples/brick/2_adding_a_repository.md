---
title: "Adding a Respository"
author: "Tim Shedor"
category: "Flutter UI Example Apps"
subSection: "Brick Offline First with Rest"
tags:
    - flutter
    - Brick
---

A [Repository](https://github.com/greenbits/brick#repository) in Brick is the **only** interaction point between your app and Brick. It accepts requests and queries and chooses which [Provider](https://github.com/greenbits/brick#provider) will satisfy with data.

Most domains will contain a repository to extend in your app with minimal configuration. We'll use the `OfflineFirstWithRest` domain, which will connect our app with a [memory cache provider], a [SQLite provider], and a [REST provider]. First, import required packages and app data (saved in `lib/app/repository.dart`):

```dart
// import packages that include repository and provider definitions
import 'package:brick_offline_first/offline_first_with_rest.dart';
// import our generated migrations
import 'db/schema.g.dart';
// import our model dictionaries
// model dictionaries are lower-level, generated code. Read more about them here: https://github.com/greenbits/brick#translation-and-the-model-dictionary
import 'brick.g.dart';
```

Using the generated code and package data, we'll construct our repository. As the repository will most likely be accessed outside the widget tree in a state manager (such as a BLoC), we'll set it up as a Singleton:

```dart
class Repository extends OfflineFirstWithRestRepository {
  Repository._(String baseApiUrl)
      : super();

  factory Repository() => _singleton ?? Exception("Must call #configure first");

  static Repository _singleton;

  static void configure(String baseApiUrl) {
    _singleton = Repository._(baseApiUrl);
  }
}
```

`OfflineFirstWithRestRepository` requires some customization to setup. We'll pass the consistent arguments into `super`:

```dart
Repository._(String baseApiUrl) : super(
  restProvider: RestProvider(
    // this is the protocol + domain that all generated endpoint will suffix
    baseApiUrl,
    modelDictionary: restModelDictionary, // provided in brick.g.dart
  ),
  sqliteProvider: SqliteProvider(
    // this could be any name, and it's recommended to end with .sqlite
    "myApp.sqlite",
    modelDictionary: sqliteModelDictionary, // provided in brick.g.dart
  ),
  migrations: migrations, // provided in schema.g.dart
);
```

Our complete repository:

```dart
import 'package:brick_offline_first/offline_first_with_rest.dart';
import 'db/schema.g.dart';
import 'brick.g.dart';

class Repository extends OfflineFirstWithRestRepository {
  Repository._(String endpoint)
      : super(
          restProvider: RestProvider(
            endpoint,
            modelDictionary: restModelDictionary,
          ),
          sqliteProvider: SqliteProvider(
            "myApp.sqlite",
            modelDictionary: sqliteModelDictionary,
          ),
          migrations: migrations,
        );

  factory Repository() => _singleton ?? Exception("Must call #configure first");

  static Repository _singleton;

  static void configure(String endpoint) {
    _singleton = Repository._(endpoint);
  }
}
```
