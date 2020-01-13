---
title: "Classes"
author: "Eric Windmill"
category: "Dart"
subSection: "Object-Oriented Programming"
tags:
    - dart
    - object oriented programming
    - class
    - member
---

Nearly all the code you write in Dart will be contained in classes. And a class is a blueprint for an `object`. That is, a class describes an object that you can create. The object itself is what holds any specific data and logic. For example, a `Cat` class might look like this:

```dart
class Cat {
    String name;
    String color;
}
```

The variable declarations above, `String name` and `String color`, are called _properties_ or _class members_. (NB: _Members_ can also refer to functions, getters and setters on classes.)

### Instances of classes

This class describes an object that can be created, like this:

```dart
Cat nora = new Cat(); // note: the `new` keyword is optional in Dart 2
nora.name = 'Nora';
nora.color = 'Orange';
```


<div class="aside">
A note about the (lack of) the new keyword:
`
If you're coming from many other object-oriented languages, you've probably seen  the `new` keyword used to create new instances of a class. In Dart, this `new` keyword works the same way, but _it isn't necessary_. In Dart 2, you don't need to use `new` or `const` to create an object. The compiler will infer that for you.
</div>


```run-dartpad:theme-light:run-false:split-60
class Cat {
    String name;
    String color;
}

void main() {
    var nora = Cat();
    nora.name = 'Nora';
    nora.color = 'Orange';

    print(nora);
    print(nora.name);
    print(nora.color);
}
```



