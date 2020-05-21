---
title: "Stream Provider"
author: "Eric Windmill"
category: "Flutter State and Logic Example Apps"
subSection: "Provider"
tags:
    - flutter
    - state management
    - provider
    - consumer
    - Stream provider
---

[`StreamProvider`](https://pub.dev/documentation/provider/latest/provider/StreamProvider-class.html) provides, well, Streamed values. Like FutureProvider, provided values will be auto-magically passed the new values of the provided value as they come in. The major difference is that the values will trigger a re-build as many times as it needs to. 

<div class="aside">
    If you need a refresher on Streams, I recommend you  <a href="https://ericwindmill.com/articles/async_dart_flutter/">check out my code-cartoon of Dart Streams</a>, or find a whole chapter about Streams in my book <a href="bit.ly/flutterinaction">Flutter in Action</a>. Streams can be hard to grasp (and implement) if you aren't familiar, but they're wildly useful and popular in the Flutter ecosystem.
</div>


`StreamProviders` work so similarly to `FutureProvider`, that we should just jump straight into code. First, setting up the stream:

```dart
class Person {
  Person({this.name, this.initialAge});

  final String name;
  final int initialAge;

  // A StreamProvider's only requirement is that, well,
  // you give it a stream value.
  // This [generator] function will _yield_ a new number every second.
  Stream<String> get age async* {
    var i = initialAge;
    while (i < 85) {
      await Future.delayed(Duration(seconds: 1), () {
        i++;
      });
      yield i.toString();
    }
  }
}
```

Next, the live example:

<iframe style="height:800px" src="https://dartpad.dev/embed-flutter.html?theme=dark&run=true&split=60&id=59c25f7f9b44c740b033ed1bc36101cf"></iframe>