---
title: "The main function"
author: "Eric Windmill"
category: "Dart"
subSection: "Getting Started with Dart"
order: 7
tags:
    - dart
    - main function
---

In order to write _any_ Dart program, be it a script or a Flutter app, you must define a function called `main`.

```dart
void main() {
  print('Hello, Dart');
}
```

This function tells Dart where the program starts, and it must be in the file that is considered the "entry point" for you program. By convention, this will be in a file called `main.dart`.

The main function can execute any code within it's code block that you'd like it to. 

You must have exactly one `main` function in your program.

In general, your main function will likely initiate any pre-processing needed for your program, and end with a function call that runs the rest of your app. Some examples:

### Main function in simple printing script

```dart
void main() {
  // calls to separate function
  // which handles main functionality
  printGreeting();
}
```

### Main in a Flutter app

```dart
void main() {
  // any preprocessing can be done here, such as determining a device location
  //
  // runApp is a Flutter function that runs your Flutter app
  runApp(MyApp());  
}
```

###  Main function in an AngularDart app 

```dart
void main() {
  // runApp is also used in AngularDart
  runApp(ng.AppComponentNgFactory);
}
```