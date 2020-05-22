---
title: "Using .value constructors"
author: "Eric Windmill"
category: "Flutter State and Logic Example Apps"
subSection: "Provider"
tags:
    - flutter
    - state management
    - dependency injection
    - provider
    - value
---

If you've used Provider at all in the past, then you may have noticed that all types of `Provider` classes have two constructors: the default constructor, and a `.value` named constructor.

These constructors, which I'll call _value constructors_, have specific use-cases. In the examples you've seen so far the `.value` constructors wouldn't be what you want. 

In general, you want to use value constructors when you already have an instance of a class you'd like to provide. Say you're providing a `Person` instance that has already been created for some other reason. If you pass that variable into a provider, it's possible that the provider will dispose of that object while other pieces of code are still using it. 

For example:

```dart
Person person = Person();

ChangeNotifierProvider<Person>(
  create: (_) => person; // bad!
)
``` 

If that person variable is used anywhere else, it may cause errors when this widget is removed from the tree. The reverse of this set-up is also a problem. Consider this example:

```dart
// this is bad! 
// everytime this widget is rebuilt, it will create a new instance of `Person`
// and every new instance of Person will trigger a rebuild in _every_ widget reading this value.
ChangeNotifierProvider.value(
  value: Person(), 
  child: ...
)
```


So again, value constructors are best used when you need to provide a specific value that is already created. Some use-case examples: 
 
- Perhaps you need to provide an instance of an object that already exists where it otherwise isn't available. 
- Maybe you have a reason to hide a provided class from certain widgets, but you want to expose a piece of the class. Suppose you have a `Person` object provided to a big chunk of your widget tree, and you further on down the tree you want to expose the persons name (as a String), but none of their other properties.

Regardless of your reasoning, this is what using a value constructor looks like:

```dart
class PersonsNameLabel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider<String>.value(
      value: Provider.of<Person>(context).name,
      builder: (BuildContext context, Widget child) {
        return Text(context.watch<String>());
      },
    );
  }
}
```

<div class="aside">
There are a couple other examples in the <a href="https://pub.dev/packages/provider">documentation</a> that use value constructors, but they're extremely specific and outside the scope of this tutorial.
</div>


### Live example of a .value constructor

<iframe style="height:800px" src="https://dartpad.dev/embed-flutter.html?theme=dark&run=true&split=60&id=db1df1bdb09a60f81308e589f60810d4"></iframe>