---
title: "Logical Operators"
author: "Eric"
category: "Dart"
subSection: "Operators"
order: 3 
tags:
    - dart
    - operators
---

Logical operators in Dart as similar to most languages. They can be used to combine or invert boolean expressions.

|  Operator | Meaning  |
|---|---|
| &&  | logical AND |
|  &#124;&#124; | logical OR |
| !expr  | invert boolean |

example use:

```dart
bool isSnowing = true;
bool isRaining = false;

assert(!isRaining); // true
assert(isSnowing || isRaining); // true because at least one is true
assert(isSnowing && !isRaining); // true because both are true
```