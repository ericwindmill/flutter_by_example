---
title: "Values and variables"
author: "Eric Windmill"
category: "Dart"
subSection: "Dart Fundamentals"
order: 1
tags:
    - dart
    - variables
---

The basic building block of information in your Dart program will be variables. Anytime you're
 working with data in an app, you can store that data in variables.  For example, if you're
  building a chat application, you can use variables to refer to chat messages or a user.
  
Variables store references to these _values_.
  
## Defining Variables

One of many ways, and the simplest way, to define a variable in Dart is using the `var` key word. 

```dart
var message = 'Hello, World';
```

This example creates a variable called `message`, and also _initializes_ the variable with a
 String value of `Hello, World`. Now, you can access that value by referring to the `message
 ` variable.
 
```dart
var message = 'Hello, World';
print(message);

// => Hello, World
```

## Inferring the type

Dart is a _typed language_. The type of the variable `message` is String. Dart can infer this
 type, so you did't have to explicitly define it as a String. Importantly, this variable must be
  a String forever. You cannot re-assign the variable as an integer. If you did want to create a
   variable that's more dynamic, you'd use the `dynamic` keyword. We'll see examples of that in a later lesson.
   
```dart
dynamic message = 'Hello World';
```

You can safely re-assign this variable to an integer. 

```dart
dynamic message = 'Hello, World';
message = 8; 
```

*NB*: It's rarely advisable to use `dynamic`. Your code will benefit from being type safe.  



