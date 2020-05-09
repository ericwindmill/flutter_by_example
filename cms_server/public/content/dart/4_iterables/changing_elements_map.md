---
title: "Changing elements: map and expand"
author: "Eric Windmill"
category: "Dart"
subSection: "Iterables and Collections"
tags:
    - dart
    - map
    - expand
    - list
    - iterables
---

Along with the lesson on `where`, I'd consider `map` the other most important functional method on iterables. At my day job, we use `List.map` _a lot_ in our Flutter UI.

In a nutshell, `map` is called on a list to generate a _new_ list, where the elements are created by performing an action on each of the original elements. That action is passed in as a callback. 

Mapping is best explained with an example.

Suppose you are trying to display a list of `Users` in an app. But, you only want to display the user's name. There's a map for that. :} 

```run-dartpad:theme-light:run-false:split-60
class User {
    User(this.name, this.age);
    final String name; 
    final int age;
}

void main() {
    final rody = User("Rody", 25);
    final jorge = User("Jorge", 25);
    final remi = User("Remí", 25);

    final users = [rody, jorge, remi];
    final names = users.map((User user) => user.name);
    print(names);
}
```
 
As mentioned, `map` is used _a lot_ in UI work, which I'll show in a later lesson on iterables in Flutter widgets. This is just a good visual example, though. I think map is used more than most other methods from the Dart SDK in my companies app, throughout the business logic as well.

To be clear, `map` isn't only useful when changing elements into different types entirely. You could also use it update all the elements in an object:

```run-dartpad:theme-light:run-false:split-60
class User {
    User(this.name, this.age);
    final String name; 
    final int age;

    bool isSpecialUser = false;
  
    String toString() {
      return 'User {name: $name, age: $age, isSpecialUser: $isSpecialUser}';
    }

}

void main() {
    final rody = User("Rody", 25);
    final jorge = User("Jorge", 25);
    final remi = User("Remí", 25);

    final newUsers = [rody, jorge, remi];
    print(newUsers);

    final asSpecialUsers = newUsers.map((User u) => u.isSpecialUser = true);
    print(asSpecialUsers);
}
```

### Using expand

Expand is an interesting one. It's not used nearly as much as `map`, but it allows you to change the values in a list in some interesting ways. It has two common use cases:

- flattening nested lists
- duplicating elements in a list (which you can also change as you're duplicating);

First, take a look at the examples from Dart docs. They're contrived, but allow you to see some important points. Then, you'll have the opportunity to give it a try using an actual example from the app that I work on at my day job.

```dart
/// example ripped directly from the Dart docs.
/// flattening a list
var pairs = [[1, 2], [3, 4]];
var flattened = pairs.expand((pair) => pair).toList();
print(flattened); // => [1, 2, 3, 4];

/// duplicating elements in a list
var input = [1, 2, 3];
// important! the callback passed to expand must return an iterable!
var duplicated = input.expand((i) => [i, i]).toList();
print(duplicated); // => [1, 1, 2, 2, 3, 3]
```

This example, again, isn't super obvious or helpful for real life. Take a stab at the exercise below, which is inspired by an actual use of `expand` in the app that I work on at my day job.


### Try it yourself: expand

Suppose you're building an e-commerce site. Your site has the functionality to show a user everything they've ever purchased. Your data might look like this: 

```dart
class User {
  final List<Order> pastOrders;
  // rest of class
}

class Order {
  final List<Item> itemsInOrder;
  // rest of class
}

class Item {
  final String name;
  // rest of class
}
```

In order to show a user which _items_ they've bought, and not _orders_ they've made, you'd likely want to extract each line item from each of their orders. There are many ways to do this, including using `expand`. For this exercise, try to derive that list of line items from the user.

<!-- 
    gist
 -->