---
title: "Adding elements: add and insert (all)"
author: "Eric Windmill"
category: "Dart"
subSection: "Iterables, Iterators, and Collections"
tags:
    - dart
    - add
    - addAll
    - insert
    - insertAll
    - iterables
---

Adding elements to _lists_ is done with four elements. Importantly, this doesn't apply to the `Iterable` super class. These methods exist across different collections, such as `List` and `Set`, but not all methods exist on all collections.

1. `add(element)` (list, set)
    - adds one element, passed in as an argument, to the _end_ of a list.
2. `addAll([element1, element2, etc])` (list, set, map)
    - adds all the elements of one list to the end of the target list, maintaining ordering
3. `insert(index, element)` (list)
    - adds one element to the list at the given index, and then moves every element over 1 to make room
4. `insertAll(index, [element1, element2, etc])` (list)
    - adds all elements passed in as a list to the target list beginning at the index provided, and shifting the rest of the elements over.

These methods exist only on certain collections for good reason, which I'll discuss after we look at some examples of using these methods with a list.

```run-dartpad:theme-light:run-false:split-60
List<String> cities = ['Portland', 'Medellin', 'Tokyo'];
void main() {
    print(cities);
    cities.add('Budapest');
    print(cities);
    cities.addAll(['Louisville', 'Bangkok']);
    print(cities);
    cities.insert(1, 'Chaing Mai');
    print(cities[1]);
    cities.insertAll(0, ['Paris', 'Baghdad', 'New York']);
    print(cities);
}
```

To determine if (or why) certain methods live on certain collections and not others, consider how these objects work. A `Map` has no use for a method like `insert` or `insertAll`, because it doesn't maintain or care about order. Similarly, not all `Set` implementations care about order. 

These methods of course have an infinite number of use-cases. But one that's easy to show is using a list to represent a queue. A queue is an abstract data type that has one main rule: first-in-first-out. In human words, that means that the only element that can be removed from a queue is the element that was inserted first. Queue's can be nicely visualized like this:

<img src="https://res.cloudinary.com/duqbhmg9i/image/upload/c_scale,h_525/v1589125921/flutter_by_example/queue_drawing_dcd5oq.png" alt="queue drawing">

Because of this, a queue needs to be able to insert elements at one end, and remove from the other end. This sort of fine control over the order of a list makes `insert` quite useful. 

#### Try it yourself, make a queue

<iframe style="height:400px;" src="https://dartpad.dev/embed-inline.html?id=befbabc698e2ddff75a063efebe68e23&split=60&theme=dark"></iframe>
