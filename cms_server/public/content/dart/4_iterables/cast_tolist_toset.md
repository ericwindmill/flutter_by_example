---
title: "Type casting collections: cast, as, retype, toSet, toList"
author: "Eric Windmill"
category: "Dart"
subSection: "Iterables, Iterators, and Collections"
tags:
    - dart
    - indexOf
    - any
    - every
    - iterables
---

Often, especially when working with methods on lists and sets, the _type_ of the return list (or elements) is not quite what you need. Iterables in Dart solve this problem by providing several typecasting methods.

The most straight forward methods are `toList` and `toSet`. And, believe it or not, you will need to use these methods _a lot_ to avoid typing issues if you plan on using and the methods from this tutorial. 

`toList` simply turns an iterable into a list, and `toSet` into a set. These are so valuable because most of the functional methods on iteratbles return values of type `Iterable`, _even if they're called on lists_. Let's take a look at `where`, as an example:

```dart
void main() {
    List<int> ages = [12,17,19,14,21,20,15];
    final oldEnough = ages.where((int age) => age >= 18);
    print(oldEnough.runtimeType); // WhereIterable
}
```

The type of that variable is `WhereIterable`, not list. Which is fine in the small example above, but won't be fine if you trying to use it as a list elsewhere in the app.

```dart
void printList(List list) {
  for (var element in list) {
    print(element);
  }
}

void main() {
    List<int> ages = [12,17,19,14,21,20,15];
    final oldEnough = ages.where((int age) => age >= 18);
    printList(oldEnough); // Error! WhereIterable is not of type List
}
```

Solving this problem is easy enough, though. Just call `oldEnough.toList()`


```run-dartpad:theme-light:run-false:split-60
void printList(List<int> list) {
  for (var element in list) {
    print(element);
  }
}

void main() {
    List<int> ages = [12,17,19,14,21,20,15];
    final oldEnough = ages.where((int age) => age >= 18).toList(); // noice
    printList(oldEnough); 
}
```

### casting the elements in a list

Turns out, this a topic of much conversation. 

Sometimes, you have a list of elements that are of a certain type, but you want those elements to be of a different type, in order to make the analyzer happy. To make that more clear, let's walk through an example:

<div class="aside">
The first set of examples here has nothing to do with iterables, but explains the keyword `as`. We will transition into working with `as` with iterables.
</div>

Suppose you have a `User` class that looks like this.

```dart
class User {
  String name;
  int age;
}
```

This is great, but now your app needs "roles", which means different sub-types of Users. Perhaps you now have these classes:

```dart
class Manager extends User {
  void accessEmployeeRecords() {};
  void accessMyRecord() {}
}

class Bartender extends User {
  void accessMyRecord() {}
}
```

These classes are pretty similar, but the manager can see everyone's records. Imagine an iPad app in which each user has a profile, including their record. Now, to fetch the records, you have a method that expects a `User` as an argument. This is fine, but because `Manager` contains a method that `Bartender` doesn't, you cannot just call `User.accessEmployeeRecords()`, _even if you know in your brain that a manager is passed in_. You must _typecast_ this user as a manager. 

The first example of doing this is with the `as` keyword.

```dart 
void accessRecords(User user, bool isManager) {
   if (isManager) {
     (user as Manager).accessEmployeeeRecords();
   }

   user.accessMyRecord();
}
```

Using `as` tells the analyzer that this is okay, that you want to call the method as if this user was a manager.

`as` is considered the "safest" form of typecasting in dart, and it is used quite often in Flutter UI, particularly when using the [bloc library](https://pub.dev/packages/bloc).

Importantly, `as` can only cast _down_. So, `User as Manager` is fine, but `Manager as User` is not okay.

### Using `cast`

One of the other casting keywords, which lives particularly on Iterables, is `cast<T>`. It gives you a new list which _appears_ to be of the type `List<T>`, so that you can use it in places where the analyzer _expects_ `List<T>`, but it doesn't actually change the types of the elements. 

Run the example below... what is printed out might surprise you:  

```run-dartpad:theme-light:run-false:split-60
void main() {
  List<num> coolNums = [1, 2, 3.1];
  List<double> coolDoubles = coolNums.cast<double>();
  
  printDubs(coolDoubles);
  
}

void printDubs(List<double> dubs) {
  for (var d in dubs) {
    print(d.runtimeType);
  }
}
```

   
Of course, this feels a bit dangerous, and is hardly ever recommended that you use `cast`.



