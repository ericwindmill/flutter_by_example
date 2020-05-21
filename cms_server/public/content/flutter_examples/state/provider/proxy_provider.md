---
title: "ProxyProvider"
author: "Eric Windmill"
category: "Flutter State and Logic Example Apps"
subSection: "Provider"
tags:
    - flutter
    - state management
    - provider
    - ProxyProvider
---

ProxyProvider is the tough to grok at first, but it's quite useful. It let's you pass values from one provided model to another, to create a value from two (or more) providers.

<!-- diagram of passing one provider into the next -->

Right off the bat, here's some things to keep in mind before looking at the code:

- There are several kinds of ProxyProviders, which are proxy versions of the standard providers they resemble:
    - ProxyProvider
    - ChangeNotifierProxyProvider
    - ListenableProxyProvider
- You can use up to 6 providers to combine values, but you must use the following classes to specify the number of providers that will be passing values into the proxy:
    - ProxyProvider0 (the base class)
    - ProxyProvider2 (pass values from 2 providers into the proxy)
    - ProxyProvider3
    - ProxyProvider4
    - ProxyProvider5
    - ProxyProvider6
    
Those same classes exist for `ChangeNotifierProvider` and `ListenableProxyProvider`.

### Using Proxy Provider

Explaining the proxy provider in words is pretty esoteric and hard to grok, so let's look at some code. In the following example, our example friend 'Yohan' is growing up, and it's time for him to get a job. I am providing a `Person` object to the widget tree, and also a `Job` object. A `Job` requires a person for initialization.

In this situation, the `Job` is the _proxy_. Which means that the Job is the object you'll likely want to interface with, but it's values rely on the person, so that will be exposed as well.

NB: It's important to note that you still _can_ interact with the person if you'd like, and you don't _have_ to expose the person via the job instance.

In this example, Yohan has made a digital business card. And, the he wants the business card to automatically change it's title when he gets older and graduates, and starts his career. The set-up follows:


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

class Job with ChangeNotifier {
  Job(
    this.person, {
    this.career,
  });

  final Person person;
  String career;
  String get title {
    if (person.age >= 28) return 'Dr. ${person.name}, $career PhD';
    return '${person.name}, Student';
  }
}

void main() {
  runApp(
    MultiProvider(
      providers: [
        // you must first provider the object that will be passed to the proxy    
        ChangeNotifierProvider<Person>(create: (_) => Person(name: 'Yohan', age: 25)),
        // Because the ChangeNotifierProxyProvider is being used,
        // each class used must be of ChangeNotifier type    
        ChangeNotifierProxyProvider<Person, Job>(
          // first, create the _proxy_ object, the one that you'll use in your UI
          // at this point, you will have access to the previously provided objects                
          create: (BuildContext context) => Job(Provider.of<Person>(context, listen: false)),
          // next, define a function to be called on `update`. It will return the same type
          // as the create method.   
          update: (BuildContext context, Person person, Job job) => Job(person, career: 'Vet'),
        ),
      ],
      child: MyApp(),
    ),
  );
}
``` 

As you can see, the set up is a bit more involved, perhaps. But, it's still quite terse and easy to read. And, in the following example, you'll see how easily it's used.

<iframe style="height:800px" src="https://dartpad.dev/embed-flutter.html?theme=dark&run=true&split=60&id=0de0984c6f057a14c17fdfc6568114c7"></iframe>

The neat thing here to look for is that all three values that are _read_, are done via the provided `job` object, but the button calls the `Person.increaseAge` method when pressed. Yet, the UI still knows to rebuild when the `Job.title` value is different.