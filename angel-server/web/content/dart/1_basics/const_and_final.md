---
title: "const and final variables"
author: "Eric Windmill"
category: "Dart"
subSection: "Dart Fundamentals"
order: 3
tags:
- dart
- hello world
---

<div class='post-toc'>

On this page:

* [const](#const)
* [final](#final)

</div>


In the previous lesson, we saw how to use `var` to define variables. In place of `var`, you can also use the const and 
 final keywords. The two are similar in the fact that they can never be reassigned. When they have their value, that's the value forever. 
 
### const 

A `const` variable must be _compile-time constant_. (const is shorthand for "constant".) Once const is assigned a value, it can never change. 

```dart
const name = "Greg";

// doesn't work!
name = "Sarah";
```

The phrase "compile-time constant" is important. It means that there can't be any ambiguity in the value, even before it's used in your code. For example, you cannot assign a `const` variable a value from the return value of a function. It can only be set to values that _always_ resolve to the same value, such as Strings, numbers, arithmetic operation.

```dart
const name = "Greg"; 
const age = 25; 
const screenHeight = 15 + 15; 

const double cost = 5.55;
const collectionOfDoubles = [14.55, cost]; // okay because "cost" is also a constant double

// not allowed!
// the compiler can't know this width until the function is called.
 const screenWidth = getScreenWidth();
``` 

### final

`final` is similar to `const`, but it doesn't have to be constant at compile time. It can be assigned to any value, including non-const values, but it cannot change once it has been set.

```dart
final name = "Greg";

// doesn't work!
name = "Sarah";
```

`final` also must be set when the variable is created, unlike `var`. For example:

```dart
// okay
var name;
name = "Wallace";

// doesn't work!
final name;
name = "Wallace";
```

The only place that you'd define a final variable and not give it a value straight away is on class properties, which we'll explore later.r



