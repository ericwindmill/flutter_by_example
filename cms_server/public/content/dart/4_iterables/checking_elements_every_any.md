---
title: "Checking for elements: contains, indexOf, any, every"
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

Often you may need to check that one or more elements exist in an list, and do some logic based on the logic. Dart includes some handy methods to make this easy. 

### indexOf

This is another method that exists on the list, but not sets (because lists care about index, and sets don't necessarily). You may have seen this method in other languages on arrays.

`List.indexOf(element)` returns the index of the given element in the list. If the element doesn't exist, if returns `-1`. That's important, because it doesn't throw an error if the element doesn't exist.

```dart 
List<String> animals = ['fish', 'tiger', 'crow'];
print(animals.indexOf('fish'); // 0
print(animals.indexOf('elephant'); // -1
```

### contains

`contains(element)` does exist on the base class of `Iterable`. It returns a boolean based on weather the given element is in the list or not.

```dart
List<String> animals = ['fish', 'tiger', 'crow'];
print(animals.contains('fish'); // true
print(animals.contains('elephant'); // false
``` 

The `Map` collection isn't an iterable, but contains similar methods `containsKey` and `containsValue`. These are mightly useful when keeping track of some data with a map in memory. 

```dart
Map<String, int> favoriteNumbers = {
'Greg': 3,
'Stephanie': 7,
'Alison': 4,
}

// throws error!
print(favoriteNumbers['John']);

// safe!
if (favoriteNumbers.containsKey('John')) print(favoriteNumbers['John']);
```

### any and every


<div class="aside">
This is where working with iterables can become complex if you aren't familiar with callbacks or functional programming. If that's you, don't sweat it. Take your time, take a nap, you'll get it.
</div>

#### First, a review

First, let's take another look at the most 'basic' functional method on iterables: `forEach`. This method will touch every element in the iterable, in order, and call the function you pass in as an argument on each element. It's no different than looping over each element and calling the same function:

```run-dartpad:theme-light:run-false:split-60
void main() {
   List<int> ages = [29, 27, 42];
    
    // should print 30, 28, 43
    for (var age in ages) {
        _addAndPrint(age);
    }

    // should print 30, 28, 43
    ages.forEach((int age) => _addAndPrint(age));
}

void _addAndPrint(int number) {
    print(1 + number);
}
``` 


<div class="aside">
One advantage to using forEach is that you can pass in a function _without_ calling it, and Dart is smart enough to decipher what you're trying to do. 

```dart 
ages.forEach(_addAndPrint);

// This is *exactly* the same as:

ages.forEach((int age) => _addAndPrint(age)); 
```

If this makes your head spin, don't worry about it. It does nothing but make the code cleaner. 
</div>

#### any

`Iterable.any` is a method that returns true if any single element in the iterable satisfies a 'test' that's passed in as a callback. For example, if you have a list of users and want to find out if any of them are under 18, `any` would be a good method to use.

```run-dartpad:theme-light:run-false:split-60
class User {
  User(this.name, this.age);

  final String name;
  final int age;
}

List<User> users = [
  User('Zoltan', 55),
  User('Trey', 19),
  User('Marsha', 32),
];

void main() {
  final anyUnder18 = users.any((User u) => u.age < 18);

  if (anyUnder18) {
    print('Sorry, kid');
  } else {
    print('commence party!');
  }
}
```

#### every

`Iterable.every` is like any, but returns true if and only if each element in the list satisfies the test passed in as a callback.

```run-dartpad:theme-light:run-false:split-60
class User {
  User(this.name, this.age);

  final String name;
  final int age;
}

List<User> users = [
  User('Zoltan', 55),
  User('Trey', 19),
  User('Marsha', 32),
];

void main() {
  final allUsersAbleToParty = users.every((User u) => u.age > 18);

  if (allUsersAbleToParty) {
    print('Sorry, kid');
  } else {
    print('commence party!');
  }
}
```

As you can see, these methods are similar. The above functionality was implemented with only two changes. `any` became `every` and `u.age < 18` changed to using a greater than sign.

A real-life use case that you may find for these methods is when checking roles or permissions on a user. For example, can this user make a sale? Well, lets see if they have any of the roles that allow users to make sales. Alternatively, maybe they need _every_ role. 

The following DartPad exercise asks you to implement that feature: 

<!-- gist
    find out if the user has _any_ permissions and if the user has every permissions
--> 