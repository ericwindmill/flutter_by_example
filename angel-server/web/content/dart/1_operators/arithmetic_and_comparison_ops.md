---
title: "Arithmetic and Comparison Operators"
author: "Eric"
category: "Dart"
subSection: "Basic Dart Language Features"
order: 4
tags:
    - dart
    - operators
---

Dart supports all the operators you'd expect from a modern programming language. 

### Arithmetic

|  Operator | Meaning  |
|---|---|
| + | 	Add |
| – | 	Subtract |
| -expr | 	Unary minus, also known as negation (reverse the sign of the expression) |
| * | 	Multiply |
| / | 	Divide |
| ~/ | 	Divide, returning an integer result |
| % | 	Get the remainder of an integer division (modulo) |
| ++var |	var = var + 1 (expression value is var + 1) |
| var++ |	var = var + 1 (expression value is var) |
| --var |	var = var – 1 (expression value is var – 1) |
| var-- |	var = var – 1 (expression value is var) |


example use:
```dart
assert(2 + 3 == 5);
assert(2 - 3 == -1);
assert(2 * 3 == 6);
assert(5 / 2 == 2.5); // Result is a double
assert(5 ~/ 2 == 2); // Result is an int
assert(5 % 2 == 1); // Remainder

assert('5/2 = ${5 ~/ 2} r ${5 % 2}' == '5/2 = 2 r 1');

var a, b;

a = 0;
b = ++a; // Increment a before b gets its value.
assert(a == b); // 1 == 1

a = 0;
b = a++; // Increment a AFTER b gets its value.
assert(a != b); // 1 != 0

a = 0;
b = --a; // Decrement a before b gets its value.
assert(a == b); // -1 == -1

a = 0;
b = a--; // Decrement a AFTER b gets its value.
assert(a != b); // -1 != 0
```

### Comparison

| Operator  | Meaning  |
|---|---|
| == |	Equal |
| != |	Not equal |
| > |	Greater than |
| < |	Less than |
| >= |	Greater than or equal to |
| <= |	Less than or equal to |


example usage:
```dart
assert(2 == 2);
assert(2 != 3);
assert(3 > 2);
assert(2 < 3);
assert(3 >= 3);
assert(2 <= 3);
```