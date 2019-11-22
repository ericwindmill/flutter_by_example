---
title: "dynamic"
author: "Eric Windmill"
category: "Dart"
subSection: "Data Types"
order: 5
tags:
- dart
- data types
- type
---

### Inferring the type

Dart is a _typed language_. The type of the variable `message` is String. Dart can infer this
 type, so you did't have to explicitly define it as a String. Importantly, this variable must be
  a String forever. You cannot re-assign the variable as an integer. If you did want to create a
   variable that's more dynamic, you'd use the `dynamic` keyword. We'll see examples of that in a later lesson.
   
```dart
dynamic message = 'Hello World';
```

You can safely re-assign this variable to an integer. 

```dart
dynamic message = 'Hello, World';
message = 8; 
```

*NB*: It's rarely advisable to use `dynamic`. Your code will benefit from being type safe.  