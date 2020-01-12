---
title: "Custom Widget: Peg"
author: "Eric"
category: "Flutter UI Example Apps"
subSection: "Custom Animation: Progress Indicator"
tags:
    - BoxShadow
    - BoxDecoration
    - Container
---


To start, build the `Peg` widget, which is mostly just a dumb widget that we'll create four of in our app. Each one will be animated separately. 

This widget is built by manipulating a `Container` widget. It's a container widget that's designed with a specific size, color, border radius, and box shadow. 

```dart
import 'package:flutter/material.dart';

class Peg extends StatelessWidget {
  final double marginLeft;
  final double marginRight;

  const Peg({Key key, this.marginLeft, this.marginRight}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Container(
      width: 35.0,
      height: 15.0,
      margin: new EdgeInsets.only(left: marginLeft, right: marginRight),
      decoration: new BoxDecoration(
        color: const Color.fromRGBO(0, 0, 255, 1.0),
        borderRadius: new BorderRadius.circular(10.0),
        boxShadow: [
          new BoxShadow(
            color: Colors.black12,
            blurRadius: 8.0,
            spreadRadius: 1.0,
            offset: new Offset(1.0, 0.0),
          ),
          new BoxShadow(
            color: Colors.black26,
            blurRadius: 6.0,
            spreadRadius: 1.5,
            offset: new Offset(1.0, 0.0),
          ),
        ],
      ),
    );
  }
}
```

The properties `Peg.marginLeft` and `Peg.marginRight` are used to position the pegs next to each other correctly. They will be discussed in more detail later in this tutorial.