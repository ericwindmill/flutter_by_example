---
title: "ListView and builder pattern"
author: "Eric"
category: "Flutter UI Example Apps"
subSection: "Basic App"
tags:
    - flutter
    - build context
    - widget
---

Right now you just have a card for your dog. It would be more useful to render all of them as a list.

One of the most important concepts in Flutter UI is rendering UI lists, which is often done in builder methods.

Builder methods essentially create a widget once for each piece of data in a Dart `List`.

First, create a new file called `dog_list.dart`.

## 1. DogList Class

```dart
// dog_list.dart

import 'package:flutter/material.dart';

import 'dog_card.dart';
import 'dog_model.dart';

class DogList extends StatelessWidget {
  // Builder methods rely on a set of data, such as a list.
  final List<Dog> doggos;
  DogList(this.doggos);

  // First, make your build method like normal.
  // Instead of returning Widgets, return a method that returns widgets.
  // Don't forget to pass in the context!
  @override
  Widget build(BuildContext context) {
    return _buildList(context);
  }

  // A builder method almost always returns a ListView.
  // A ListView is a widget similar to Column or Row.
  // It knows whether it needs to be scrollable or not.
  // It has a constructor called builder, which it knows will
  // work with a List.

  ListView _buildList(context) {
    return ListView.builder(
      // Must have an item count equal to the number of items!
      itemCount: doggos.length,
      // A callback that will return a widget.
      itemBuilder: (context, int) {
        // In our case, a DogCard for each doggo.
        return DogCard(doggos[int]);
      },
    );
  }
}
```

The only thing left to do is to actually **use** the `DogList`. Replace the `DogCard` in main with the `DogList` of Dog Cards.

First, import `DogList` to `main.dart`. Note that the `dog_card.dart` import is no longer needed.

```dart
// main.dart

import 'package:flutter/material.dart';

import 'dog_list.dart';
import 'dog_model.dart';
```

Then modify the build method in `_MyHomePageState`:

```dart
// main.dart

@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text(widget.title),
      backgroundColor: Colors.black87,
    ),
    body: Container(
      // Remove the DogCard Widget.
      // Instead, use your new DogList Class,
      // Pass in the mock data from the list above.
      child: Center( // Changed code
        child: DogList(initialDoggos), // Changed code
      ),
    ),
  );
}
```

This is your app at this point with random doggos photos:

![sample app](https://res.cloudinary.com/ericwindmill/image/upload/c_scale,w_300/v1521385666/flutter_by_example/Simulator_Screen_Shot_-_iPhone_X_-_2018-03-18_at_08.07.33.png)
