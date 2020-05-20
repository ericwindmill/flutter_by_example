---
title: "ValueListenableProvider (for animations)"
author: "Eric Windmill"
category: "Flutter State and Logic Example Apps"
subSection: "Provider"
tags:
- flutter
- state management
- provider
- consumer
- ValueListenableProvider
---

[ValueListenableProvider] is used to provide Flutter classes called [ValueListenable](). As you can see in the docs, this Flutter object has two uses: First, for a `ValueNotifier`, and second, for `Animations`.

`ValueNotifier` is a class that wraps a single value with a `ChangeNotifier`. It's mostly used to help Flutter rebuild widgets from single values, when using a `StatefulWidget` with `setState` is too much. The benefit of using `ValueNotifier` is usually performance. You can use it in a `StatelessWidget` to rebuild just a tiny portion of the subtree based on a single value. 

In this example widget, using a `StatefulWidget` is over-kill. (In fact, the more you use Flutter, the more you'll find that you rarely need StatefulWidgets, because the SDK includes so many stateful widgets that abstract away state management).

By combining a `ValueNotifier` with a `ValueListenableBuilder`, you've avoided using a a StatefulWidget, and thus you'll be re-rendering only the exact widgets that need to be rendered when the value changes. Neat.

```dart
class HighlightedText extends StatelessWidget {
  final ValueNotifier<bool> isHighlighted = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: ValueListenableBuilder(
        valueListenable: isHighlighted,
        builder: (BuildContext context, bool b, Widget child) {
          return Container(
            color: b ? Colors.yellow.shade200 : Colors.white,
            child: Text('This is some cool text'),
          );
        },
      ),
      onTap: () {
        isHighlighted.value = !isHighlighted.value;
      },
    );
  }
}
```

The example above is used only to explain what a `ValueNotifier` is. As you may have guessed, this doesn't seem like a great use-case for Provider. After all, the single value is needed only for this one widget. 

In most cases, `ValueListenableProvider` is not what you want to use. You are likely going to be using `ChangeNotifierProvider` in any situation that calls for using a separate class to manage state. 

But, there is one exception: animations. `Animation` types in Flutter implement the `ValueListenable` class. It's possible that you'd have a complicated animation that exists over several widgets, and maybe you want them all to be synchronized. This is one great use-case for `ValueListenableProvider`. (Frankly, it's the only use case I can imagine that I'd use this, because `ChangeNotifier` is so similar.)  

Animations in Flutter require that you pass a `Listenable` value, and there's a class that implements `Listenable` called `AnimationController`

```dart

``` 

