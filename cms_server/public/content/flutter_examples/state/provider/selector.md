---
title: "Finer build control with Selector"
author: "Eric Windmill"
category: "Flutter State and Logic Example Apps"
subSection: "Provider"
tags:
    - flutter
    - state management
    - provider
    - consumer
    - selector
---

In the last lesson, we looked at `Consumer`. Before we move back to types of providers, we should look at `Selector`. Selector is similar to consumer, but provides some fine control over when a widgets `build` method is called. In a nutshell, `selector` is a consumer that allows you to define exactly which properties from a model you care about.

For example, suppose you're working with a `User` class that has 25 properties on it. You don't need to rebuild, or even pass in, a text widget that displays a user name when you update their phone numbers. Selector used for just that.

Because `Selector` is so similar to `Consumer`, we should just jump into a code example.  

<!-- i frame -->

In my opinion, consumer is probably just fine for most use cases, unless you have an app that's so large that each build is a big deal. That said, this is all moot, because towards the end of this tutorial we will see even better ways to "consume" your models.




