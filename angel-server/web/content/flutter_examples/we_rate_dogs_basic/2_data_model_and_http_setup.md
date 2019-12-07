---
title: "Data Model and HTTP"
author: "Eric"
category: "Flutter Examples"
subSection: "Basic UI App"
tags:
    - flutter
    - ui
---

### 1. Get to a Clean Slate

All Flutter apps start with `main.dart`. Get rid of all the Counter app stuff, and you'll end up with this:

```dart
// main.dart
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    /// MaterialApp is the base Widget for your Flutter Application
    /// Gives us access to routing, context, and meta info functionality.
    return MaterialApp(
      title: 'We Rate Dogs',
      // Make all our text default to white
      // and backgrounds default to dark
      theme: ThemeData(brightness: Brightness.dark),
      home: MyHomePage(title: 'We Rate Dogs'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
    @override
    Widget build(BuildContext context) {
        /// Scaffold is the base for a page.
        /// It gives an AppBar for the top,
        /// Space for the main body, bottom navigation, and more.
        return Scaffold(
            /// App bar has a ton of functionality, but for now lets
            /// just give it a color and a title.
            appBar: AppBar(
                /// Access this widgets properties with 'widget'
                title: Text(widget.title),
                backgroundColor: Colors.black87,
            ),
            /// Container is a convenience widget that lets us style it's
            /// children. It doesn't take up any space itself, so it
            /// can be used as a placeholder in your code.
            body: Container(),
        );
    }
}

```

### 2. Create A Dog Model Class

We'll create a plain Dart class called Dog for our data model.

First, create a new file called `dog_model.dart` in the `lib` directory.

```
- lib
  -dog_model.dart
  -main.dart
```

In that file, we'll just create super basic class with a couple properties:

```dart
class Dog {
  final String name;
  final String location;
  final String description;
  String imageUrl;

  // All dogs start out at 10, because they're good dogs.
  int rating = 10;

  Dog(this.name, this.location, this.description);
}
```

### 3. Get Dog Pics

This is our one slight detour. We're going to use a super simple API to generate the dog images. This API doesn't require an API key or anything.

You can find it at [dog.ceo](https://dog.ceo). All it does is give us random images of dogs.

In your `Dog` class, add this method:

```dart
// dog_model.dart

Future getImageUrl() async {
  // Null check so our app isn't doing extra work.
  // If there's already an image, we don't need to get one.
  if (imageUrl != null) {
    return;
  }

  // This is how http calls are done in flutter:
  HttpClient http = HttpClient();
  try {
    // Use darts Uri builder
    var uri = Uri.http('dog.ceo', '/api/breeds/image/random');
    var request = await http.getUrl(uri);
    var response = await request.close();
    var responseBody = await response.transform(utf8.decoder).join();
    // The dog.ceo API returns a JSON object with a property
    // called 'message', which actually is the URL.
    imageUrl = json.decode(responseBody)['message'];
  } catch (exception) {
    print(exception);
  }
}
```

**NB:** This will also require the import of two dart packages:

```dart
import 'dart:convert';
import 'dart:io';
```

### 4. Create some sample data with the new Dog class.

In `main.dart` let's create a handful of dogs so we have something to work with.

First import `dog_model.dart`:

```dart
// main.dart

import 'package:flutter/material.dart';

import 'dog_model.dart';
```

Then add some doggos:

```dart
// main.dart in the State class

class _MyHomePageState extends State<MyHomePage> {
  List<Dog> initialDoggos = []
    ..add(Dog('Ruby', 'Portland, OR, USA',
        'Ruby is a very good girl. Yes: Fetch, loungin\'. No: Dogs who get on furniture.'))
    ..add(Dog('Rex', 'Seattle, WA, USA', 'Best in Show 1999'))
    ..add(Dog('Rod Stewart', 'Prague, CZ',
        'Star good boy on international snooze team.'))
    ..add(Dog('Herbert', 'Dallas, TX, USA', 'A Very Good Boy'))
    ..add(Dog('Buddy', 'North Pole, Earth', 'Self proclaimed human lover.'));
}
```
