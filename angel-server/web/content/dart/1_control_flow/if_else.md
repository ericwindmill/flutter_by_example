---
title: "Control Flow: if, else, else if"
author: "Eric"
category: "Dart"
subSection: "Dart Fundamentals"
order: 10
tags:
    - dart
    - control flow
    - if
    - else
---

<span class='lesson-intro-statement'>
The following is an excerpt from the book <a href="https://www.manning.com/books/flutter-in-action">Flutter in Action</a>.
</span>

Dart supports `if`, `else if`, and `else`, as you'd expect. Here's a standard `if` statement:

```dart
// this checks a single condition, 
// and the "else" block provides a fallback
if (inPortland) {
  print('Bring an umbrella!');
} else {
  print('Check the weather first!');
}

// using "else if" allows you to check for multiple conditions
// and if they all evaluate to false, fall back
if (inPortland && isSummer) {
  print('The weather is amazing!');
} else if(inPortland && isAnyOtherSeason) {
  print('Torrential downpour.');
} else {
  print ('Check the weather!');
}

// you can use as many "else if" statements as you need to
if (inPortland && isSummer) {
  print('The weather is amazing!');
} else if(inPortland && isSpring) {
  print('Torrential downpour.');
} else if(inPortland && isAutumn) {
  print('Torrential downpour.');
} else if(inPortland && isWinter) {
  print('Torrential downpour.');
} else {
  print ('Check the weather!');
}
```

> Note that the `else if` statements execute in the order that they're written. The first one that evaluates to "true" is the only code block that is executed.

Finally, Dart is sane, and a condition must evaluate to a boolean. There is only one way to say "true" (`true`) and one way to say "false" (`false`). In some languages, there is a concept of "truthiness," and all values coerce to true or false. In such languages, you can write `if (3) {`, and it works. That is not the case in Dart.
