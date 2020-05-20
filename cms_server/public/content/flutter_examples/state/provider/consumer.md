---
title: "Rebuilding widgets with Consumer"
author: "Eric Windmill"
category: "Flutter State and Logic Example Apps"
subSection: "Provider"
tags:
    - flutter
    - state management
    - provider
    - consumer
    - change notifier provider
---

Half the value of Provider comes from the way it allows you to easily decouple your business logic and inject it into your app. The other half of the value is found in the way it allows you to easily rebuild your UI when your state changes, thus creating a wonderful union. 

Before I get in the weeds, I want to take a little detour to and talk about rebuilding UI in Flutter. This is important now because we're about to talk about objects made to display data from providers.

As you may know, you (the Flutter developer) can tell Flutter to rebuild your UI by calling `setState`. You can also manage when your UI updates with other methods on the `State` object, such as "didChangeDependencies". But, importantly, it all comes down to the `State` object.

What you may not know is that widgets are just "configuration" or blue-prints for different objects called `Elements`. And, when you call `setState`, your widget is really interfacing with a singular Element, and not the Flutter or the widget tree. It's the Element's responsibility to tell Flutter that it has changed, and it needs to be repainted. It does this via a method called `markNeedsBuild`.

All of this extra knowledge is preparation for one fact about `Provider`: All the objects in Provider are widgets (and elements). They know how to interface with Flutter. Which means you don't have to call `setState` if you're using Provider properly, because its toolbox of widgets are handling all of that for you. 

This leads me all the way back around to the first paragraph, in which I was about to introduce [Consumer](consumer docs). Consumer is an object from Provider that only offers a simple API to interact with your provided models in the widgets themselves. In plain English, Consumer exposes instances of provided models, so you can display data and call methods on your provided model.

Recall this previous example:

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
          '''
          Hi ${Provider.of<Person>(context).name;}!
          You are ${Provider.of<Person>(context).age} years old''',
        ),
      ),  
      floatingActionButton: FloatingActionButton(
        onPressed: () => Provider.of<Person>(context, listen: false).increaseAge(),
      ),
    );
  }
}
```

Here, we're writing `Provider.of<Person>(context)` three times. In this situation, in which you're interacting with the model quite a bit, this can be simplified using `Consumer`. Let's take a look at an example:

<iframe style="height:800px" src="https://dartpad.dev/embed-flutter.html?theme=dark&run=true&split=60&id=14d147fb543b43a7e4776732fffd7166"></iframe>

I like this description of Consumer from the [official docs](https://flutter.dev/docs/development/data-and-backend/state-mgmt/simple#changenotifier): "The Consumer widget doesn't do any fancy work. It just calls Provider.of in a new widget, and delegates its build implementation to builder."

Practically, that means that the consumer uses the `builder` pattern that's common with widgets. Using this pattern, the `Consumer` widget exposes some nice objects that make working with the provided models easier. Here's the example above again, but using a `Consumer`:


```dart
class MyHomePage extends StatelessWidget {
  const MyHomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // wrap widgets that need the model in a consumer
    // consumer.builder callback is passed the person instance
    // provided by a provider.                
    return Consumer<Person>(
      builder: (context, person, _) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Provider Class'),
          ),
          body: Center(
            child: Text(
            // now, you can just call 'person.name', et all
              '''
            Hi ${person.name}!
            You are ${person.age} years old''',
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () => person.increaseAge(), // works here too
          ),
        );
      },
    );
  }
}
```

In this example, you're using the consumer to wrap the entire page. Here, that may be okay because it's:
 - a very small widget tree
 - and multiple children of the Scaffold need access to the `person` instance
 
In a robust app, though, this may be undesirable. With this set up, the entire page is rebuilding every time any widget in the entire page is rebuilt. If there are hundreds of widgets in your tree, you might see a performance hit. You can solve that problem with consumer.

The obvious way, I guess, to solve this would be to wrap a consumer around each of the individual widgets that need it. But, that brings us back to the inconvenience we were trying to solve in the first place (robust, repeated code). 

A better way to solve that is by using the `Consumer.child` argument in tandem with the `builder`.

I have to tweak the code a little bit to make this example mean anything, so I'm including a live example:
 

<iframe style="height:800px" src="https://dartpad.dev/embed-flutter.html?theme=dark&run=true&split=60&id=b11fc6602f5156543fddfd7041dd5aa2"></iframe>
So, what's going on here? The `child` widget passed to `Consumer` is built on it own, outside of the `builder` callback. It is then _passed into_ the builder as it's third argument. While this API may look a little wonky, it's pretty impressive. It allows the child widget to go on livin', without being rebuilt, while all the widgets defined in the builder callback do get rebuilt. Wow.

Again, the API might seem confusing, because it looks like the consumer now has two properties that build the widget tree below this Consumer. But, once you get used to looking at this, it's not a big deal. And totally worth the benefits.

 