---
title: "Future Provider"
author: "Eric Windmill"
category: "Flutter State and Logic Example Apps"
subSection: "Provider"
tags:
    - flutter
    - state management
    - provider
    - consumer
    - future provider
---

Future provider is exactly what it sounds like. It provides a `Future` value to it's descendents in the tree. If you've been following along with this tutorial so far, then you may be able to deduce how this provide works on it's own. With that in mind, we'll move quickly to a code example, and see how it's used.

In a nutshell, `FutureProvider` is used to provide a value that might not be ready by the time the widget tree is ready to use it's values. Therefor, the main usecase of `FutureProvider` is to ensure that a null value isn't passed to any widgets. Future provider has a initial value, which widgets can use until the `Future` value is resolved. When resolved, it the `FutureProvider` will tell it's descendents to rebuild, using the new value. 

Importantly, this means that the widgets who rely on the value of a future provider will only rebuild once. It will display the initial value, and then the provided future value, and then won't rebuild again. 

<div class="aside">
    Future provider can be configured to change again if there is, for some reason, another new value from the future. But, if you anticipate multiple values from the provider, you should likely be using a `StreamProvider`.
</div>  

In this example, I'm going to add onto the previous examples by adding a new class called 'Home'. 

```dart
class Person {
  Person({this.name, this.age});

  final String name;
  int age;
}

// Classes that will be used with FutureProvider don't need to 
// mixin ChangeNotifier or anything else
class Home {
  final String city = "Portland";

  // The value that will be provided must be a `Future`.
  Future<String> get fetchAddress {
    // NB: using `Future.delayed` is mocking an HTTP request.
    // imagine that this is something like http.get("http://my_api.com/address");
    final address = Future.delayed(Duration(seconds: 2), () {
      return '1234 North Commercial Ave.';
    });
    
    return address;
  }
}
```

And, to provide those classes, we'll just build on previous examples by using a second provider.

```dart
void main() {
  runApp(
    // You can wrap multiple providers 
    Provider<Person>(
      create: (_) => Person(name: 'Yohan', age: 25),
      // The future provider provides a String value, 
      // rather than the entire claass of Home
      child: FutureProvider<String>(
        create: (context) => Home().fetchAddress,
        // this will be displayed in the meantime
        // until a new value is provided from the future
        initialData: "fetching address...", 
        child: MyApp(),
      ),
    ),
  );
}
```

With all that set up, look at this example of using the provided values.

<!-- iframe -->


