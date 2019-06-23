---
title: "About Dart"
author: "Eric"
category: "Dart"
subSection: "About Dart"
order: 1
tags:
    - dart
---

<div class='aside'>

## Sections

* [About Dart](#about-dart)
* [The 'Main' function](#the-main-function) - The entry point.
* [Printing to the Console](#printing-to-the-console)
* [Dart Type System](#dart-type-system) - Variables, return values, data structures.
* [Default Values](#default-values) - Null, true, false, etc
* [Asynchronous Programming](#asynchronous-dart) - Fututres, async/await.
* [Streams](#streams)

</div>

### About Dart

> Dart is an application programming language that’s easy to learn, easy to scale, and deployable everywhere. Google depends on Dart to make very large apps.
> -dartlang.org

The first hurdle to most would-be Flutter developers is being convinced to
learn a new, sparsely used Language: Dart.

If you're coming from a C-like syntax language like Java, it'll be very easy
to learn. If you're coming from JavaScrtipt, there are some important differences.

I imagine a lot of Flutter developers are going to be coming from the world of
JavaScript, so I'll point out the major differences between JS and Dart here.

> 'Dart is an object-oriented, class defined, single inheritance language using a C-style syntax that transcompiles optionally into JavaScript. It supports interfaces, mixins, abstract classes, reified generics, optional typing, and a sound type system'.
> -Wikipedia

Syntactically, you're in good shape if you've ever used TypeScript or Java. In fact, for JS web developers, the biggest road block to overcome is going be using a typed language. You'll also potentially have to get used to Object Oriented Programming, as JavaScript uses a prototypical hierarchy that's fairly unique.

### The 'main' function

When Dart is ready to run, it looks for a main function to execute. Every Dart program must start with the main function.

```dart
void main() {
  // ... execute program
}
```

### Printing to the console

To log anything to the console, use the built in function 'print':

```dart
void main() {
  print('Logging to the console: ... ');
}
// -> Logging to the console: ...
```

### Dart Type System

This is the biggest difference.

JavaScript doesn't support any kind of types. Dart (as of Dart 2), is a strongly typed language, and Types are _not_ optional.

```javascript
// JavaScript
var one = 1
var name = 'Rick'
```

```dart
// Dart
int one = 1;
String name = 'Rick';
```

A strong type system makes you more productive. The tooling is better, and your compiler catches many more errors much easier.

Dart does support a `var` keyword, which means it can be anything.

```dart
//Dart
// Okay
var name = 'Rick';
```

When writing functions in Dart, you start by declaring the type that it will
return:

```dart
// Dart
// void means it returns nothing
void main () {
  print('hello world');
}

// this function returns an int
// and the argument it accepts is an int
int multiplyByTwo (int number) {
  return number * 2;
}
```

When writing data-structures like Lists and Maps, you can add types with the
following syntax:

```dart
List<String> names = ['Aaron', 'Ahmed', 'Alex'];
Map<String, String> userInfo = {'firstName': 'Kevin', 'lastName': 'Durant'};
```

### Default Values

(I'm sorry about the soapbox...)

The most insane thing about JavaScript is that literally anything goes. Not enough arguments passed to a function? It's fine. Too many arguments? Just ignore the extras. Passing a string into a function that adds numbers? Okay. Everything without a value is `undefined`, and the compiler is fine to try to push forward anyway.

Dart is not this way. In Dart, everything that doesn't have a value is `null`, and if you try to execute code that involves a `null` value, it'll complain.

```javascript
var name // undefined
```

```dart
// Dart
var name; // null
List x; // null
MyCustomClass variable; // null
```

In JS, many values are treated as `true`. Most values, actually. Which is very
confusing. Also in JS, many values are treated as `false`. The point is, you
can use many values to 'null check'

```javascript
// JavaScript
var nullVar = null
if (nullVar) {
  // do something
}
```

In Dart, `true` is true. False is false. Fullstop. You can't use _anything_
other than values that evaluate to booleans in if/else statements:

```dart
// Dart
var nullVar;
if (nullVar) {
  // throws error, value must evaluate to boolean
};

if (nullVar == null) {
  // works
};
```

### Asynchronous Dart

Async programming in Dart has two main aspects: Futures and Streams.

Futures are the same as JS's `Promises`. A future represents a value that will
eventually evaluate.

```dart
//Dart
// Return a Future, which will return a null eventually
Future<Null> getApiData() {
  final url = 'https://httpbin.org/ip';
    HttpRequest.request(url).then((value) {
        print(json.decode(value.responseText)['origin']);
    }).catchError((error) => print(error));
}
```

But you can make your life even easier by using `async/await`, which is exactly
lke async/await in other languages, including the new feature in JavaScript.

```dart
// Dart
Future<Null> _getIPAddress() async {
  final url = 'https://httpbin.org/ip';
  var request = await HttpRequest.request(url);
  String ip = json.decode(request.responseText)['origin'];
  print(ip);
}
```

### Streams

Basically, a stream is an object with tells you when there is new data
available. For example, you could establish a stream that listens for new
messages from a database in a chat app.

<div class="aside">

**NB:** There is _a lot_ more to it, but you only need to know enough to get
started.

</div>

```dart
List<String> messagesToRender = [];

// A Stream Controller will alert all streams when new information is available.
StreamController<List<String>> messagesStream = new StreamController.broadcast();

// A stream itself is what you will listen to.
Stream<List> get onNewMessage => messageStream.stream;

// A listener is what logic you want to execute when a stream updates.
void _subscribeToMessages() {
  onNewMessage.listen((data) {
    messagesToRender = data;
  });
}
```

<div class='tip'>

For a full intro into the language, checkout [Dart for Web Developers](https://dartforwebdevelopers.com/)

</div>

