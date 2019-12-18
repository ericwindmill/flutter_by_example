import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DogRatesSlider extends StatefulWidget {
  final Function onSliderChange;
  final Function onSliderError;

  const DogRatesSlider({Key key, this.onSliderError, this.onSliderChange}) : super(key: key);

  @override
  _DogRatesSliderState createState() => _DogRatesSliderState();
}

class _DogRatesSliderState extends State<DogRatesSlider> {
  double _sliderValue = 10.0;

  void updateSlider(double newRating) {
    setState(() => _sliderValue = newRating);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        new Container(
          padding: new EdgeInsets.symmetric(
            vertical: 16.0,
            horizontal: 16.0,
          ),
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              new Flexible(
                flex: 1,
                child: new Slider(
                  activeColor: Colors.indigoAccent,
                  min: 0.0,
                  max: 15.0,
                  onChanged: (newRating) => updateSlider(newRating),
                  value: _sliderValue,
                ),
              ),
              new Container(
                width: 50.0,
                alignment: Alignment.center,
                child: new Text('${_sliderValue.toInt()}',
                    style: Theme.of(context).textTheme.display1),
              ),
            ],
          ),
        )
      ],
    );
  }
}
