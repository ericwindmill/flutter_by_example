---
title: "Using context extensions for more control"
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

As of version 4.1.0 of `Provider`, there are some very tasty updates to reduce the boiler plate needed to use `Selector` and `Consumer`. This is amazing, because Provider was already reducing a ton of InheritedWidget boiler plate.

Recently, Dart added `extension` methods to the language, which allows you to add properties and methods to classes from _other packages_. Which rules. Quickly, my favorite example of extension methods:

```dart
// extensions can be added to all classes, including enums
enum Connectivity {
  connected, disconnected, searching
}

extension on Connectivity {
  String humanize() => this.toString().split(".").last;
}

void main() {
  print(Connectivity.connected.humanize());
}
```   

That's a pretty basic example, but you can extend anything. You can add a doubler method to ints:

```dart
extension on int {
  int double() => this * 2;
}
```

And so on.

### extending BuildContext 

Provider includes extension methods on Flutter's built in `BuildContext`. If you aren't familiar, build context is an object that holds reference to the widgets own place in the tree. It can then look up the tree to its ancestors, which is what makes Inherited Widgets possible, among many other things. 

This why in Provider, you will see this line of code: `Provider.of<String>(context);`. This "of" method is using Flutter to look up the tree and find a `Provider` widget with the sub-type of `String`. (This isn't unique to provider, you will see it in many libraries, as well in Flutter functionality itself.) 

Anyways, now that extensions are available, we can short-cut the process used to make `of` methods, and just add methods directly to build context. Which brings us to the better way to consumer providers:

- `BuildContext.read`
- `BuildContext.select`
- `BuildContext.watch`

Each of these simplifies a different process that previously a bit more verbose:

`BuildContext.read<Person>()` replaces `Provider.of<Person>(context, listen: false)`.  In this case, it will find the `Person` object and then return it.

`BuildContext.watch<Person>()` replaces `Provider.of<Person>(context)`. While this may seem hardly different, consider that you not do not need to use a Consumer at all. You can remove entire widgets from the tree! `watch` is used to 'listen' to a value from a  `ChangeNotifierProvider`, `FutureProvider` or `StreamProvider`.

Finally, `BuildContext.select<Person>` is probably the most useful. It completely removes the need to use a `Selector`, as you can just use the value you would be selecting directly. I considered `Selector` the most cumbersome widget in the package to use, and to grok. But, it's all changed.

TIRED: Using selector
```dart
Widget build(BuildContext context) {
  return Selector<Person, String>(
    selector: (context, p) => p.name,
    builder: (context, name, child) {
      return Text(name);
    },
  ),
}
``` 

WIRED: Using context.select: 
```dart
Widget build(BuildContext context) {
  final name = context.select((Person p) => p.name);
  return Text(name);
}
```

And, you still get the same benefits of the `Selector` widget. It will only rebuild the `Text` widget if the persons name is changed, and won't rebuild if any other property on the person object changes. Noice.


### Live example:

<!-- iFrame -->

NB: If you remember from an earlier lesson, `Provider` considers it an error to fetch an object or value that will never change, which we solved by using `listen: false`. Because `read` is a shortcut to this same functionality, `read` is valuable to do things like handle clicks (but not much else). It is considered an error to use `read` to get a value that a widget needs to paint.