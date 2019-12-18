import 'package:flutter/material.dart';

class SubmitRatingButton extends StatelessWidget {
//  void updateRating() {
//    if (_sliderValue < 10) {
//      widget.onSliderError();
//    } else {
//      setState(widget.onSliderError);
//    }
//  }

  Future<Null> _ratingErrorDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) => new AlertDialog(
        title: new Text('Error!'),
        content: new Text("They're good dogs, Brant."),
        actions: [
          new FlatButton(
            child: new Text('Try Again'),
            onPressed: () => Navigator.of(context).pop(),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: () => print('update rating'),
      child: new Text('Submit'),
      color: Colors.indigoAccent,
    );
  }
}
