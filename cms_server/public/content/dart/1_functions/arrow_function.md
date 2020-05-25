---
title: "Arrow functions"
author: "Eric"
category: "Dart"
subSection: "Dart Fundamentals"
order: 15
tags:
    - dart
    - functions 
---

Dart also supports a nice shorthand syntax for any function that has only one expression. In other words, is the code inside the function block only one line? Then it's probably a single expression, and you can use this syntax to be concise:

```run-dartpad:theme-dark:run-false
String makeGreeting(String name) => 'Hello, $name!';

main() {
    print(makeGreeting('Wallace'));
}
```

For lack of better term, we'll call this an _arrow function_. Arrow functions implicitly return the result of the expression. `=> expression;` is essentially the same as `{ return expression; }`. There's no need to (and you can't) include the `return` keyword.