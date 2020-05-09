---
title: "Switch statements and case"
author: "Eric"
category: "Dart"
subSection: "Dart Fundamentals"
order: 11
tags:
    - dart
    - control flow
    - switch
---

<div class='aside'>
The following is an excerpt from the book <a href="https://www.manning.com/books/flutter-in-action">Flutter in Action</a>.
</div>

`switch` statements are great when there are many possible conditions for a single value. These statements compare `int`s, `String`s, and compile-time constants using `==`. In other words, you must compare a value to a value of the same type that cannot change at runtime. If that sounds like jargon, here's a simple example:

```dart
int number = 1;
switch(number) {
  case 0:
    print('zero!');
    break; // The switch statement must be told to exit, or it will execute every case.
  case 1:
    print('one!');
    break;
  case 2:
    print('two!');
    break;
  default:
    print('choose a different number!');
}
```

That's perfectly valid. The variable `number` could have any number of values: it could be 1, 2, 3, 4, 66, 975, -12, or 55. As long as it's an `int`, its a possible value for `number`. This `switch` statement is simply a more concise way of writing an `if/else` statement.
Here's an overly complex `if`/`else` block, for which you should prefer a `switch` statement:

```dart
int number = 1;
if (number == 0) {
    print('zero!');
} else if (number == 1) {
    print('one!');
} else if (number == 2) {
    print('two!');
} else {
    print('choose a different number!');
}
```

That's what a `switch` statement does, in a nutshell. It provides a concise way to check for any number of values. It's important, though, to remember that it only works with runtime constants. This is not valid:

```dart 
  int five = 5;
  switch(five) {
      case(five < 10):
      // do things...
  }
```

`five < 10` isn't constant at compile time and therefore cannot be used. It could be true or false. You cannot do computation within the case line of a switch statement.

### Exiting a Switch statement

Each case in a `switch` statement should end with a keyword that exits the switch. If you don't, the switch statement will execute multiple blocks of code.

```dart
switch(number) {
  case 1:
    print(number);
    break; // without this, the switch statement would execute case 2 also!
  case 2:
    print(number + 1)
    break;
}
```

Sometimes, it is desirable to execute multiple blocks of code. to In `switch` statements, you can fall through multiple cases by not adding a `break` or `return` statement at the end of a case:

```dart
intnumber = 1;
switch(number) {
  case -1:
  case -2:
  case -3:
  case -4:
  case -5:
    print('negative!');
    break;
  case 1:
  case 2:
  case 3:
  case 4:
  case 5:
    print('positive!');
    break;
  case 0:
  default:
    print('zero!');
    break;
}
```

In this example, if the number is between -5 and -1, the code will print `negative!`.

Most commonly, you'll use `break` or `return`. `break` simply exits out of the switch; it doesn't have any other effect. It doesn't return a value. In Dart, a `return` statement immediately ends the function's execution, and therefore it will break out of a `switch` statement. In addition to those, you can use the `throw` keyword, which throws an error.

### Execute multiple cases with "continue"

Finally, you can use a `continue` statement and a label if you want to fall through but still have logic in every case:

```dart 
String animal = 'tiger';
switch(animal) {
  case 'tiger':
    print("it's a tiger");
    continue alsoCat;
  case 'lion':
    print("it's a lion");
    continue alsoCat;
  alsoCat:
  case 'cat':
    print("it's a cat");
    break;
  // ...
}
```

This `switch` statement will print `it's a tiger` and `it's a cat` to the console.
