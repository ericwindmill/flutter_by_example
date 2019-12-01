---
title: "Type Test Operators"
author: "Eric"
category: "Dart"
subSection: "Operators"
order: 5
tags:
    - dart
    - operators
---

Dart is a typed language, and it's often useful to assert that a value is of a correct type, or _change_ the type of a value to a related type. Typecasting is quite a bit topic, but here we'll discuss the basics. 

|  Operator |  Meaning |
|---|---|
|is	 | True if the object has the specified type |
|is! | 	False if the object has the specified type |
|as	 | Typecast (also used to specify library prefixes) |

example "is" use:
```dart
// suppose your program has these three subclasses of User
class Customer extends User {...}
class Employee extends User {...}
class Boss extends User {...}

// And suppose there's a variable called 'user',
// and it could be any of the subclasses of 'User' 

// handle a customer
if (user is Customer) {
  // do something
}

// assert that the user is an employee or boss 
if (user is! Customer) {
  // do something
}
```

### Intro to Typecasting

Typecasting can be useful in many ways, but as an intro to using `as`, let's suppose you have a class called `User`, and several subclasses of `User`. Each of these subclasses will have different properties from each other. You can use `as` to access these sub-class specific properties in your code.

```dart
class User {}

class Customer {
  String address;
}

class Employee {
  DateTime shiftStartTime;
}

// suppose you have a User object here,
// but you know in this function you'll always 
// be dealing with the "employee" sub-types

clockIn(User user) {
  // case the user object as it's subtype
  (user as Employee).shiftStartTime = now;
}


// NB: this is important because if you didn't use 'as'
// the Dart compiler doesn't know if the user is an Employee or Customer,
// and can't guarantee that the the `startShiftTime` property exists.
// example:
user.startShiftTime = now; // will this work? who knows! 
``` 