---
title: "Widget types: Stateful and Stateless"
author: "Eric"
category: "Flutter"
subSection: "Widgets"
tags:
    - flutter
    - widgets
---

Flutter widgets must extend a handful of classes from the Flutter library. The two you'll use most are `StatelessWidget` and `StatefulWidget`.

The difference is that one has a concept of `State` within the Widget, which can be used to tell Flutter when to render and re-render. The other one is "dumb".

### StatelessWidget

A `StatelessWidget` is a widget that you (as the developer) are okay with being destroyed. In other words, no information is kept within it that, if lost, will matter. All of the widget's state or configuration is passed into it. Its only job is to display information and UI. Its life depends on outside forces. It doesn't tell the framework when to remove it from the tree, or when to rebuild it. Rather, the framework tells _it_ when to rebuild. 

Writing a `StatelessWidget` requires extending the correct class and including a `build` method.

```dart
class TitleText extends StatelessWidget {
  final String text;
  
  TitleText(this.text);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(text)
    );
  }
}
```

### StatefulWidget

A `Stateful Widget` is a bit different. It's actually two classes: a `State` object and the widget itself. The purpose of this class is to persist *state* when Flutter rebuilds widgets.


In Flutter, the concept of state is defined by two things:

1. The data used by the widget might change.
2. The data _can't_ be read synchronously when the widget is built. (All state
   must be established by the time the `build` method is called). 

The State object is special in that it has several methods that interact with Flutter in different ways. The most important of which is `setState`. 

`setState` is used to tell Flutter that it needs to _rebuild_, usually because something has changed and the screen needs to reflect that. In actuality, after `setState` is called, Flutter knows that it needs to call the `build` method again.

In this example, you can see setState called in the `_MyHomePageState.increaseCount` method. That will increase the `counter`  variable, and that value will be displayed  when `build` is called again (which is done automatically).

```dart
class Counter extends StatefulWidget {
  Counter({Key key, this.title}) : super(key: key);

   // Stateful Widgets don't have build methods.
   // They have createState() methods.
   // Create State returns a class that extends Flutters State class.
  @override
  _MyHomePageState createState() => new _MyHomePageState();

  // Stateful Widgets are rarely more complicated than this.
}

class _MyHomePageState extends State<MyHomePage> {
  int counter = 0;

  void increaseCount() {
	// setState is a special method that tells Flutter to repaint
	// the view because state has been updated!
	setState(() {
      this.counter++;
 	}
  }

	// gotta have that build method!
  Widget build(context) {
	return new RaisedButton(
      onPressed: increaseCount,
	  child: new Text('Tap to Increase'),
	);
  }
}
```

Importantly:

- The `StatefulWidget` class must implement the `createState` method.
- The `State` object must implement the `build` method.
- The `StatefulWidget` is immutable.
- The `State` object is mutable. 