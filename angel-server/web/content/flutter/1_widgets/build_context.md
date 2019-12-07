---
title: "BuildContext"
author: "Eric"
category: "Flutter"
subSection: "Widgets"
tags:
    - flutter
    - build context
    - widget
---

Every Flutter widget has an `@override build()` method with the argument of `BuildContext`.

```dart
class CartItemWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
  // ...
```

<div class='aside'>

### why BuildContext()

Simply explain is that the `BuildContext` is:
- the location of the `Widget` in the widget tree.
- a widget of widgets, like nested.wrap `<div <div> .html>`
- parent objects in qt and alike
- In Flutter, everything is a Widget, down to the final `build.call()`
- Until finally a widget is returned with its "stuff," row dimentions et all

</div>

Important concept to understand is that 

1 - Every `Widget` has its own `build()` and its `context`.
2 - The BuildContext is the parent of the widget returned by the `build()` method._


In other words, the `buildContext` of the Widget that _calls_ `build()` is not the
same as the build context of the widget _returned_ by `build()`.

```dart
class _MyHomePageState extends State<MyHomePage> {
  _MyHomePageState() {
    print(context.hashCode);
    // prints 2011
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: new Container(),
      floatingActionButton:
          new FloatingActionButton(onPressed: () => print(context.hashCode)),
          // prints 63
    );
  }
}
```

If you did this exact experiment, the print statements would be different, but
those are the actual numbers that I got.

**But what does this actually mean?**

This is the one big **gotcha;-)**:  
- It is easy to reference the _wrong_ `build()`
- and its `context` 
- This can cause unexpected situations, specifically when using the `of()` method.

### The 'of()' Method

In Flutter, as everthing are widgets, looking up and down the widget tree, in some cases, to
reference other Widgets. This is required for some functionality.

In particular, widgets that want to use the State of `inherited` widgets need
to be able to reference those inherited widgets. This usually comes in the form
of the `of` method.

For example:

```dart
@override
Widget build(context) {
  return new Text('Hello, World',
    style: new TextStyle(color: Theme.of(context).primaryColor),
  );
}
```

Under the hood, that `of` method is looking up the tree for the next parent
widget that is of type `Theme`, and grabbing that primary color property. The
framework can find the correct `Theme` object because it knows the tree in
relation to this `build context`.

#### The Gotcha

With the scaffold, Flutter does give us a nice way to solve following problem...

When creating some widgets, such as a snackbar, you have to grab the nearest
Scaffold context so that Flutter knows how to paint the snackbar, since
Scaffold is the widget that actually gives us access to displaying snackbars.

Consider this:

(hint: it doesn't work)

```dart
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text(widget.title),
        ),
        body: new Container(),
        /// Scaffold doesn't exist in this context here
        /// because the context thats passed into 'build'
        /// refers to the Widget 'above' this one in the tree,
        /// and the Scaffold doesn't exist above this exact build method
        ///
        /// This will throw an error:
        /// 'Scaffold.of() called with a context that does not contain a Scaffold.'
        floatingActionButton: new FloatingActionButton(onPressed: () {
          Scaffold.of(context).showSnackBar(
                new SnackBar(
                  content: new Text('SnackBar'),
                ),
              );
        }));
  }
```

### Builder Methods

`Builder` is a widget that takes a closure and uses it to build its child
widgets. In laymans, you can use it to pass the context from a `build` method
directly to children being returned in that `build` method.

Using the example above:

```dart
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: new Container(),
      /// Builders let you pass context
      /// from your *current* build method
      /// Directly to children returned in this build method
      ///
      /// The 'builder' property accepts a callback
      /// which can be treated exactly as a 'build' method on any
      /// widget
      floatingActionButton: new Builder(builder: (context) {
        return new FloatingActionButton(onPressed: () {
          Scaffold.of(context).showSnackBar(
                new SnackBar(
                  backgroundColor: Colors.blue,
                  content: new Text('SnackBar'),
                ),
              );
        });
      }),
    );
  }
```

<div class='tip'>

**tip**: You could also solve this by simply making your build methods
smaller, and returning a Scaffold in a 'higher' widget. When in doubt, stick
with smaller return methods.

</div>