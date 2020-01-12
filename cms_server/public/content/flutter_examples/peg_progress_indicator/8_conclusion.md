---
title: "Bring it all together"
author: "Eric"
category: "Flutter UI Example Apps"
subSection: "Custom Animation: Progress Indicator"
tags:
    - AnimatedWidget
    - Scaffold
---

Now that you have 8 intervals to your animation, and an `AnimatedWidget` to
feed em to, the last step is just adding the `PivotBar` to your build method in
`_BarLoadingScreenState`.

```dart
// in the [_PegProgressIndicatorState] class
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          PegAnimation(
            alignment: FractionalOffset.centerLeft,
            controller: _controller,
            animations: [
              stepOne,
              stepTwo,
            ],
            marginRight: 0.0,
            marginLeft: 0.0,
            isClockwise: true,
          ),
          PegAnimation(
            controller: _controller,
            animations: [
              stepThree,
              stepEight,
            ],
            marginRight: 0.0,
            marginLeft: 0.0,
            isClockwise: false,
          ),
          PegAnimation(
            controller: _controller,
            animations: [
              stepFour,
              stepSeven,
            ],
            marginRight: 0.0,
            marginLeft: 32.0,
            isClockwise: true,
          ),
          PegAnimation(
            controller: _controller,
            animations: [
              stepFive,
              stepSix,
            ],
            marginRight: 0.0,
            marginLeft: 32.0,
            isClockwise: false,
          ),
        ],
      ),
    );
  }
```

And that's it. I omitted some of the repeated code, but you can find it in the next lesson: Complete source code
