---
title: "Lists"
author: "Eric Windmill"
category: "Dart"
subSection: "Data Types"
order: 6
tags:
- dart
- data types
- type
---

Dart supports many different types of _collections_, or data types that contain multiple values. The most common collections: 

- List (known as an array in some languages)
- Set
- Map

### Lists

Perhaps the most common collection in nearly every programming language is the array, or ordered group of objects. In Dart, arrays are List objects, so most people just call them lists.

Dart list literals look like JavaScript array literals. Here’s a simple Dart list:

```dart
final list = [1, 2, 3];
```

Dart infers that this is variable of type `List<int>`.  When using data structures like a `List` or `Map`, you use `<` and `>` to define the types of the values within the `List` or `Map`.

The above could also be written like this:

```dart
final List<int> list = [1, 2, 3];
```

Because Dart is type safe, every member in a collection must be the same type. If you _really_ wanted a list with different types, you could define the list as `List<dynamic>`, but this is rarely useful.

