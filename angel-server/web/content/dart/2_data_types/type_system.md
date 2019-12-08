---
title: "Intro to Dart's Type System"
author: "Eric Windmill"
category: "Dart"
subSection: "Data Types"
order: 1
tags:
- dart
- type system
---

Dart's type system is straightforward enough (as far as type systems go). But it is a big topic, especially if you've never used a typed language before. It's such a big topic that we can't possibly cover it in this lesson alone. This is just an introduction.

Before I became a Dart developer, I wrote Ruby, Python, and JavaScript, which are dynamic. When I started writing Dart, I found using types to be the biggest hurdle. (But now, I don't want to live in a world without them.)
 
To start, let's look at a few key places in which types are established in Dart.

### When defining variables

Rather than using `var` to define variables, you can use the variables type.

```dart
// The name variable must be a String
String name;

// The age variable must be an int
int age;
```

Using types when defining variables prevents you from assigning values to variables that aren't
 compatible.

```dart
// doesn't work!
int age = 'hello';
```

If you try to run that file in your terminal, Dart will throw an error.

```dart
Error: A value of type 'dart.core::String' can't be assigned to a variable of type 'dart.core::int'.
Try changing the type of the left hand side, or casting the right hand side to 'dart.core::int'.
```

This kind of build time error is what makes Dart _type safe_. Types ensure at compile time that your
 functions all get the right kind of data. 

<div class="aside"> 
If you're using one of the IDEs suggested in the appendix and have installed the Dart plugin, you won't even get that far. The linter will tell you you're using the wrong type straight away. This is, in a nutshell, the value of type systems.
</div>

### Types in functions

Types are also used to define the _return_ value of functions. The main function of every Dart program has a return type of `void`, because it doesn't return anything.

```dart
// void is the return type
void main() {
  print('hello world');
}
```

Any function that's being used for its _side effects_ should have this return type. It means the function returns nothing. Other functions, though, should declare what they're going to return. This function returns an `String`:

```dart
String greeting() {
  return "Hello World"; // returns this String
}
```

This would fail if you tried to return the wrong type.

```dart
String greeting() {
  return 45; // fails, because 45 is an int!
}
```

Return types are also used in functions when defining the arguments that function expects. 

```dart
// this function expects two integers
int addNums(int x, int y) {
  return x + y;
}

// you'd call it like this
int sum = addNums(4, 5);

// this wouldn't work
int sum = addNums(3, "five"); // error!
```

Dart has several built in types, which you can find [here]().

