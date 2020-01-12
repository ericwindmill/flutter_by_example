---
title: "Wrap the Pegs in AnimatedWidgets"
author: "Eric"
category: "Flutter UI Example Apps"
subSection: "Custom Animation: Progress Indicator"
tags:
    - AnimatedWidget
    - Tween
    - Interval
---


Another awesome built in Flutter feature is `AnimatedWidgets`. These provide
two neat things:

1. You don't have to use `addListener` and `setState` on your animations to
   tell Flutter to rebuild. AnimatedWidgets have a different technique.
2. There are some built in classes that extend `AnimatedWidget` and provide
   some common 'transformations'.

This is the entire AnimatedWidget. That I built for this animation. Don't get
bogged down in the common details(like margins): I highlighted the pieces that
are important to understand.

```dart
class PegAnimation extends AnimatedWidget {
  // Animated Widgets need to be passed an animation,
  // Or in this case, multiple animations.
  final List<Animation<double>> animations;
  // They also need the controller.
  final Animation<double> controller;

  // These are properties specific to this case.
  final FractionalOffset alignment;
  final bool isClockwise;
  final double marginLeft;
  final double marginRight;

  PivotBar({
    Key key,
    this.alignment: FractionalOffset.centerRight,
    @required this.controller,
    @required this.animations,
    @required this.isClockwise,
    this.marginLeft = 15.0,
    this.marginRight = 0.0,
  }) : super(key: key, listenable: controller);

  // The AnimatedWidget in this case is animating a relatively unused value.
  // Which is the transform value on the transform widget.
  // Transforms are much like CSS transform. It accepts a variety of functions
  // on it's Transform property. This specific property will rotate a widget
  // around a designated point.
  // The most important part to understand here is that it relies
  // on the value of the animation (Interval), so it's constantly being updated
  // by the AnimatedWidget
  Matrix4 clockwiseHalf(animation) =>
      new Matrix4.rotationZ((animation.value * math.pi * 2.0) * .5);
  Matrix4 counterClockwiseHalf(animation) =>
      new Matrix4.rotationZ(-(animation.value * math.pi * 2.0) * .5);

  @override
  Widget build(BuildContext context) {
    // Tell the widget which way to rotate based on its position
    var transformOne;
    var transformTwo;
    if (isClockwise) {
      transformOne = clockwiseHalf(animations[0]);
      transformTwo = clockwiseHalf(animations[1]);
    } else {
      transformOne = counterClockwiseHalf(animations[0]);
      transformTwo = counterClockwiseHalf(animations[1]);
    }

    // This is the real trick. Just wrap the Bar widget in two transforms, one
    // for each transformation (or Interval passed in as an Animation).
    return new Transform(
      transform: transformOne,
      alignment: alignment,
      child: new Transform(
        transform: transformTwo,
        alignment: alignment,
        child: new Peg(marginLeft: marginLeft, marginRight: marginRight),
      ),
    );
  }
}
```

In order to get this all working perfectly, you'll also need to update your
`Peg` class to respect the passed in margins.

```dart
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

In the next lesson, we'll complete this animation by wiring everything up in the parent class.
