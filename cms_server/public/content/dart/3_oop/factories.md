---
title: "Factory methods"
author: "Eric Windmill"
category: "Dart"
subSection: "Object-Oriented Programming"
tags:
    - dart
    - object oriented programming
    - class
    - factory
---

Factory constructors return am instance of the class, but it doesn't necessarily create a new instance. Factory constructors might return an instance that already exists, or a sub-class.

Rules for factory constructors:

- Factory constructors _do_ use the `return` key word.
- You cannot refer to 'this' within the factory constructor.

```run-dartpad:theme-light:run-false:split-60
class Cat {
    String name;
    String color;
 
    // factory constructor that returns a new instance 
    factory Cat.fromJson(Map json) {
        return Cat(json['name'], json['color']);
    }
} 
```