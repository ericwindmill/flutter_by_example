---
title: "Lists"
author: "Eric Windmill"
category: "Dart"
subSection: "Data Types"
order: 6
tags:
- dart
- data types
- collection
- spread
---

<div class='post-toc'>

On this page:

* [Lists](#lists)
* [Spread Operator](#spread-operator)
* [Collection If](#collection-if)
* [Collection For](#collection-for)

</div>

Dart supports many different types of _collections_, or data types that contain multiple values. The most common collections: 

- List (known as an array in some languages)
- Set
- Map

### Lists

Perhaps the most common collection in nearly every programming language is the array, or ordered group of objects. In Dart, arrays are List objects, so most people just call them lists.

Dart list literals look like JavaScript array literals. Here's a simple Dart list:

```dart
var list = List();
list.add(1, 2);

// list literal definition
var list2 = [1, 2, 3];
```

Dart infers that this is variable of type `List<int>`.  When using data structures like a `List` or `Map`, you use `<` and `>` to define the types of the values within the `List` or `Map`.

The above could also be written like this:

```dart
final List<int> list = [1, 2, 3];
```

Because Dart is type safe, every member in a collection must be the same type. If you _really_ wanted a list with different types, you could define the list as `List<dynamic>`, but this is rarely useful.

The `List` class includes a number of members to manipulate a list.

```dart
final list = [1,2,3];

assert(list.length == 3); // true
print(list.first);
// 1

print(list.last);
// 3

list.add(4);
list.addAll(5,6);
print(list);
// [1,2,3,4,5,6]
```

### Spread operator

Lists support being "spread out" into other lists. The spread operator puts each element from a list into a target list.

```dart
var list = [1,2,3];
var list2 = [0, ...list];
print(list2);
// [0,1,2,3];


// use null aware spread to avoid null-pointer crashes 
var list3 = [0, ...?list2];
```

### Collection If

You can use simple `if` and `for` statements inside list literals in order to programmatically add values. You cannot include a code block with these `if` and `for` statements inside collections, you can only add single values.

```dart
bool showToday = false;

var listOfDays = [
  "Yesterday", 
  if (showToday) "Today", // won't be added!
  "Tomorrow",
]; 

print(listOfDays);
// ["Yesterday", "Tomorrow"]
```


### Collection For

Collection `for` is used to add multiple values to a list programmatically.

```dart
var listOfDays = [
  DateTime(2018, 5, 6), 
  DateTime(2016, 5, 7), 
  DateTime(2018, 5, 8),
];

var humanReadableListOfDays = [
  "2018-05-05 00:00:00.000",
  for (var day in listOfDays) day.toString(),
  "2018-05-09 00:00:00.000",
];

print(humanReadableListOfDays);
// ["2018-05-05 00:00:00.000", "2018-05-06 00:00:00.000", "2018-05-07 00:00:00.000", "2018-05-08 00:00:00.000", "2018-05-09 00:00:00.000",]


```