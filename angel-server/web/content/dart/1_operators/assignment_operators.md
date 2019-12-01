---
title: "Assignment Operators"
author: "Eric"
category: "Dart"
subSection: "Basic Dart Language Features"
order: 5
tags:
    - dart
    - operators
---

Assigning a value to a variable in Dart is done by using the `=` operator.

```dart
var name = "PJ"; 
```

Dart also supports _compound operators_, which are the equivalent of performing an operation and assignment.

|  Operator | Meaning  |
|---|---|
| –= | subtraction assignment  |
| /= | divisions assigment |	
| %= | modulo assignment |	
| += | addition assignment |
| *= | multiplication |	
| ~/= | integer division assignment |
| >>= | bitwise shift right assignment  |	
| ^= | bitwise XOR assignment |
| <<= | bitwise shift left assignment |	
| &= | bitwise and assignment |	
| |= | bitwise or assignment |

example:
```dart
a -= b;
// above is shorthand for
a = a - b;

// *= example
var a = 2; // Assign using =
a *= 3; // Assign and multiply: a = a * 3
assert(a == 6);
```

