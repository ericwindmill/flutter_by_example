---
title: "Built-in Animation: AnimatedCrossFade"
author: "Eric"
category: "Flutter Examples"
subSection: "Basic App"
tags:
    - AnimatedCrossFade
    - Duration
---

At this point, your app has all the functionality that you'll implement.

There are some easy animations Flutter gives you that will enhance the UX by a mile.

1. Add placeholder for images, so they fade in on load.
2. Add a [hero animation](https://ericwindmill.com/ux-transitions-in-flutter-fade-in-image-animated-cross-fade-and-hero-transitions) that connects your `DogCard` to the `dog_detail_page`.

### 1. Add an AnimatedCrossFade to load Widgets on state change

This all happens in your `_DogCardState` class.

```dart
// dog_card.dart

Widget get dogImage {
  var dogAvatar = Container(
    width: 100.0,
    height: 100.0,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      image: DecorationImage(
        fit: BoxFit.cover,
        image: NetworkImage(renderUrl ?? ''),
      ),
    ),
  );

  // Placeholder is a static container the same size as the dog image.
  var placeholder = Container(
    width: 100.0,
    height: 100.0,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Colors.black54, Colors.black, Colors.blueGrey[600]],
      ),
    ),
    alignment: Alignment.center,
    child: Text(
      'DOGGO',
      textAlign: TextAlign.center,
    ),
  );

  // This is an animated widget built into flutter.
  return AnimatedCrossFade(
    // You pass it the starting widget and the ending widget.
    firstChild: placeholder,
    secondChild: dogAvatar,
      // Then, you pass it a ternary that should be based on your state
      //
      // If renderUrl is null tell the widget to use the placeholder,
      // otherwise use the dogAvatar.
    crossFadeState: renderUrl == null
        ? CrossFadeState.showFirst
        : CrossFadeState.showSecond,
     // Finally, pass in the amount of time the fade should take.
    duration: Duration(milliseconds: 1000),
  );
}
```

Give your app a full restart and you should see it fade in (slowly) when the image is loaded.
