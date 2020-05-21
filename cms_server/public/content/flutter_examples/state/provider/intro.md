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

[Provider](https://github.com/rrousselGit/provider) can be somewhat difficult to explain. The package author, [Remi](https://github.com/rrousselGit), has described it as a mix between State Management and Dependency Injection. At his talk at [Flutter Europe in 2019](https://www.youtube.com/watch?v=BulIREvHBWg), he quoted another Flutter community usual, [Scott Stoll](https://twitter.com/scottstoll2017), who called is 'Inherited Widgets for humans'. I think this is the most straight-forward explanation.

I also find it difficult to find an explanation on the interwebs that includes an easy to grok example. If you want to use provider effectively, you're left to tinkering or reading the source code. I will attempt to fill that void here. 

In a nutshell, Provider gives us an easy, low boiler-plate way to separate business logic from our widgets in apps. Because it's built on `InheritedWidget` classes, it also makes it easy to re-use and re-factor business logic. Separating state from your UI is one of the main problems that Provider solves.

### What does Provider do for me? 

It can be used in a variety of ways in your Flutter app. It can be used in-lieu of more robust state-management libraries, or along side them. It can be used with `InheritedWidgets` and `StatefulWidgets`, or again, in place of them. It "does" two jobs:

- Separates your state from your UI
- Manages rebuilding UI based on state changes

Which makes loads of things simpler, from reasoning about state, to testing to refactoring. It makes your codebase _scalable_.

Consider this widget tree that uses no libraries at all:

<!-- widget tree image -->
This widget tree is an extremely crude version of the `Counter` app we all know and love. It passes a callback (`onPressed`) to a `FloatingActionButton` and a `counter` property down a text widget. When `onPressed` is fired, it updates the counter. 
![counter app widget tree](https://res.cloudinary.com/duqbhmg9i/image/upload/c_scale,h_673/v1590101648/flutter_by_example/widget_tree_0_no_provider_cv4dap.png)

That's fine, but what happens when you need to refactor your code? What happens if state is shared between different widgets?  And what about testing? Your logic is sprinkled throughout your app, and tied to your widgets. This makes writing tests a pain, verbose, and hard to refactor.

Imagine for a moment that you decided you no longer wanted a FloatingActionButton, and you wanted a button, as a child of the column, to trigger `onPressed`. That refactor would be a pain. 

(I know my drawing... err... leaves a lot to be desired. But the gist is that all of the pink text is what would have to be refactored.)

![refactoring the widget tree](https://res.cloudinary.com/duqbhmg9i/image/upload/c_scale,h_673/v1590101648/flutter_by_example/widget_tree_2_no_provider_c59lkm.png)

But there's a better way. (To be fair, this can be done with just plain ol InheritedWidgets as well, but provider has a nicer API and less boiler plate.) 

(Disclaimer! A provided widget _is_ in the widget tree, but I drew it separately because I feel it's helpful to think of them as different entities.)

<!-- image of provider on one side and widget tree on the other -->
 ![widget tree with provider](https://res.cloudinary.com/duqbhmg9i/image/upload/c_scale,h_673/v1590101650/flutter_by_example/widget_tree_w_provider_fupfto.png)

If you're using this architecture, you can have any widget in the tree read the Counter and trigger counter methods. Refactor away, because it's much easier. And, you can test the logic of the counter with a simple unit test, no need to bring the the UI into it.

### Is provider a State Management library?

In my opinion, no. But it can be. 

Unlike libraries like Redux and Bloc, Provider simply provides tools to 'wire up' our UI to business logic, and it is not opinionated in how you manage state. Because of this, it's almost easier to look at it as Flutter-specific dependency injection library (and that's what it was originally advertised as). In fact, the Bloc library is built on top of provider, because provider, again, doesn't _really_ manage state for you.

Provider helps make your widgets as 'dumb' as possible by separating logic from the widgets, and injecting the important data to those widgets. If you're building an e-commerce app, you can build a _cart page_ that knows it should display some items in a cart. But, using provider, the widget has no concept of what those items are, nor is it responsible for keeping track of the cart contents. Rather, there would be a separate class elsewhere in your app, perhaps called `Cart`, that manages all the logic. And, whenever a new item is added the the cart, the widget that displays the cart item is told to re-render with the new items.

If this seems hand-wavy and obtuse, the examples on the following pages should help make this more concrete (as well as show you what you really want: _how_ to use provider with real life code). 

But lastly, I need to point out a few important points to remember while using provider:

* Provider is built using widgets. It literally creates new widget subclasses, allowing you to use all the objects in provider as if they're just part of Flutter. This also means that provider is _not_ cross platform. (By cross platform, I mean outside of a Flutter project. i.e. AngularDart)
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
- [Bonus for the curious: How is Provider implemented](bonus_provider_implementation.md)