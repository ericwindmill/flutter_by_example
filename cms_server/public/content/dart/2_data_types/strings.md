---
title: "Strings"
author: "Eric Windmill"
category: "Dart"
subSection: "Data Types"
order: 3
tags:
- dart
- data types
- type
---

`String` is the basic class with which you write text.

```dart
String greeting = 'hello, world';
String confirm = 'Press to Confirm';
String userName = 'WallaceTheCat';
```

Strings can be concatenated with `+` operator, or by simply placing multiple strings next to eachother:

```dart
print("Hello," + " World");
// Hello, World

print ("Hello" "," " World");
// Hello, World
```

You can interpolate values into strings with the `$` operator for single values, and `${}` for expressions.

```dart
var age = 29;
print("My age is $age");
// My age is 29

print("Next year I'll be ${age + 1}");
// Next year I'll be 30
```

The `String` class includes a number of methods you can use to manipulate the text.

```dart
String greeting = 'howdy'

print(greeting.split("")); 
// ['h', 'o', 'w', 'd', 'y']

assert(greeting.length == 5) // true

print(greeting.indexOf('o'));
// 2

print(greeting.contains("hat"))
// false
``` 