import 'package:blocs_without_libs_example/app/models/dog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DogRatesSlider extends StatefulWidget {
  final int rating;

  const DogRatesSlider({Key key, this.rating}) : super(key: key);

  @override
  _DogRatesSliderState createState() => _DogRatesSliderState(rating);
}

class _DogRatesSliderState extends State<DogRatesSlider> {
  int _rating;

  _DogRatesSliderState(this._rating);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        new Container(
          padding: new EdgeInsets.symmetric(
            vertical: 16.0,
            horizontal: 16.0,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              new Flexible(
                flex: 1,
                child: Slider(
                  activeColor: Colors.indigoAccent,
                  min: 0.0,
                  max: 15.0,
                  onChanged: (newRating) {
                    setState(() {
                      _rating = newRating.toInt();
                    });
                  },
                  value: _rating.toDouble(),
                ),
              ),
              new Container(
                width: 50.0,
                alignment: Alignment.center,
                child: new Text(
                  '$_rating',
                  style: Theme.of(context).textTheme.display1,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
