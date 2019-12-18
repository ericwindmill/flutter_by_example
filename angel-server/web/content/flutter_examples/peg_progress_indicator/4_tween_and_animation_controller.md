---
title: "Tween and AnimationController classes"
author: "Eric"
category: "Flutter Examples"
subSection: "Custom Animation: Progress Indicator"
tags:
    - BoxShadow
    - custom widget
    - Scaffold
---

All Flutter Animations need two things:

1. An AnimationController. This controller has two important purposes. First,
   it defines how long the animation will last via it's `duration` property. It's
   other purpose is to provide a handful of methods that tell the animation how to
   behave. i.e. `repeat()`, `forward()` and `reverse()`.

2. Tweens. `Tween` is short for 'in between', and it represents the value of
   the property changing in between frames. For example, if you're animating the
   opacity of a container from 0.0 to 1.0, your tween will represent the values at
   `0.1`, `0.2`, and so on.

You set up Tweens by creating new Tween class and passing the starting and
ending values. In the opacity example, because opacity values are `doubles`
you'd do something like this:

```dart
Tween<double> tween = new Tween<double>(begin: 0.0, end: 1.0);
// then you'd animate it, but more on that in a bit
```

But if you wanted to animate from blue to green, Flutter Tweens can do that too:

```dart
ColorTween colorTween = new ColorTween(
  begin: Colors.blue[400],
  end: Colors.green[400],
);

// then you'd animate it, but more on that in bit.
```

The point is, Tween's return values at periods between start and finish, which
you can pass as props to whatever you're animating, so it's always getting
updated. 

In the next lesson, we'll see an example of using these classes.