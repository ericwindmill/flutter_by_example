---
title: "Thinking in widgets"
author: "Eric"
category: "Flutter"
subSection: "Widgets"
tags:
    - flutter
    - composition
    - widgets
---

In Flutter, _everything_ is a widget. Widgets are just tiny chunks of
UI that you can combine to make a complete app. Building an app Flutter is
like building a lego set -- piece by piece.

Widgets are nested inside of each other to build your app. Even the root of your
app is just a widget. It's widgets all the way down.

Flutter is unique in that _every_ aspect of UI is handled with Widgets.

A widget might display something, it might help define design, it might help
with layout, or it may handle interaction. I really can't drive this home enough:
_everything is a widget_.

* A simple widget that displays text: `const Text('Hello World')`.
* A simple widget that a user interacts with `const Button(onTap: ...callback...)`
* A simple widget that adds a background color: `const BoxDecoration(background: Colors.blue)`

If you're coming from the web: imagine that your CSS, HTML, and JavaScript are all handled by
widgets. There is no markup language. There is no CSS. Just widgets.

### Widget Hierarchy

In this picture, every thing that's outlined is a widget:

![Outlined widgets](https://res.cloudinary.com/ericwindmill/image/upload/v1527539536/flutter_by_example/thinking_in_widgets.png)

This picture is from one of the tutorial apps on FlutterByExample, and this is
a detail page, of which there is one for every dog in the app.

The green outline represents the page. And a page in Flutter is a
widget. The blue outlines represent pieces of UI that logically group together.
The rest are outlined white, and they're simply dumb components that have no
concern over their content, they just display what they're told.

This is the widget hierarchy for this page:

* PageWidget
  * DogProfileWidget
    * CircleImage
    * Text
    * Text
    * Text
    * Container
      * Icon
      * Text
  * RateDogWidget
    * Slider
    * Text
    * SubmitButton

<div class="aside">
This isn't _exactly_ accurate, there are layout widgets
such as `columns`and `padding` in here that I'm glossing over.
</div>

### Design for Re-usability

The most important part of using Flutter Widgets effectively is designing your
lowest level widgets to be reusable.

For example, the CircleImage widget from the image above:

```dart
class CircleImage extends StatelessWidget {
 final String renderUrl;

 CircleImage(this.renderUrl);

 @override
 Widget build(BuildContext context) {
   return new Container(
    width: 100.0,
    height: 100.0,
    decoration: new BoxDecoration(
      shape: BoxShape.circle,
      image: new DecorationImage(
        fit: BoxFit.cover,
        image: new NetworkImage(renderUrl ?? ''),
      ),
    ),
  );
 }
}
```

Then, anywhere in your app, you can reuse this Widget: `new CircleImage('https..)`.
This component is designed for re-usability because anywhere in your app that
you may want a round image of a certain size, you can just pass in a url and
there you have it. There's no need to re-write this widget over and over.

And, this circle image doesn't care at all about what it's displaying. It's
just enforcing styles.

In the test app that these images are from, I also have a list of all the dogs
in the app. Heres a picture of one of the cards:

![Dog card](https://res.cloudinary.com/ericwindmill/image/upload/v1527539533/flutter_by_example/Screen_Shot_2018-05-27_at_12.13.40_PM.png)

In that Widget, I don't need to rewrite the circle image, because I've already
built it once.



