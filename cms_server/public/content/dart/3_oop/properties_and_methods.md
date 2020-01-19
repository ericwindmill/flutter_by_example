---
title: "Properties and methods"
author: "Eric Windmill"
category: "Dart"
subSection: "Object-Oriented Programming"
tags:
    - object oriented programming
    - methods
    - properties
    - instance methods
---

The interface of an object is exposed via _instance properties_ and _instance methods_.

These are the most "basic" members on a class. 

### Properties

Properties are variables of any type defined on the class. 

```dart
class Cat {
  String name; // property
  String color; // property
  int age; // property
}

// useage:
var cat = Cat();
cat.name = 'Wallace'; 
print(cat.name);
``` 

### Methods

Methods are functions on a class that provide behavior for an object. _Instance methods_ on objects are exposed via instances of the class. They have access to other variables and methods on the instance, as well as the keyword `this`.

```dart
class Cat {
  String name; // property
  String color; // property
  int age; // property

  void talk() {
   print('meow!');
  }
}

// useage:
var cat = Cat();
cat.talk();
```