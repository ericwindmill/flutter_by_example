---
title: "Singletons"
author: "Eric Windmill"
category: "Dart"
subSection: "Object-Oriented Programming"
tags:
    - object oriented programming
    - class
    - singleton
---

The _singleton pattern_ is a pattern used in object-oriented programming which ensures that a class has only one instance and also provides a global point of access to it. Sometimes it's important for a class to have exactly one instance, or you might force your app into a weird state. For example, you only want one instance of a class that represents your local storage, or you may end up with two different sources of data, which are out of sync. For the same reason, an operating system should have exactly one file system.

The idea is that anywhere in your code that you call `MyClass()`, it will return the same instance of that class, with the same state, etc. Thanks to `factory` constructors, implementing the singleton pattern in Dart is not only possible, but simple and flexible. 

```dart
class FileSystemManager {
  static final FileSystemManager _instance = FileSystemManager._internal();
 
  // using a factory is important
  // because it promises to return _an_ object of this type
  // but it doesn't promise to make a new one.
  factory FileSystemManager() {
    return _instance();
  }
  
  // This named constructor is the "real" constructor
  // It'll be called exactly once, by the static property assignment above
  // it's also private, so it can only be called in this class
  FileSystemManager._internal() {
    // initialization logic 
  }
  
  // rest of class as normal, for example:
  void openFile() {}
  void writeFile() {}
}
``` 

Consuming that class will make it more clear:

```run-dartpad:theme-light:run-false:split-60
void main() {
  // This constructor calls the factory constructor,
  // which turns around and returns the static instance
  // which was initialized with the `_internal` named constructor

  // this will be true if the two instances have the same hashcode
  // (hint: they do)
  print(FileSystemManager().hashCode == FileSystemManager().hashCode);
} 

class FileSystemManager {
  static final FileSystemManager _instance = FileSystemManager._internal();

  factory FileSystemManager() {
    return _instance;
  }
  
  FileSystemManager._internal() {
    // initialization logic 
  }
  
  void openFile() {}
  void writeFile() {}
}
```