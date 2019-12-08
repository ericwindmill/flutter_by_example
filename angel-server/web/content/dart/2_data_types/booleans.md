---
title: "Booleans"
author: "Eric Windmill"
category: "Dart"
subSection: "Data Types"
order: 4
tags:
- dart
- data types
- type
- boolean
---

`bool` is the Dart type that represents a boolean value.  It can be `true` or `false`.

```dart
// assign directly
bool isPortland = true;
bool isWinter = true;

// You can combine booleans with &&, ||, and other symbols
// if isPortland is true AND isWinter is true
bool isRaining = isPortland && isWinter;

if (isRaining) {
  print("Grab an umbrella!");
} else {
  print("The sun is shining!");
}

// prints
"Grab an umbrella!"
```
