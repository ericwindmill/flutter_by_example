---
title: "Routing 2: Add a form page"
author: "Eric"
category: "Flutter UI Example Apps"
subSection: "Basic App"
tags:
    - flutter
    - routing
    - MaterialPageRoute
    - Navigator
---

The only other page we will create is to add dogs.

The next section will show you how to handle user input, but you might as well add that route now, while we're on the subject.

### 1. Add NewDogPage

Create a new file in the `lib` folder called `new_dog_form.dart`.

The UI of this page is simple:

![form page screen shot](https://res.cloudinary.com/ericwindmill/image/upload/c_scale,w_300/v1521390457/flutter_by_example/Simulator_Screen_Shot_-_iPhone_X_-_2018-03-18_at_09.27.27.png)

Here's the code with no functionality (again, you'll add the user input functionality in the next section):

```dart
// new_dog_form.dart

import 'package:flutter/material.dart';

class AddDogFormPage extends StatefulWidget {
  @override
  _AddDogFormPageState createState() => _AddDogFormPageState();
}

class _AddDogFormPageState extends State<AddDogFormPage> {
  @override
  Widget build(BuildContext context) {
    // new page needs scaffolding!
    return Scaffold(
      appBar: AppBar(
        title: Text('Add a new Dog'),
        backgroundColor: Colors.black87,
      ),
      body: Container(
        color: Colors.black54,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 8.0,
            horizontal: 32.0,
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                // Text Field is the basic input widget for Flutter.
                // It comes built in with a ton of great UI and
                // functionality, such as the labelText field you see below.
                child: TextField(
                    decoration: InputDecoration(
                  labelText: 'Name the Pup',
                )),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: TextField(
                    decoration: InputDecoration(
                  labelText: "Pup's location",
                )),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: TextField(
                  decoration: InputDecoration(
                    labelText: 'All about the pup',
                  ),
                ),
              ),
              // A Strange situation.
              // A piece of the app that you'll add in the next
              // section *needs* to know its context,
              // and the easiest way to pass a context is to
              // use a builder method. So I've wrapped
              // this button in a Builder as a sort of 'hack'.
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Builder(
                  builder: (context) {
                    // The basic Material Design action button.
                    return RaisedButton(
                      // If onPressed is null, the button is disabled
                      // this is my goto temporary callback.
                      onPressed: () => print('PRESSED'),
                      color: Colors.indigoAccent,
                      child: Text('Submit Pup'),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
```

### 2. Add the Routing

Like the last section, you now have a page that you can't access. Add the button and routing information to the `_MyHomePageState` class.

```dart
// main.dart

@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text(widget.title),
      backgroundColor: Colors.black87,
      // This is how you add new buttons to the top right of a material appBar.
      // You can add as many as you'd like.
      actions: [
         IconButton(
          icon: Icon(Icons.add),
          onPressed: _showNewDogForm,
        ),
      ],
    ),
  ...
```

That will add a plus-sign looking button to the top right corner of your app, and finally you can add the method that builds a new route.

Import `new_dog_form.dart` in `main.dart`:

```dart
// main.dart

import 'package:flutter/material.dart';

import 'dog_list.dart';
import 'dog_model.dart';
import 'new_dog_form.dart';
```

Add this anywhere in your `_MyHomePageState` class:

```dart
// Any time you're pushing a new route and expect that route
// to return something back to you,
// you need to use an async function.
// In this case, the function will create a form page
// which the user can fill out and submit.
// On submission, the information in that form page
// will be passed back to this function.
Future _showNewDogForm() async {
  // push a new route like you did in the last section
  Dog newDog = await Navigator.of(context).push(
    MaterialPageRoute(
      builder: (BuildContext context) {
        return AddDogFormPage();
      },
    ),
  );
  // A null check, to make sure that the user didn't abandon the form.
  if (newDog != null) {
    // Add a newDog to our mock dog array.
    initialDoggos.add(newDog);
  }
}
```
