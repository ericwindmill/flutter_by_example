---
title: "Function arguments: default, optional, named"
author: "Eric"
category: "Dart"
subSection: "Dart Fundamentals"
order: 16
tags:
    - dart
    - functions
    - parameters
---

Dart functions allow positional parameters, named parameters, and optional positional and named parameters, or a combination of all of them. Positional parameters are the basic parameters, and they're required.

```dart
void debugger(String message, int lineNum) {
  // ...
}
```

To call that function, you _must_ pass in a `String` and an `int`, in that order:

```dart
debugger('A bug!', 55);
```

### Named parameters

Dart supports named parameters. _Named_ means that when you call a function, you attach the argument to a label.

Named parameters are written a bit differently. When defining the function, wrap any named parameters in curly braces (`{ }`). This line defines a function with named parameters:

```dart
void debugger({String message, int lineNum}) {}
``` 

Calling that function would look like this:

```dart
debugger(message: 'A bug!', lineNum: 44);
```

Named parameters, by default, are optional. But, using the [meta](https://pub.dev/packages/meta) package, you can annotate them and make them required:

```dart
import 'package:meta/meta.dart'

Widget build({@required Widget child}) {
  //...
}
```

The pattern you see here will become familiar when we start writing Flutter apps. For now, don't worry too much about annotations.

### Positional optional parameters

Finally, you can pass positional parameters that are optional, using `[ ]`:

```dart
int addSomeNums(int x, int y, [int z]) {
  int sum = x + y;
  if (z != null) {
    sum += z;
  }
  return sum;
}
```

You call that function like this:

```dart
addSomeNums(5, 4); // okay, because the third parameter is optional 
addSomeNums(5, 4, 3); // also okay
```

### Default parameter values

You can define default values for parameters with the `=` operator in the function signature. Default parameter values tell the function to use the defined default _only if_ nothing is passed in.

```dart
// function signature 
int addSomeNums(int x, int y, [int z = 5]) => x + y + z;

// calling that function without passing in the third argument
int sum = addSomeNums(5, 6);
assert(sum == 16); // 5 + 6 + 5

// calling that function with passing in the third argument
int sum2 = addSomeNums(5, 6, 10);
assert(sum2 == 21); // 5 + 6 + 10
```

> Default parameter values only work with optional parameters. 

> Parameters that have a default value with _never_ be null.
