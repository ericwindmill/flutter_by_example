---
title: "Initializer lists and final properties"
author: "Eric Windmill"
category: "Dart"
subSection: "Object-Oriented Programming"
tags:
    - initializer list
    - object oriented programming
    - class
    - final
---

Class fields in Dart can be `final`. Marking a field as `final` tells Dart that this variable can never be re-assigned. Importantly, this doesn't mean that the variable must be declared and assigned at the same time. Often, you'll use the `final` keyword for class properties, and assign them a value in the constructor. 

```dart
class Rectangle {
  // these are assigned in the constructor,
  // and can never be changed.
  final int width;
  final int height;
  
  Rectangle(this.width, this.height);
}
``` 

Side note: This square is said to be _immutable_. All of it's field are final, so it cannot be changed once created.

### Initializer Lists

An _initializer list_ allows you to assign properties to a new instance variables _before_ the constructor body runs, but after creation. This is handy when you want to set a final variables value, but the value isn't a compile-time constant. For instance:

```run-dartpad:theme-light:run-false:split-60

main() {
  final rectangle = Rectangle(2, 5);
}

class Rectangle {
  final int width;
  final int height;
  final int area;
  
  The area of the rectangle uses the `width` and `height`
  variables, but cannot be done outside of the constructor
  because the class doesn't know what the width and height
  are equal to until an instance is created.
  Rectangle(this.width, this.height) 
    : area = width * height {
      print(area);
    }
}
```







