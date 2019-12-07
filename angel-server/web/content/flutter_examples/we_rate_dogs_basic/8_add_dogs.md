---
title: "User Input"
author: "Eric"
category: "Flutter Examples"
subSection: "Basic App"
tags:
    - TextEditingController
    - TextField
    - RaisedButton
---

Adding functionality to your `AddDogForm` is a pretty easy feat.

Essentially, you need to add a couple built in Flutter classes that keep track of form input, and a function that returns the data to the main page through the router.

### 1. TextEditingController class

There are a couple ways to go about tracking text input form elements. You can use `Form` widgets, or you can track each text input separately.

In this example, I will show you how to do the latter. `TextEditingController` is an important and fundamental thing in Flutter.

A `TextEditingController` is basically a class that listens to its assigned `TextField`, and updates it's own internal state every time the text in the `TextField` changes.

In your `_AddDogFormPageState` class, add a `controller` and `onChanged` property to each `TextField`:

```dart
// new_dog_form.dart

class _AddDogFormPageState extends State<AddDogFormPage> {
  // One TextEditingController for each form input:
  TextEditingController nameController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
                child: TextField(
                    // Tell your textfield which controller it owns
                    controller: nameController,
                    // Every single time the text changes in a
                    // TextField, this onChanged callback is called
                    // and it passes in the value.
                    //
                    // Set the text of your controller to
                    // to the next value.
                    onChanged: (v) => nameController.text = v,
                    decoration: InputDecoration(
                      labelText: 'Name the Pup',
                    )),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: TextField(
                    controller: locationController,
                    onChanged: (v) => locationController.text = v,
                    decoration: InputDecoration(
                      labelText: "Pups location",
                    )),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: TextField(
                    controller: descriptionController,
                    onChanged: (v) => descriptionController.text = v,
                    decoration: InputDecoration(
                      labelText: 'All about the pup',
                    )),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Builder(
                  builder: (context) {
                    return RaisedButton(
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

Now, even though it doesn't look like anything new is happening, the `TextEditingControllers` are keeping track of your form.

### 2. Submit The Form

Import `dog_model.dart` into `new_dog_form.dart`:

```dart
// new_dog_form.dart

import 'package:flutter/material.dart';

import 'dog_model.dart';
```

In the same `_AddDogFormPageState` class, add the `submitPup` function, which will pass the form information back via the `Navigator`:

```dart
// new_dog_form.dart

// You'll need the context in order for the Navigator to work.
void submitPup(BuildContext context) {
  // First make sure there is some information in the form.
  // A dog needs a name, but may be location independent,
  // so we'll only abandon the save if there's no name.
  if (nameController.text.isEmpty) {
    print('Dogs need names!');
  } else {
    // Create a new dog with the information from the form.
    var newDog = Dog(nameController.text, locationController.text,
        descriptionController.text);
    // Pop the page off the route stack and pass the new
    // dog back to wherever this page was created.
    Navigator.of(context).pop(newDog);
  }
}
```

And lastly, add `submitPup` to your 'RaisedButton' `onPressed` callback:

```dart
// new_dog_form.dart

builder: (BuildContext context) {
  return RaisedButton(
    onPressed: () => submitPup(context),
    color: Colors.indigoAccent,
    child: Text('Submit Pup'),
  );
},
```

And that's that. Now, you should be able to submit a new dog and see it on your main page!
