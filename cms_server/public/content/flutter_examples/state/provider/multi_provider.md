---
title: "MultiProvider micro lesson"
author: "Eric Windmill"
category: "Flutter State and Logic Example Apps"
subSection: "Provider"
tags:
    - flutter
    - state management
    - provider
    - multi provider
---

In the `FutureProvider` lesson, you may have noticed something ugly.

```dart
void main() {
  runApp(
    Provider<Person>(
      create: (_) => Person(name: 'Yohan', age: 25),
      child: FutureProvider<String>(
        create: (context) => Home().fetchAddress,
        initialData: "fetching address...", 
        child: MyApp(),
      ),
    ),
  );
}
```

There are two providers, one nested inside the over. You can imagine this getting quickly out of hand:

```dart
void main() {
  runApp(
    // You can wrap multiple providers 
    Provider<Person>(
      create: (_) => Person(name: 'Yohan', age: 25),
      child: FutureProvider<String>(
        create: (context) => Home().fetchAddress,
        initialData: "fetching address...", 
        child: StreamProvider<Connectivity>(
          create: (context) => Session.connectivity(),
          child: ChangeNotifierProvider<AuthState>(
            create: (context) => Session.authState(),
            child: MyApp(),
         ),
        ),
      ),
    ),
  );
}
```

This isn't super readable. Provider includes a fix for this: [MultiProvider](https://pub.dev/documentation/provider/latest/provider/MultiProvider-class.html).

`MultiProvider` let's you pass in a list of providers without nesting anything,

```dart
void main() {
  runApp(
    // You can wrap multiple providers 
    MultiProvider(
      providers: [
        Provicer<Person>(create: (_) => Person(name: 'Yohan', age: 25)),
        FutureProvider<String>(create: (context) => Home().fetchAddress),
      ],
      child: MyApp(),
    ),
  );
}
```

This widget just makes code more terse and readable. Which is always nice.

<div class="aside">
If you really want to be impressed by the creator of Provider, <a href="https://github.com/rrousselGit">Remi</a>, check out his package called <a href="https://pub.dev/packages/nested">nested</a>, which provides widgets that can take a list of children and nest them. This is what `MultiProvider` is built on top of.  
</div>