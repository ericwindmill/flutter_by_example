---
title: "Lexical Scope"
author: "Eric"
category: "Dart"
subSection: "Dart Fundamentals"
order: 17
tags:
    - dart
    - operators
---

<span class='aside'>
The following is an excerpt from the book <a href="https://www.manning.com/books/flutter-in-action">Flutter in Action</a>.
</span>

Dart is _lexically scoped_. Every code block has access to variables "above" it. The scope is defined by the structure of the code, and you can see what variables are in the current scope by following the curly braces outward to the top level:

<!-- TODO: add diagram -->

```dart
String topLevel = 'Hello';

void firstFunction() {
  String secondLevel = 'Hi';
  print(topLevel);
  nestedFunction() {
    String thirdLevel = 'Howdy';
    print(topLevel);
    print(secondLevel);
    innerNestedFunction() {
      print(topLevel);
      print(secondLevel);
      print(thirdLevel);
    }
  }
  print(thirdLeve);
}

void main() => firstFunction();
```

This is a valid function, until the last `print` statement. The third-level variable is defined outside the scope of the nested function, because scope is limited to its own block or the blocks above it. (Again, a block is defined by curly braces.)
