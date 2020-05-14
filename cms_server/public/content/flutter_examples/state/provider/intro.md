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

In a nutshell, Provider gives us an easy, low boiler-plate way to separate business logic from our widgets in apps. Unlike libraries like Redux and Bloc, Provider simply provides tools to 'wire up' our UI to business logic, and it is not opinionated in how you manage state. Because of this, it's almost easier to look at it as Flutter-specific dependency injection library (and that's what it was originally advertised as). In fact, the Bloc library is built on top of provider, because provider, again, doesn't _really_ manage state for you.

Provider, therefor, helps make your widgets as 'dumb' as possible. If you're building an e-commerce app, you can build a _cart page_ that knows it should display some items in a cart. But, using provider, it has no concept of what those items are, nor is it responsible for keeping track of the cart contents. Rather, there would be a separate class elsewhere in your app, perhaps called `Cart`, that manages all the logic. And, whenever a new item is added the the cart, the widget that displays the cart item is told to re-render with the new items. That's all the widget has to do.

If this seems hand-wavy and obtuse, the examples should help make this more concrete (as well as show you what you really want: _how_ to use provider with real life code). 

But lastly, I need to point out a few important points to remember while using provider:

* Provider is built using widgets. It literally creates new widget subclasses, allowing you to use all the objects in provider as if they're just part of Flutter. This also means that provider is _not_ cross platform. (By cross platform, I mean outside of a Flutter project.)
* Separating this business logic makes your code much easier to test and maintain.
* Again, Provider is not opinionated about state management. It is not going to force consistency like Redux would.


The remainder of this section will walk through the usage of Provider by walking through how you'd use each of the different classes in Provider:

- [Basic Usage (Provider class)]
- [Consumer and Selector]
- [ListenableProvider]
- [ChangeNotifierProvider]
- [ValueListenableProvider]
- [FutureProvider]
- [StreamProvider]
- [InheritedProvider (Creating your own provider)]
- Implementation deep dive