---
title: "Reading elements pt 1: first, last"
author: "Eric Windmill"
category: "Dart"
subSection: "Iterables, Iterators, and Collections"
tags:
    - dart
    - first
    - last
    - iterables
---

Among the many methods included on the iterable class are some getters that provide quick, basic information.

For reading values directly, outside of loops, there are three basic methods.

1. Bracket notation
2. `Iterable.first`
3. `Iterable.last`

Bracket notation is similar to every language, and first and last do just what they describe: return the first element of a list and the last element of a list, respectively.

These are useful in many cases, but mainly just make code more readable.  

```run-dartpad:theme-light:run-false:split-60
List<String> favoriteCats = ['Nora', 'Phoebe', 'Wallace'];
void main() {
    print(favoriteCats.first);
    print(favoriteCats[1]);
    print(favoriteCats.last);
}
```

Importantly, none of these methods change the list. They don't remove and return the first or last element. Rather, they're more akin to "peek" in other languages.
