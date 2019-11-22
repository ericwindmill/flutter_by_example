---
title: "Sets"
author: "Eric Windmill"
category: "Dart"
subSection: "Data Types"
order: 7
tags:
- dart
- data types
- type
---

Dart supports many different types of _collections_, or data types that contain multiple values. The most common collections: 

- List (known as an array in some languages)
- Set
- Map

### Sets

Sets are similar to lists, with two distinctions. While a `List` is ordered, a set is unordered. Also, the objects in a `Set` are _unique_. And that is a guarantee.

For example, if you have a `Set` of `int` objects, and you try to add `1` to the set twice, the second attempt simply won't work. It won't throw an error or fail in anyway. Instead, Dart will just realize that the `1` already exists in the set, and it'll move on. 

In order to create a set, you use the set constructor function or a `Set` literal.

```dart
// with constructor
Set<int> specialNumbers = Set();

// set literal
Set<int> literalSpecialNumbers = {1, 4, 6};
```

<span class='tip'>
    Sets and maps have the the same syntax for their literal implementation. When you define a set literal, you must annotate the type of the variable. Otherwise, it will default to a `Map`.  
</span>

Other than that, interacting with a set is similar to interacting with a `List`. 

```dart
Set<int> specialNumbers = Set();

specialNumbers.add(3);
print(specialNumbers);

specialNumbers.add(6);
print(specialNumbers);

// won't get added!
specialNumbers.add(6);
print(specialNumbers);


// output
// => [3]
// => [3, 6]
// => [3, 6]
```

