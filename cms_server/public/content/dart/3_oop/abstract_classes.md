---
title: "Abstract classes (and interfaces)"
author: "Eric Windmill"
category: "Dart"
subSection: "Object-Oriented Programming"
tags:
    - object oriented programming
    - abstract class
    - interface
---

An _abstract class_, which is similar to an _interface_, defines a class that cannot be instantiated. 

Abstract classes keep your code honest and type safe. It ensures that all _implementation subclasses_ define all the properties and methods that abstract class defines, but leaves the implementation to each subclass. 

```run-dartpad:theme-light:run-false:split-60
abstract class Animal {
  int age;
  String name;

  // no method body means you're defining an abstract method
  // abstract methods must be overridden in implementation classes
  void talk();

  // abstract classes _can_ implement some functionality. 
  // when the method functionality is written on the abstract class,
  // the implementation subclasses don't have to override it.
  void growl() => print('grrrrr');
}

class Cat implements Animal {
  @override
  int age;

  @override
  String name;

  Cat(this.name, this.age);

  @override
  void talk() {
    print('meow');
  }
}

class Dog implements Animal {
  @override
  int age;

  @override
  String name;

  Dog(String name, int age);

  @override
  void talk() {
    print('bark');
  }
}

// This method expects an Animal instance as an argument
// But, Animal is _abstract_, which means you cannot instantiate it directly
// So, any class that _implements_ Animal is guaranteed to have
// overriden the methods and properties on the Animal interface, 
// which makes it 'type safe'.
void makeAnimalNoise(Animal animal) => animal.talk();

main() {
  final cat = Cat('Nora', 5);
  final dog = Dog('Pepperstake', 1);
  makeAnimalNoise(cat);
  makeAnimalNoise(dog);

  dog.growl();
  cat.growl();
}
```
