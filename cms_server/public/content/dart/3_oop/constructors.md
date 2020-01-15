---
title: "Constructors"
author: "Eric Windmill"
category: "Dart"
subSection: "Object-Oriented Programming"
tags:
    - dart
    - object oriented programming
    - class
    - member
---

Constructors are used to create objects with pre-determined values for the properties. Constructors come in three flavors: the standard constructors, named constructors, and factory constructors. 


```run-dartpad:theme-light:run-false:split-60
class Cat {
    String name;
    String color;
    
    // a simple constructor
    Cat(this.name, this.color);

    // named constructors are used to define additional constructors
    // they return a new instance of the class, usually with some 
    // values given defined values.
    Cat.orange(this.name) {
        color = 'Orange';
    }
    
    // this is another named constructor example
    Cat.black(this.name) {
        color = 'Black';
    }

    // factory constructors
    factory Cat.fromJson(Map json) {
        return Cat(json['name'], json['color']);
    } 

  
    @override
    String toString() => "Cat: ${this.name}, ${this.color}";
}

void main() {
    print(Cat('nora', 'orange'));
    print(Cat.orange('nora'));
    print(Cat.black('nora'));
    print(Cat.fromJson({'name': 'Nora', 'color':'Orange'}));
}
 ```