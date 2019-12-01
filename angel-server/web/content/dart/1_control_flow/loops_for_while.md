---
title: "Loops: for and while"
author: "Eric"
category: "Dart"
subSection: "Dart Fundamentals"
order: 13
tags:
    - dart
    - loops
    - for
    - while
---

You can repeat expressions in loops using the same keywords as in many languages. There are several kinds of loops in Dart:

* Standard `for`
* `for-in`
* `while`
* `do while`

### for loops

If you need to know the index, your best bet is the standard `for` loop:

````dart
for (var i = 0; i < 5; i++) {
  print(i);
}

// prints
0
1
2
3
4
````

If you don't care about the index, the `for-in` loop is great option. It's easier to read and more concise to write.

````dart
List<String> pets = ['Nora', 'Wallace', 'Phoebe'];
for (var pet in pets) {
  print(pet);
}

// prints
'Nora'
'Wallace'
'Phoebe'
````

### while loops

`while` loops behave as you'd expect. They evaluate the condition _before_ the loop runs -- meaning it may never run at all:

````dart
while(someConditionIsTrue) {
  // do some things
}
````

`do-while` loops, on the other hand, evaluate the condition _after_ the loop runs. So they _always_ execute the code in the block at least once:

```dart
do {
  // do somethings at least once
} while(someConditionIsTrue);
```

### break and continue

These two keywords help you manipulate the flow of the loop. Use `continue` in a loop to immediately jump to the next iteration, and use `break` to break out of the loop completely:

```dart
for (var i = 0; i < 55; i++) {
  if (i == 5) {
    continue; // jump to next iteration
  }
  if (i == 10) {
    break; // stop loop immediately
  }
  print(i);
}

// prints to the console
0
1
2
3
4
6
7
8
9
```
