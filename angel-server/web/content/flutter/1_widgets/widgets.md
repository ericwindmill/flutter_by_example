---
title: "Intro to Widgets"
author: "Eric"
category: "Flutter"
subSection: "Widgets"
tags:
    - flutter
    - widgets
---

*Widgets* are building blocks which you, the developer, will compose together to make a UI. When learning Flutter, you'll hear the phrase "everything is a widget" quite often. For our purposes now, that's true. Every object in your Flutter application's UI is a widget. Structure is defined with widgets, styles are defined with widgets, even animations and routing is handled by widgets. And, widgets are just Dart classes that know how to describe their view.

In the image below, a few of the widgets on-screen are highlighted.

<img src="counter_app_annotated.png" alt="drawing" style="width:400px;"/>

These are some of the most basic widgets, but there are a lot of implications here. First, you have a `Text` widget and a `Button` widget. These represent tangible pieces of UI. But, notice that there's also a `Column` widget. This widget tells other widgets to arrange themselves vertically. Importantly, there's no CSS or styling language, it's just widgets.


### Built in Widgets

The above image shows the "counter app", which is the default application that's built when you start a new Flutter project. Which means that everything on that screen is built into Flutter. 

Flutter offers several widgets out of the box, which we, the Flutter developers, will combine to make custom widgets and robust UI. Here are just a few of the most basic built in widgets in Flutter, separated by their use.

* _Layout_--`Row`, `Column`, `Scaffold`, `Stack`
* _Structures_--`Button`, `Toast`, `MenuDrawer`
* _Styles_--`TextStyle`, `Color`
* _Animations_--`FadeInPhoto`, transformations
* _Positioning and alignment_--`Center`, `Padding`

### Writing a widget in code

Most of the Flutter code you write will be creating custom widgets. Widgets are just Dart class that _extend_ a `Widget` class. Suppose you wanted to make a button widget with custom styling. This is how you'd define the class:

```dart
class AlertButton extends StatelessWidget {
  // class members
}
```

<div class="aside">
The class `StatelessWidget` is the most basic widget class, and the one you'll use the most often. We'll cover the different types of widgets later.
</div>

When creating widgets, there is one requirement enforced by the widget superclass. It must have a `build` method. This method must return other widgets. It's the method that you use to compose widgets together to make a UI.

Using that same `AlertButton` example:

```dart
class AlertButton extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      color: Colors.red,
      child: Text("Alert!")
    );
  } 
}
``` 

Other than the `build` method, Widgets are just like any other Dart class. You can add methods and properties to the widget classes.

```dart
class AlertButton extends StatelessWidget {
  // a property on this class
  final String text;

  // a constructor for this class
  AlertButton(this.text);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      color: Colors.red,
      child: Text(text), // use the text passed in to the constructor.
    );
  } 
}
``` 


