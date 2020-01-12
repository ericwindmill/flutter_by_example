---
title: "Cascade notation"
author: "Eric"
category: "Dart"
subSection: "Dart Fundamentals"
order: 18
tags:
    - dart
---

Cascade notation is syntactic sugar in Dart that allows you to make a sequence of operations on the same object. You can use the "double dot" to call functions on objects and access properties. This "operator" is simply used to make your code cleaner and concise. It often saves you from having to create temporary variables.

example use from the [Dart documentation](https://dart.dev/guides/language/language-tour#cascade-notation-): 
```dart
// with cascade notation:
querySelector('#confirm') // Get an object.
  ..text = 'Confirm' // Use its members.
  ..classes.add('important')
  ..onClick.listen((e) => window.alert('Confirmed!'))

// without cascade notation
var button = querySelector('#confirm');
button.text = 'Confirm';
button.classes.add('important');
button.onClick.listen((e) => window.alert('Confirmed!'));
``` 
