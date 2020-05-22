---
title: "For the curious: How is provider implemented"
author: "Eric Windmill"
category: "Flutter State and Logic Example Apps"
subSection: "Provider"
tags:
    - flutter
    - state management
    - provider
---

The content of this lesson could be filed under "extraneous". You don't need to know this in order to use Provider. No more than you need to know how Skia works to build a Flutter app. But, you might learn something neat. I will also spend some time gushing about how cool Provider is, and how well designed it is. This was not my intention, but it happened.

Some background: In order to learn Provider, I basically 'rebuilt it', using the original package as a guide. This is how I like to learn the ins and outs. While taking on that venture, I learned a lot of interesting things about both Flutter and Provider. Things that I have read before, and make sense logically, but really 'clicked' when I saw how they were implemented. 

So, I've decided to do a short write up of how Provider works for the curious out there. 

<div class="disclaimer">
This is 100% information that I have deduced, without any confirmation from the real experts, such as the package author. So, take this all with a grain of salt.
</div>

### A Flutter detour

Before I get in the weeds, I want to take a little detour to and talk about how Flutter builds (and rebuilds) UI.

As you may know, you (the Flutter developer) can tell Flutter to rebuild your UI by calling `setState`. You can also manage when your UI updates with other methods on the `State` object, such as `didChangeDependencies`. But, it all comes down to the `State` object. (`StatelessWidget`, on the other hand, are rebuilt when they're changed by configuration changes passed into them.)

What you may not know is that widgets are just "configuration" or blue-prints for different objects called `Elements`. And, when you call `setState`, your widget is interfacing with a singular Element, and not the Flutter or the widget tree itself. It's the Element's responsibility to tell Flutter that it has changed, and it needs to be repainted. This is done this via a method called `markNeedsBuild`, which is called internally.

This matters to us (provider users) because all objects in Provider are widgets (and elements). They know how to interface with Flutter. Which means you don't have to call `setState` if you're using Provider properly, because its toolbox of widgets are handling all of that for you. This is an important piece of Provider's design.

### Providers are widgets

If you read any docs, you will surely understand that all classes in Provider are implementations of different widgets. I read this over and over again, but just kind of "glossed over it", and didn't really internalize the implications. But, I'll say it here anyway: Providers are widgets! And that's primarily what I want to talk about in this lesson. 

When I started reading Provider source code, I was immediately overwhelmed by the number of classes, mixins, extensions and interfaces that are in that library. There are typedefs abound, to boot. I wrapped my head around it by creating a chart of sorts that describes the class structure of Provider. It looks like this:

(I don't expect you to be able to read this)
<!-- full screen shot -->
![provider class hierarchy](https://res.cloudinary.com/duqbhmg9i/image/upload/c_scale,h_741/v1590094616/flutter_by_example/Provider_1_g8iahe.jpg)

Keep in mind that the only Provider that this document includes is the base `Provider` class. I haven't included FutureProvider, StreamProvider, Consumer, Selector, etc.

The big text that you _can_ read in this image is "Element Tree" and "Widget Tree". This seems like a good place to start. 

<!-- element tree --> 
The element tree:
![element tree](https://res.cloudinary.com/duqbhmg9i/image/upload/c_scale,h_1000/v1590094616/flutter_by_example/Provider_2_plmcy1.jpg)

The widget tree:
![widget tree](https://res.cloudinary.com/duqbhmg9i/image/upload/c_scale,h_1000/v1590094616/flutter_by_example/Provider_3_qzrmh0.jpg)

All these charts may only make sense to me, but let me point out some interesting insights:

1. These classes aren't just Widget types, they're widgets built from the ground up. They include custom `Element` types. They are literally custom implementations of objects that Flutter can work with, and they don't rely on  `InheritedWidget` or under the hood. This is impressive, _and_ powerful.
2. Much of the classes are exposed to us, the developers. Specifically interesting is `InheritedProvider`, which all providers are subclasses of. (Again, my chart only shows `Provider`, but you'll have to trust me on this one.) This means that just like you can build your own widgets in Flutter, Provider is implemented in a way that you can build your `Providers`. Truly following the Flutter pattern that we all know and love.
3. Provider even includes its own `BuildContext` sub class, which is why we can work with Provider so seamlessly in the widget tree.
4. `InheritedProvider` classes do have a concept of `State` (via the `_Delegate` objects), which seems to be one of the reasons that we can use these inherited widget-esque objects with so little boiler plate. Previous to this package, using InheritedWidget's for responsive state management involved combining inherited widgets and stateful widgets, which of course means a ton of boiler plate.

### final thoughts

Provider is truth.



