---
title: "Tween by example"
author: "Eric"
category: "Flutter UI Example Apps"
subSection: "Custom Animation: Progress Indicator"
tags:
    - BoxShadow
    - custom widget
    - Scaffold
---

Go ahead and add this to your boiler plate. It's a small detour to see the most
basic animation in Flutter.

```dart
// You have to add this class mixin in order for flutter to know to treat it as
// an animation containing widget
class _PegProgressIndicatorState extends State<PegProgressIndicator>
    with SingleTickerProviderStateMixin {                             // new
  AnimationController _controller;                                    // new
  Animation<Color> animation;                                         // new

  @override
  initState() {
    super.initState();
    // Because this class has now mixed in a TickerProvider
    // It can be its own vsync. This is what you need almost always
    _controller = new AnimationController(
      duration: const Duration(milliseconds: 3000),
      vsync: this,
    );
    // A tween that begins at grey and ends at a green
    // The chained 'animate' function is required
    animation = new ColorTween(
      begin: const Color.fromRGBO(10, 10, 10, 0.5),
      end: const Color.fromRGBO(0, 200, 100, 0.5),
    ).animate(_controller)
    // This is a another chained method for Animations.
    // It will call the callback passed to it everytime the
    // value of the tween changes. Call setState within it
    // to repaint the widget with the new value
    ..addListener(() {
      setState((){});
    });
    // Tell the animation to start
    _controller.forward();
  }

  // This is important for perf. When the widget is gone, remove the controller.
  @override
  dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
       // This is where you pass the animation value
       // Each time set state gets called,
       // this widget gets rebuilt,
       // and the value of the animation is something in-between
       // the starting grey and the ending green
       // thanks to our ColorTween
      decoration: new BoxDecoration(color: animation.value),
      child: new Center(
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Peg()
            Peg()
            Peg()
            Peg()
          ],
        ),
      ),
    );
  }
}
```

Do a full refresh on your app. Look at the background change color.