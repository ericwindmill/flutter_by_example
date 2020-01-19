---
title: "Mixins"
author: "Eric Windmill"
category: "Dart"
subSection: "Object-Oriented Programming"
tags:
    - object oriented programming
    - inheritance
    - mixin
    - class
---

Mixins are a way of reusing a class’s code in different class hierarchies. For example, you might have a class called `Employee` which has methods like `clockIn`. The code in those classes may be useful for both `Bartender` and `Nurse`. But, now imagine you're introducing a class called `Doctor`. You probably have some functionality on `Nurse` (such as a method called `takeTemperature`) that you'd like on `Doctor`, but not that you want to add to `Employee`. This is a great place to use a `mixin` called `Medical`.

```dart
class Employee {
  void clockIn() {...}
}

mixin Medical {
   int takeTemperature {...}
}



// use mixins on your classes via the `with` keyword
class Nurse extends Employee with Medical {}
class Doctor extends Employee with Medical {
  performSurgery() {...}  
}
class Bartender extends Employee {}
```

With this architecture, your bartender can 'clock in', but cannot 'takeTemperature'. Both Nurse and Doctor can do both, and the doctor can performSurgery. 