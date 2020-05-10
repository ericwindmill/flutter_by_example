---
title: "Filtering elements: where, takeWhile, and skipWhile"
author: "Eric Windmill"
category: "Dart"
subSection: "Iterables, Iterators, and Collections"
tags:
    - dart
    - where
    - takeWhile
    - skipWhile
    - list
    - iterables
---

Filtering elements from a list, for our purposes, means making a new list out of only some of the elements from an original list. There are many different methods that achieve this for different cases. But, one of the most useful methods on lists is  `where`. In addition to `where`, I will discuss `takeWhile` and `skipWhile`.

`where` is used to filter elements from a list which pass a "test" passed in in the form of a callback. 

```run-dartpad:theme-light:run-false:split-60
void main() {
  final words = ["hot", "dog", "phone", "coffee", "pig"];
  final threeLetterWords = words.where((String word) => word.length == 3);
  print(threeLetterWords);      
}
```

Important notes: 

- where returns a _new_ `Iterable` instance, and does not mutate the original list.
- if no elements pass the "test", an empty iterable is returned. It will not throw an error.
- Some other filtering, where-like methods -- like `singleWhere` and `firstWhere`, _will_ throw an error if no element in the list satisfies the test.

### takeWhile and skipWhile

These methods also return new `Iterables`, but they return entire sections of the original list, depending on which element in the list satisfies the test. In human words:

- `takeWhile(testCallback)`
    - this will return every element in a list from index 0 to the element that first satisfies the test.
- `skipWhile(testCallback)`
    - this will return every element in a list starting with the first element that passes the test to the final element in the list.
    
```run-dartpad:theme-light:run-false:split-60
void main() {
  final numsFrom0To5 = [0, 1, 2, 3, 4, 5];
  final numsTo2 = numsFrom0To5.takeWhile((int n) => n <= 2);
  print(numsTo2);
  final numsFrom3To5 = numsFrom0To5.skipWhile((int n) => n <= 2);
  print(nums);
}
```

<div class="aside">
    As you may have guessed, `takeWhile` and `skipWhile` are extremely useful for _sorted_ lists, but for much else.
</div> 

### Try filtering a list

<!--
    gist
-->


 