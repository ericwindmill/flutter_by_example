---
title: "Built-in Animation: Hero transition"
author: "Eric"
category: "Flutter UI Example Apps"
subSection: "Basic App"
tags:
    - AnimatedCrossFade
    - Hero
---

The hero transition is even more impressive and easier to work with.

This is what a hero animation does:

![Hero animation screenshot](https://res.cloudinary.com/ericwindmill/image/upload/c_scale,r_5,w_300/v1521400580/flutter_by_example/hero_animation.gif)

And you can make it happen with four new lines of code.

### 1. Update the `dogImage` method of your `_DogCardState` class

```dart
// dog_card.dart

Widget get dogImage {
  // Wrap the dogAvatar widget in a Hero widget.
  var dogAvatar = Hero(
    // Give your hero a tag.
    //
    // Flutter looks for two widgets on two different pages,
    // and if they have the same tag it animates between them.
    tag: dog,
    child: Container(

    // ...
    // Close the Hero parentheses at the bottom of the dogAvatar widget.
```

### 2. Update the `dogImage` method of your `_DogDetailPageState` class

Add almost the exact same two links of code:

```dart
  Widget get dogImage {
    return Hero(
      // The same code, except the Dog property lives on the widget in this file.
      tag: widget.dog,
      child: Container(
        height: dogAvatarSize,

    // ...
    // Close the Hero parentheses at the bottom of your widget.
```
