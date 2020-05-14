---
title: "The most basic example using Provider"
author: "Eric Windmill"
category: "Flutter State and Logic Example Apps"
subSection: "Provider"
tags:
    - flutter
    - state management
    - dependency injection
    - provider
---

In order to showcase the real, core value proposition of provider, I will show you the simplest example Flutter app I can build. To be sure, we will see some complex and "real world" examples through-out this section, but at it's core, Provider just tells Flutter apps how to interact with non-widget data classes. 

First, I want to show the example, and then I will walk through the code showing and explain what's going on.

<!-- iframe -->

That's it. It's just an app that displays some text on the screen. Now, let's walk through the code.

```dart 
// This class is what Provider will work with.
// It will _provide_ an instance of the class to any widget
// in the tree that cares about it. 
class Person {
  Person({this.name, this.age});

  final String name;
  final int age;
}

// Here, we are running an app as you'd expect with any Flutter app
// But, we're also wrapping `MyApp` in a widget called 'Provider'
// Importantly, `Provider` is itself a widget, so it can live in the widget tree.
// This class uses a property called `create` to make an instance of `Person`
// whenever it's needed by a widget in the tree.
// The object returned by the function passed to `create` is what the rest of our app
// has access to. 
void main() {
  runApp(
    Provider(
      create: (_) => Person(name: "Yohan", age: 25),
      child: MyApp(),
    ),
  );
}


// Just a plain ol' StatelessWidget
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage(),
    );
  }
}

// Again, just a stateless widget
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
          // this string is where we use Provider to fetch the instance
          // of `Person` created above in the `create` property
          '''
          Hi ${Provider.of<Person>(context).name}!
          You are ${Provider.of<Person>(context).age} years old''',
        ),
      ),
    );
  }
}
```

For the most basic example, that's all you need. Provider simply exposes an instance of an object, which all of your widgets can gain access too using 'Provider.of<T>(context)'. 

If you're familiar with `InheritedWidget` objects, then this should look familiar. And that's because Provider is, in a nutshell, a widget that behaves exactly like the `InheritedWidget`, but with far less boiler plate.

If you take anything from this lesson, I hope that it's this: Provider just... err... _provides_ classes to your widget tree that aren't widgets.

This example shows the most basic example, in which you can only read data. You can't update data. And even if you could, it wouldn't cause the widget tree to re-render, because there's nothing telling Flutter that the data has changed. Luckily, Provider includes a whole swath of classes that can help you with this.

