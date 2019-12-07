---
title: "Gradient Backgrounds"
author: "Eric"
category: "Flutter Examples"
subSection: "Basic UI App"
tags:
    - flutter
    - theme
    - style
---

Time to make the app a little prettier by adding a gradient background.

Gradients are just as easy in Flutter as the are in CSS. And that's good since they're so hot right now.

To use gradients, you first need a `Container` widget, and within that you need to access its `decoration` property.

Start by building the decoration of the `Container` widget in your `_MyHomePageState` `build` method in `main.dart`.

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
      // Add box decoration
      decoration: BoxDecoration(
        // Box decoration takes a gradient
        gradient: LinearGradient(
          // Where the linear gradient begins and ends
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          // Add one stop for each color. Stops should increase from 0 to 1
          stops: [0.1, 0.5, 0.7, 0.9],
          colors: [
            // Colors are easy thanks to Flutter's Colors class.
            Colors.indigo[800],
            Colors.indigo[700],
            Colors.indigo[600],
            Colors.indigo[400],
          ],
        ),
      ),
      child: Center(
        child: DogList(initialDoggos),
      ),
    ),
  );
}
```

Now, gradients:

![gradient screen shot](https://res.cloudinary.com/ericwindmill/image/upload/c_scale,w_300/v1521385515/flutter_by_example/Simulator_Screen_Shot_-_iPhone_X_-_2018-03-18_at_07.54.46.png)
