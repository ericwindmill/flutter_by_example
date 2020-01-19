---
title: "Extension methods"
author: "Eric Windmill"
category: "Dart"
subSection: "Object-Oriented Programming"
tags:
    - object oriented programming
    - inheritance
    - extensions
    - class
---

Extension methods are new as of Dart 2.7. They allow you to add functionality to existing libraries and classes. For example, you can add extra functionality to the Dart core `String` library, that are only available in your app. 

```run-dartpad:theme-light:run-false:split-60
extension on DateTime {
  String get humanize {
    // you have access to the instance in extension methods via 'this' keyword. 
    return "${this.day}/${this.month}/${this.year}";
  }
}

void main() {
  final dateTime = DateTime.now();
  print(dateTime.humanize);
}
```  