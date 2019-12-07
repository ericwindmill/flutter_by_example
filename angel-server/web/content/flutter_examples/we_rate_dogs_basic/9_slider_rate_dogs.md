---
title: "Sliders and Buttons"
author: "Eric"
category: "Flutter Examples"
subSection: "Basic UI App"
tags:
    - Slider
    - RaisedButton
    - setState
---

The time has come to add the most important feature: the ability to rate to a dog.

### 1. Add the Form

Start by adding the form UI to `dog_detail_page.dart`.

This is what the page will look like:

![dog rating page](https://res.cloudinary.com/ericwindmill/image/upload/c_scale,r_5,w_300/v1521395106/flutter_by_example/Simulator_Screen_Shot_-_iPhone_X_-_2018-03-18_at_10.44.53.png)

The interface will consist of two main widgets:
  1. a `Slider` to change the rating.
  2. a `RaisedButton` to submit the slider value.

Add them both to the `_DogDetailPageState`:

```dart
// dog_detail_page.dart

class _DogDetailPageState extends State<DogDetailPage> {
  final double dogAvatarSize = 150.0;
  // This is the starting value of the slider.
  double _sliderValue = 10.0;

  // ...

  Widget get addYourRating {
    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.symmetric(
            vertical: 16.0,
            horizontal: 16.0,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              // In a row, column, listview, etc., a Flexible widget is a wrapper
              // that works much like CSS's flex-grow property.
              //
              // Any room left over in the main axis after
              // the widgets are given their width
              // will be distributed to all the flexible widgets
              // at a ratio based on the flex property you pass in.
              // Because this is the only Flexible widget,
              // it will take up all the extra space.
              //
              // In other words, it will expand as much as it can until
              // the all the space is taken up.
              Flexible(
                flex: 1,
                // A slider, like many form elements, needs to know its
                // own value and how to update that value.
                //
                // The slider will call onChanged whenever the value
                // changes. But it will only repaint when its value property
                // changes in the state using setState.
                //
                // The workflow is:
                // 1. User drags the slider.
                // 2. onChanged is called.
                // 3. The callback in onChanged sets the sliderValue state.
                // 4. Flutter repaints everything that relies on sliderValue,
                // in this case, just the slider at its new value.
                child: Slider(
                  activeColor: Colors.indigoAccent,
                  min: 0.0,
                  max: 15.0,
                  onChanged: (newRating) {
                    setState(() => _sliderValue = newRating);
                  },
                  value: _sliderValue,
                ),
              ),

              // This is the part that displays the value of the slider.
              Container(
                width: 50.0,
                alignment: Alignment.center,
                child: Text('${_sliderValue.toInt()}',
                    style: Theme.of(context).textTheme.display1),
              ),
            ],
          ),
        ),
        submitRatingButton,
      ],
    );
  }

  // A simple Raised Button that as of now doesn't do anything yet.
  Widget get submitRatingButton {
    return RaisedButton(
      onPressed: () => print('pressed!'),
      child: Text('Submit'),
      color: Colors.indigoAccent,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: Text('Meet ${widget.dog.name}'),
      ),
      // Make the body a ListView that displays
      // both the profile and the rating form.
      body: ListView(
        children: <Widget>[dogProfile, addYourRating],
      ),
    );
  }
}
```

If you hot reload your app, you should have a working slider.

### 2. Wire up the Submit button

The `submitRatingButton` does what could *technically*  be done in the `Slider` `onChanged` callback.

It updates the rating in the dog class itself. That way, throughout the app the new rating is shown, because Flutter will rebuild *everything* that includes the Dog's rating.

This is as simple as adding this function to your `_DogDetailPageState` class, and then calling it when the submit button is pressed:

```dart
// dog_detail_page.dart

// In the next section you'll add error handling.
// For now this is all it does.
void updateRating() {
  setState(() => widget.dog.rating = _sliderValue.toInt());
}
```

And then in your `submitRatingButton` widget:

```dart
// dog_detail_page.dart

Widget get submitRatingButton {
  return RaisedButton(
    onPressed: updateRating,
    child: Text('Submit'),
    color: Colors.indigoAccent,
  );
}
```

After adding this, you can move the slider, press submit, and then travel back to the main page. You should see the dog's rating updated.
