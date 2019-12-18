---
title: "Intro and Overview"
author: "Eric"
category: "Flutter Examples"
subSection: "Custom Animation: Progress Indicator"
tags:
    - flutter
    - example
    - animation
    - tween
    - animated widget
---

In this example, you're going to build a simple animation that looks like this:

![custom animation gif](https://res.cloudinary.com/ericwindmill/image/upload/c_scale,w_250/v1525022858/flutter_by_example/animation.gif)

While this looks like one fluid animation, this is actually 8 animation definitions. Each of the four pegs is animated twice. 

> #### What'll you learn?
>
> * AnimatedWidget
> * Tweens
> * AnimationController
> * Transform widget

This 'app' will have 4 classes:

1. `PegProgressIndicator extends StatefulWidget`
2. `_PegProgressIndicatorState extends State<PegProgressIndicator> with TickerProviderStateMixin`

* This is basically the highest widget in the tree that we care about for this example. 
* It will eventually hold the `AnimationController`
* Its Basically the entire brains of the animation

3. `Peg extends StatelessWidget`

* The widget for display.

4. `PegAnimation extends AnimatedWidget`

* This is the wrapper for the bar of pegs. It's responsible for applying animations to the individual pegs.
* It gives the tweens and animations to `Transform` widgets, which is a built in widget that rotates or offsets a widget. We'll be using it to animate the peg.
