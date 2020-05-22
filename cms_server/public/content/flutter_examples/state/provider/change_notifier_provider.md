---
title: "ChangeNotifierProvider"
author: "Eric Windmill"
category: "Flutter State and Logic Example Apps"
subSection: "Provider"
tags:
    - flutter
    - state management
    - provider
    - ChangeNotifierProvider
---

Most of the examples you'll see on the internets is using the [ChangeNotifierProvider](https://pub.dev/documentation/provider/latest/provider/ChangeNotifierProvider-class.html), and it's also the class you'll likely use most often. This class is basically a provider-wrapper over a class that implements `ChangeNotifier`.

According to the [Flutter docs](https://api.flutter.dev/flutter/foundation/ChangeNotifier-class.html), a `ChangeNotifier` is 'a class that can be extended or mixed in that provides a change notification API using VoidCallback for notifications.' In practical terms, other objects can _listen_ to a `ChangeNotifier` object. And, when the change notifier gets updated values, it can call a method called 'notifyListeners()', and then any of it's listeners will respond with an action. Listening to a change notifier is done by registering a callback, which is called when `notifyListeners` is invoked.

That description felt a bit esoteric, so let's just look at a quick `ChangeNotifier` example _without Provider_.

```dart
class Person with ChangeNotifier {
  Person({this.name, this.age});

  final String name;
  int age;

  // when `notifyListeners` is called, it will invoke
  // any callbacks that have been registered with an instance of this object
  // `addListener`.            
  void increaseAge() {
    this.age++;
    notifyListeners();
  }
}

void main() {
  var person = Person('Yohan', 25);
  
  // `addListener` is a method on the `ChangeNotifier` class,
  // which is mixed-in to the Person class    
  person.addListener(() {
    print('value updated!: ${person.age}')
  });      

  person.increaseAge();  // 26
}
```

In this example, we've started listening to the `Person with ChangeNotifier` class by calling `addListener`, which accepts a `VoidCallback` function as it's argument. When the age is increased, it will execute that callback. 

<div class="aside">
    ChangeNotifier is built into the Flutter SDK, and it's "purpose" is to call `notifyListeners` whenever data changes that should in turn update your UI. In the example above, I am not using it in widgets, but it's important to note that this class is not available in other Dart environments.
</div>

This is one way to encapsulate the state of your app inside of classes, but it presents a problem... if you wanted to use it in multiple widgets in different branches in your widget tree, it would quickly make your code super hairy and difficult to refactor. You'd basically be passing an instance of your `ChangeNotifier` all around the widget tree manually.

But, that is the _exact_ problem that `provider` solves.

### ChangeNotifierProvider

This example is not going to be much different than the previous Provider lesson. The `ChangeNotifierProvider` is used exactly like the vanilla Provider. Let's start with the code, and they'll I'll highlight some important points.

First, add the provider to the tree:

```dart
class Person with ChangeNotifier {
  Person({this.name, this.age});

  final String name;
  int age;

  void increaseAge() {
    this.age++;
    notifyListeners();
  }
}

// here, you can see that the [ChangeNotifierProvider]
// is "wired up" exactly like the vanilla [Provider]
void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => Person(name: "Yohan", age: 25),
      child: MyApp(),
    ),
  );
}
```

As you can see, wiring up a ChangeNotifierProvider is exactly the same as the Provider example from the previous lesson. Using it in widget tree is going to be similar:

<div class="aside">
The example I'm about to show you is the _most basic_ example, and probably not exactly how you'd consume the data from provider in your real app. That will be covered in the next lesson, so don't @ me.
</div>

```dart
class MyHomePage extends StatelessWidget {
  const MyHomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Provider Class'),
      ),
      body: Center(
        child: Text( 
          // reading this data is exactly like it was in
          // the previous lesson             
          '''
          Hi ${Provider.of<Person>(context).name;}!
          You are ${Provider.of<Person>(context).age} years old''',
        ),
      ),  
      floatingActionButton: FloatingActionButton(
        // this is where there's a difference.
        // when the FAB is tapped, it will call `Person.icreaseAge()` on the
        // person instance that was created by provider.     
        onPressed: () => Provider.of<Person>(context, listen: false).increaseAge(),
      ),
    );
  }
}
```

Two important notes about that code:

- Because this is a `ChangeNotifier`, the UI will re-build and the age will be increased. (Success!)
- You may have noticed `listen: false` in the `of` method. The `listen: false` parameter is _mandatory_ whenever you're using Provider to fetch an instance and call a method on that instance. This has a practical application, though. Because you aren't listening, the widget doesn't need to re-render just because a change was made. In this example, there would be no reason to re-render the FloatingActionButton, even when the ChangeNotifier did notify it's listeners.

Finally, just so you believe me, let's look at this running in a Flutter app:

<iframe style="height:800px" src="https://dartpad.dev/embed-flutter.html?theme=dark&run=true&split=60&id=54820e0eab2670dc24bd7354a0766bc8"></iframe>