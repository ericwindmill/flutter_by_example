---
title: "Bitwise and Shift Operators"
author: "Eric"
category: "Dart"
subSection: "Dart Fundamentals"
order: 9
tags:
    - dart
    - operators
---

You can manipulate the individual bits of numbers in Dart. Usually, you’d use these bitwise and shift operators with integers.

| Operator |	Meaning |
|---|---|
| & |	AND |
|  &#124; |	OR |
| ^ |	XOR | 
| ~expr	| Unary bitwise complement (0s become 1s; 1s become 0s) |
| <<	| Shift left | 
| \>>	| Shift right|

Here’s an example of using bitwise and shift operators:

```dart
final value = 0x22;
final bitmask = 0x0f;

assert((value & bitmask) == 0x02); // AND
assert((value & ~bitmask) == 0x20); // AND NOT
assert((value | bitmask) == 0x2f); // OR
assert((value ^ bitmask) == 0x2d); // XOR
assert((value << 4) == 0x220); // Shift left
assert((value >> 4) == 0x02); // Shift right
```