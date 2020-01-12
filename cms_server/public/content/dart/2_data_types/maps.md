---
title: "Maps"
author: "Eric Windmill"
category: "Dart"
subSection: "Data Types"
order: 8
tags:
- dart
- data types
- type
- map
---

Dart supports many different types of _collections_, or data types that contain multiple values. The most common collections: 

- List (known as an array in some languages)
- Set
- Map

### Maps

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

Like other collections, there are many class members on the `Map` class that make it more convenient to manipulate. A couple of them are:

- `remove(key)`
- `keys`
- `values`
- `length`
- `isEmpty` and `isNotEmpty`
- `containsKey(key)`

```dart
var dogsIvePet = {
  'Golden Retriever': ['Cowboy', 'Jack'],
  'Laberdoodles': ['Wallace', 'Phoebe'], 
  'Shepherds': ['Doug', 'Steak'],
}

// remove an item
dogsIvePet.remove('Laberdoodles');

// length gives the number of key-value pairs
print(dogsIvePet.length);
// output: 2

print(dogsIvePet.keys);
// output: ['Golden Retriever', 'Shepherds']
```

<div class="aside">
Like lists, maps support collection-if, collection-for, and spread operators.
</div>