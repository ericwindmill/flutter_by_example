---
title: "What is Provider?"
author: "Eric Windmill"
category: "Flutter State and Logic Example Apps"
subSection: "Provider"
tags:
    - flutter
    - state management
    - provider
---

[Provider](https://github.com/rrousselGit/provider) can be somewhat difficult to explain. The package author, a pretty impressive guy names [Remi](), has described it as a mix between State Management and Dependency Injection. At his talk at [Flutter Europe in 2019](), he quoted another Flutter community usual, [Scott Stoll](), who called is 'Inherited Widgets for humans'. I think this is the most straight-forward explanation, but only if you first understand what InheritedWidgets are.

To top all of this off, I have found it difficult to find an explanation on the interwebs that includes an easy to grok example. Which means, if you want to use provider effectively, you're left to tinkering or reading the source code. I will attempt to fill that void here. 

In a nutshell, Provider gives us an easy, low boiler-plate way to separate business logic from our widgets in apps. Because it's built on `InheritedWidget` classes, it also makes it easy to re-use and re-factor business logic. In fact, separating state from your UI is one of the main problems that Provider solves.

### What does Provider do for me? 

It can be used in a variety of ways in your Flutter app. It can be used in-lieu of more robust state-management libraries, or along side them. It can be used with InheritedWidgets and StatefulWidgets, or again, in place of them. What it _really_ does is best is 2 things:

- Separates your state from your UI
- Makes it easy to update your UI when necessary based on StateChanges

Those things may seem somewhat contradictory, but that may be what makes Provider so cool. Consider this widget tree that uses no libraries at all:

<!-- widget tree image -->

That's fine, but what happens when you need to refactor your code? 

<!-- more about moving widgets, and image about how messy it is-->

And what about testing? Your logic is sprinkled throughout your app, and tied to your widgets. This makes writing tests a pain, verbose, and hard to refactor.

But there's a better way. (To be fair, this can be done with just plain ol InheritedWidgets as well, but provider has a nicer API and less boiler plate.) 

<!-- image of provider on one side and widget tree on the other --> 

It's important to note that the Providers are indeed in the widget tree, but conceptually, they are their own entities.

### Is provider a State Management library? 

Unlike libraries like Redux and Bloc, Provider simply provides tools to 'wire up' our UI to business logic, and it is not opinionated in how you manage state. Because of this, it's almost easier to look at it as Flutter-specific dependency injection library (and that's what it was originally advertised as). In fact, the Bloc library is built on top of provider, because provider, again, doesn't _really_ manage state for you.

Provider, therefor, helps make your widgets as 'dumb' as possible. If you're building an e-commerce app, you can build a _cart page_ that knows it should display some items in a cart. But, using provider, it has no concept of what those items are, nor is it responsible for keeping track of the cart contents. Rather, there would be a separate class elsewhere in your app, perhaps called `Cart`, that manages all the logic. And, whenever a new item is added the the cart, the widget that displays the cart item is told to re-render with the new items. That's all the widget has to do.

If this seems hand-wavy and obtuse, the examples on the following pages should help make this more concrete (as well as show you what you really want: _how_ to use provider with real life code). 

But lastly, I need to point out a few important points to remember while using provider:

* Provider is built using widgets. It literally creates new widget subclasses, allowing you to use all the objects in provider as if they're just part of Flutter. This also means that provider is _not_ cross platform. (By cross platform, I mean outside of a Flutter project.)
* Separating this business logic makes your code much easier to test and maintain.
* Again, Provider is not opinionated about state management. It is not going to force consistency like Redux would.


The remainder of this tutorial will walk through the usage of Provider by walking through how you'd use most of the different classes in Provider:

- [Basic Usage (Provider class)](provider_class.md)
- [MultiProvider](multi_provider.md)
- [Value Provider Constructors](value_constructors.md)
- [Consumer](consumer.md)
- [Selector](selector.md)
- [Context extension methods](context_of.md)
- [ChangeNotifierProvider](change_notifier_provider.md)
- [FutureProvider](future_provider.md)
- [StreamProvider](stream_provider.md)
- [ProxyProvider](proxy_provider.md)
- [A more complex app example](final_example.md)