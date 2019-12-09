---
title: "The Widget tree"
author: "Eric"
category: "Flutter"
subSection: "Widgets"
tags:
    - flutter
    - widgets
    - tree
---

At any given moment, your Flutter app will consist of many widgets, which are related via a tree structure. This isn't unlike the DOM in the web-browser, which organizes HTML elements in a tree of sorts. Not only is the widget tree an actual data structure built by the framework, its also a useful way to talk about your Flutter app.  

The following diagram shows what the widget tree for the counter app might look like. (Note that the counter app is the starter app that's generated when you run `flutter create` in your terminal.) 

<!-- TODO: insert image-->

In general, you build the widget tree via the `build` method in widget objects. Every time a build method returns more widgets, those widgets all become nodes in the tree. When a user is interacting with your application, Flutter uses this tree structure to represent your app's widgets. When a user navigates to a new screen, Flutter will remove all the widgets in the tree that are no longer used (from the screen they navigated away from) and replace them with widgets that represent the new page. 

