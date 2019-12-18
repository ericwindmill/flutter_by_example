---
title: "Build the example app boiler-plate"
author: "Eric"
category: "Flutter Examples"
subSection: "Custom Animation: Progress Indicator"
tags:
    - BoxShadow
    - custom widget
    - Scaffold
---

The following code example will render the four pegs to the screen. They won't animate. In the remaining lessons, I will focus on animations.

```dart
// This example app is only one page
void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        body: PegProgressIndicator(),
      ),
    ),
  );
}

// This widget is the progress indicator container
class PegProgressIndicator extends StatefulWidget {
  @override
  _PegProgressIndicatorState createState() => _PegProgressIndicatorState();
}

// NOTE: If you look at the source code for this app, you'll notice that 
// all animation related code is omitted here. I will be added in as the lesson
// progresses.

class _PegProgressIndicatorState extends State<PegProgressIndicator> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Peg(),
            Peg(),
            Peg(),
            Peg(),
          ],
        ),
      ),
    );
  }
}
```

Once you have this code copy + pasted into a text editor, move on so we can talk about the meat of this example: animations.

