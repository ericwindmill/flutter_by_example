---
title: "What are collections (and iterables)?"
author: "Eric Windmill"
category: "Dart"
subSection: "Iterables, Iterators, and Collections"
tags:
   - iterables
   - collections
---

<div class='disclaimer'>
This section is heavily inspired by Dart's own <a href="https://dart.dev/codelabs/iterables">codelab</a> on the subject, it's less detailed (for beginners), but includes more methods and examples (for those looking for specific information, like <a href="https://api.dart.dev/stable/2.8.1/dart-core/Iterable/fold.html">Iterable.fold</a>).
</div>

Collections are Dart objects that contain more objects, referred to as _elements_. For example a `Map` or `List`. An _iterable_ collection is a collection that implements the Dart class `Iterable`. The most common iterables are `List` and `Set`. 

<div class='aside'>
A `Map` object is a collection, but not an iterable. Maps are covered in the latter part of this section, as it's often useful to _iterate_ over map properties as well. 
</div>

In a nutshell, an _iterable_ is a collection that _sequential_ access to its elements. In plain English, an iterable stores its elements in order, and you can find the elements within the collection by its position.

In code, that looks something like this:

```dart
Iterable<String> greeting = ['Hello', 'World'];
``` 

### Bracket Notation

Using the _bracket notation_ is the just the basic way to interact with iterables.
 
```run-dartpad:theme-light:run-false:split-60
Iterable<String> greeting = ['Hello', 'World']; 
void main() {
    var hello = greeting[0];
    var world = greeting[1];

    print(hello);
    print(world);
}
```

Like in most languages, Dart's iterables are 0-indexed, and you can access te different elements by their index. 

Along with indexing, there are a variety of methods and properties on iterables that are handy, and we'll explore throughout this section.

<div class='aside'>
For most of the remainder of the section, I'll be using `List`, as its the most common iterable, but most of the knowledge could be applied to all iterables, including `Set`. 
</div>





