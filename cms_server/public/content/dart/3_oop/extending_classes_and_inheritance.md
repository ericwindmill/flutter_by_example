---
title: "Extending classes (inheritance)"
author: "Eric Windmill"
category: "Dart"
subSection: "Object-Oriented Programming"
tags:
    - object oriented programming
    - inheritance
    - extends
    - class
---

You can _inherit from_ or _extend_ a class using the `extends` keyword. This allows you share properties and methods between classes that are similar, but not exactly the same. Also, it allows different _subtypes_ to share a common runtime type so that static analysis doesn't fail. (More on this below);

The classic example is using different types of animals.

```run-dartpad:theme-light:run-false:split-60
class Animal {
  Animal(this.name, this.age);
  
  int age;
  String name;

  void talk() {
    print('grrrr');
  }
}

class Cat extends Animal {
  // use the 'super' keyword to interact with 
  // the super class of Cat
  Cat(String name, int age) : super(name, age);
  
  void talk() {
    print('meow');
  }
  
}


class Dog extends Animal {
  // use the 'super' keyword to interact with 
  // the super class of Cat
  Dog(String name, int age) : super(name, age);
  
  void talk() {
    print('bark');
  }
  
}

void main() {
  var cat = Cat("Phoebe",1);
  var dog = Dog("Cowboy", 2);
  
  dog.talk();
  cat.talk();
}
```

Here, the Dog and Cat classes share the common properties of Animal, reducing the need to duplicate code in each class. But, it wouldn't make much sense if they both said "meow" when you called `talk`. So, talk is defined separately on the different classes, and is implemented correctly on each animal.

### Some 'gotchas' with inheritance

As you'll see, inheritance is not without it's problems. What if you decided to change that 'talk' method to 'makeNoise'?
 
You now have to update the code for both the Cat and Dog API. If you didn't, then anywhere you call `Animal.talk` may fail. For instance, if you have code that doesn't care what _subtype_ of animal it gets, it just knows it needs to make that animal talk. 

That's an example of the statement I made earlier about subtypes sharing super types. An object of type `Cat` _also_ is of type `Animal`. Therefor, Cat instances can be passed into functions that require `Animal` instances.

```dart
recordAnimalNoise(Animal animal) {
  _recordNoise(animal.talk());
}

main() {
  recordAnimalNoise(Cat('Wallace', 1)); // OK!
  recordAnimalNoise(Dog('Lizard', 3)); // OK!
}
```

This problem can be solved using other features of Dart's classes, which are discussed in the next few examples.