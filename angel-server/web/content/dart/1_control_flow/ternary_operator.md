---
title: "Ternary Conditional operator"
author: "Eric"
category: "Dart"
subSection: "Operators"
order: 12
tags:
    - dart
    - operators
---

The ternary operator is technically that: an operator. But, it's also kind of an `if`/`else` substitute. It's also kind of a `??` alternative, depending on the situation. The ternary expression is used to conditionally assign a value. It's called _ternary_ because it has three portions: the condition, the value if the condition is true, and the value if the condition is false.

```dart
String alert = isReturningCustomer ? 'Welcome back to our site!' : 'Welcome, please sign up.';
```

In the above example `isReturningCustomer` is a boolean. If it is true, the variable called `alert` will be assigned the value "Welcome back to our site!". Otherwise, `alert` will be assigned the value "Welcome, please sign up.".  
