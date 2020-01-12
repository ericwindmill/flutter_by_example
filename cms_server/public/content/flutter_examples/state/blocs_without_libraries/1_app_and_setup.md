---
title: "What are blocs?"
author: "Eric"
category: "Flutter State Management Example Apps"
subSection: "Blocs without Libraries"
tags:
    - flutter
    - state management
    - blocs
---

<div class="aside"> This text is a snippit from the book <a href="https://www.manning.com/books/flutter-in-action">Flutter in Action</a>, written by Eric Windmill and published by Manning Publications.</div>

_B.L.o.C._ stands for Business Logic Components (or simply _blocs_ from here on out). This pattern was first revealed at Dart Conference 2018, aka DartConf, and it's purpose is to make UI business logic highly reusable. Specifically at DartConf, it was presented as a nice way to share all UI logic between Flutter and AngularDart.

The bloc pattern's mantra is that widgets should be as dumb as possible, and the business logic should live in separate components. This in itself isn't unique, compared to other approaches, but the devil is in the details. In general, blocs are what they are for two main reasons:

* Their public API consists of simple inputs and outputs only.
* Blocs should be _injectable_, which means platform agnostic. This means you can use the same blocs for Flutter, AngularDart, on the server, etc.

Those are broad ideas, of course, but they're made clearer by the following _non-negotiable_ rules. These rules were described in the original talk at DartConf 2018 and live in two categories: application design and UI rules.

For application design:

. Inputs and outputs are sinks and streams only! No functions, no constants, no variables! (Although, you'll see that this rule is "broken" quite often to make code more concise. More on that later.)
. Dependencies must be injectable. If you're importing any Flutter libraries into the bloc, then that's UI work, not business logic, and those should be moved into the UI.
. Platform-branching is not allowed. If you find yourself in a bloc writing `if (device == browser)...`, then you need to reconsider.
. Do whatever else you want, so long as you follow these rules.

For UI functionality:

. In general, blocs and top-level Flutter pages have a one-to-one (1:1) relationship. In reality, the point is that each logical state subject has its own bloc. For example, in a Todo List app, you might have a bloc for the 'Todo List' page, and a bloc for the "Add Todo" page.
. Components should send inputs as is, because there shouldn't be business logic in the widget! If you need to format text or serialize a model, it should be done in the bloc.
. Outputs should be passed to widgets ready to use. For example, if you have a number that needs to be converted into displayable currency, that should be done in the bloc.
. Any branching should be based on simple bloc boolean logic. You should limit yourself to a single boolean stream in the bloc. For example, in Flutter, it's acceptable to write `color: bloc.isDestructive ? Colors.red : Colors.blue`. It is considered wrong if you have to use complex boolean clauses like `if (bloc.buttonIsDestructive && bloc.buttonIsEnabled && bloc.userIsAdmin) { ...`. If you find yourself doing this, you can probably move this logic to the bloc.

Wherever possible, your widgets should be dumb, stateless widgets whose only job is rebuilding when it's told to. 

### 'Counter App' using blocs

```run-dartpad:mode-flutter:theme-dark

import 'package:flutter/material.dart';
import 'dart:async';

void main() => runApp(MyApp());

class CounterBloc {
  // this sink is the 'input'.
  // sinks should be the _only_ way that 
  // outside object can interact with blocs. 
  StreamController<int> todoCompleteSink = StreamController();

  // this stream is the 'output'
  // it's the only property that outside
  // objects can use to consume this blocs data.
  Stream<int> get todoCompleteStream => todoCompleteSink.stream;

  CounterBloc() {
    todoCompleteSink.add(0);
  }
  
  dispose() {
    todoCompleteSink.close();
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final CounterBloc bloc = CounterBloc();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<int>(
      // here the bloc data is being consumed by the UI 
      stream: bloc.todoCompleteStream,
      builder: (context, snapshot) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Flutter Demo Home Page"),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'You have pushed the button this many times:',
                ),
                Text(
                  '${snapshot?.data ?? 0}',
                  style: Theme.of(context).textTheme.display1,
                ),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            // here the sink is being used to tell
            // the bloc it should update it's state
            onPressed: () => bloc.todoCompleteSink.add(snapshot.data + 1),
            tooltip: 'Increment',
            child: Icon(Icons.add),
          ),
        );
      },
    );
  }
}
```

The above example is the most simple possible Flutter / Bloc example I can think of. It's so simple that it may not answer many questions you have about blocs. The rest of this example app will show a more complicated example, which uses complex data, multiple blocs working in unison, and talking to repositories outside of the app.