---
title: "Complete source code"
author: "Eric"
category: "Flutter Examples"
subSection: "Custom Animation: Progress Indicator"
tags:
    - flutter
    - animation
---


```dart
import 'package:flutter/material.dart';
import 'package:peg_progress_indicator/peg_progress_indicator_container.dart';

void main() {
  runApp(
    new MaterialApp(
      home: Scaffold(
        body: new PegProgressIndicator(),
      ),
    ),
  );
}
```

```dart
import 'package:flutter/material.dart';
import 'package:peg_progress_indicator/peg_animation.dart';

class PegProgressIndicator extends StatefulWidget {
  @override
  _PegProgressIndicatorState createState() => _PegProgressIndicatorState();
}

class _PegProgressIndicatorState extends State<PegProgressIndicator>
    with TickerProviderStateMixin {
  AnimationController _controller;
  Tween<double> tween;

  @override
  initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 3000),
      vsync: this,
    );
    tween = Tween<double>(begin: 0.0, end: 1.00);
    _controller.repeat().orCancel;
  }

  @override
  dispose() {
    _controller?.dispose();
    super.dispose();
  }

  Animation<double> get stepOne => tween.animate(
        CurvedAnimation(
          parent: _controller,
          curve: Interval(
            0.0,
            0.125,
            curve: Curves.linear,
          ),
        ),
      );
  Animation<double> get stepTwo => tween.animate(
        CurvedAnimation(
          parent: _controller,
          curve: Interval(
            0.125,
            0.26,
            curve: Curves.linear,
          ),
        ),
      );
  Animation<double> get stepThree => tween.animate(
        CurvedAnimation(
          parent: _controller,
          curve: Interval(
            0.25,
            0.375,
            curve: Curves.linear,
          ),
        ),
      );
  Animation<double> get stepFour => tween.animate(
        CurvedAnimation(
          parent: _controller,
          curve: Interval(
            0.375,
            0.5,
            curve: Curves.linear,
          ),
        ),
      );
  Animation<double> get stepFive => tween.animate(
        CurvedAnimation(
          parent: _controller,
          curve: Interval(
            0.5,
            0.625,
            curve: Curves.linear,
          ),
        ),
      );
  Animation<double> get stepSix => tween.animate(
        CurvedAnimation(
          parent: _controller,
          curve: Interval(
            0.625,
            0.75,
            curve: Curves.linear,
          ),
        ),
      );
  Animation<double> get stepSeven => tween.animate(
        CurvedAnimation(
          parent: _controller,
          curve: Interval(
            0.75,
            0.875,
            curve: Curves.linear,
          ),
        ),
      );
  Animation<double> get stepEight => tween.animate(
        CurvedAnimation(
          parent: _controller,
          curve: Interval(
            0.875,
            1.0,
            curve: Curves.linear,
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          PegAnimation(
            alignment: FractionalOffset.centerLeft,
            controller: _controller,
            animations: [
              stepOne,
              stepTwo,
            ],
            marginRight: 0.0,
            marginLeft: 0.0,
            isClockwise: true,
          ),
          PegAnimation(
            controller: _controller,
            animations: [
              stepThree,
              stepEight,
            ],
            marginRight: 0.0,
            marginLeft: 0.0,
            isClockwise: false,
          ),
          PegAnimation(
            controller: _controller,
            animations: [
              stepFour,
              stepSeven,
            ],
            marginRight: 0.0,
            marginLeft: 32.0,
            isClockwise: true,
          ),
          PegAnimation(
            controller: _controller,
            animations: [
              stepFive,
              stepSix,
            ],
            marginRight: 0.0,
            marginLeft: 32.0,
            isClockwise: false,
          ),
        ],
      ),
    );
  }
}
```

```dart
import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:peg_progress_indicator/peg.dart';

class PegAnimation extends AnimatedWidget {
  final Animation<double> controller;
  final FractionalOffset alignment;
  final List<Animation<double>> animations;
  final bool isClockwise;
  final double marginLeft;
  final double marginRight;

  PegAnimation({
    Key key,
    this.alignment: FractionalOffset.centerRight,
    @required this.controller,
    @required this.animations,
    @required this.isClockwise,
    this.marginLeft = 15.0,
    this.marginRight = 0.0,
  }) : super(key: key, listenable: controller);

  Matrix4 clockwiseHalf(animation) => new Matrix4.rotationZ((animation.value * math.pi * 2.0) * .5);
  Matrix4 counterClockwiseHalf(animation) =>
      new Matrix4.rotationZ(-(animation.value * math.pi * 2.0) * .5);

  @override
  Widget build(BuildContext context) {
    var transformOne;
    var transformTwo;
    if (isClockwise) {
      transformOne = clockwiseHalf(animations[0]);
      transformTwo = clockwiseHalf(animations[1]);
    } else {
      transformOne = counterClockwiseHalf(animations[0]);
      transformTwo = counterClockwiseHalf(animations[1]);
    }

    return new Transform(
      transform: transformOne,
      alignment: alignment,
      child: new Transform(
        transform: transformTwo,
        alignment: alignment,
        child: new Peg(
          marginLeft: marginLeft,
          marginRight: marginRight,
        ),
      ),
    );
  }
}
```

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