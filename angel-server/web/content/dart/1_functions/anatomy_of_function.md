---
title: "Anatomy of Dart Functions"
author: "Eric"
category: "Dart"
subSection: "Dart Fundamentals"
order: 14
tags:
    - dart
    - functions
---

Functions look familiar in Dart if you're coming from any C-like language. The anatomy of a function is pretty straightforward:

```dart
String makeGreeting(String name) { 
  return 'Hello, $name';
}
```

The first line in the function is the _signature_. It defines the return type of the function, the function name, and lists all arguments the function requires or accepts. 

The function signature follows this pattern: `ReturnType functionName(ArgumentType arg)`. And every function that uses `return` must have a return type -- otherwise, its return type is `void`.