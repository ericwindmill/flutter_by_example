---
title: "Iterable-like methods on maps"
author: "Eric Windmill"
category: "Dart"
subSection: "Iterables and Collections"
tags:
    - dart
    - map
    - collections
---

Maps have many similar methods and properties as `Iterable` types, but they aren't actually iterable. As a review from a different, earlier lesson on Flutter by Example:

#### From Flutter by Example section DataTypes:

A map, also known commonly as a dictionary or hash, is an _unordered_ collection of key-value pairs. Maps pair a key with a value for easy, fast retrieval. Like lists and sets, maps can be declared with a constructor or literal syntax.

<div class='aside'>
    Sets and maps have the the same syntax for their literal implementation. When you define a set literal, you must annotate the type of the variable. Otherwise, it will default to a `Map`.  
</div>

```dart
// literal syntax
var dogsIvePet = {
  'Golden Retriever': ['Cowboy', 'Jack'],
  'Laberdoodles': ['Wallace', 'Phoebe'], 
  'Shepards': ['Doug', 'Steak'],
}

// constructor syntax
var dogsIWantToPet = Map();

// create a key called 'Border Collie' and assign it's value
dogsIWantToPet['Border Collie'] = ['Mike', 'Jackson'];
```

### Iterable like methods on maps

Even though maps are completely different types than Iterables, it's often useful to treat them as iterables. The Map class contains many iterable-like methods on Maps.

I will run through some of these briefly with examples, but these are used similarly to iterables.

```run-dartpad:theme-light:run-false:split-60
Map<String, List<String>> dogsIvePet = {
  'Golden Retriever': ['Cowboy', 'Jack'],
  'Laberdoodles': ['Wallace', 'Phoebe'], 
  'Shepards': ['Doug', 'Steak'],
};

void main() {
  /// Map.map()
  final numberDogsSeenByType = dogsIvePet.map((String type, List<String> names) {
    return MapEntry<String, int>(type, names.length);
  });
  print(numberDogsSeenByType);
  
  
  /// Map.removeWhere()
  dogsIvePet.removeWhere((String type, List<String> names) {
    return type.contains('doodle');
  });
  print(dogsIvePet);
  
  /// Map.containsKey() (there is also containsValue())
  print(dogsIvePet.containsKey('Shepards'));
}
```

These are only a few methods, but there are few things that are map-specific I'd like to note:

- `Map.keys` returns an iterable where the elements are the keys. This can be mighty useful to do complex iterations over maps.
- `Map.values` does the same, but for values.
- Finally, `putIfAbsent`, a great method that makes code 'cleaner', and solves a problem you've likely encountered before.

You've probably seen this before:

```dart
if (!map.containsKey('myKey')) {
  map['myKey'] = 'myValue';
}
```

This pattern is often used when you want to insert a pair into a map, unless the key already exists (in which case, inserting the pair would overwrite the original pair);

You can use the `putIfAbsent` method to make this a bit cleaner.

```dart
map.putIfAbsent('myKey', () => 'myValue');
```

If the key exists, it won't do anything with the value. In fact, it won't even _create the value in memory_. This is great when the value isn't a string, and rather some complex computation.

This method also returns the value that is returned from the `ifAbsent` callback, meaning you can do some code-golf-y things like:

```dart
var users = {
 'eric': User(
    // lots of properties 
  ),
  'eli': User(
    // lots of properties
  ),
}

User _createNewUserIfNecessary({String name, int age, String username}) {
  var newUser = users.putIfAbsent(name, () => User(name, age, username));
  return newUser ?? users[name];
}
```

This contrived method will return the user you want no matter what, making the function safe to call. But, importantly, it won't do the computation of creating the user if the user already exists.
