import 'package:blocs_without_libs_example/app/models/dog.dart';
import 'package:blocs_without_libs_example/screens/dog_detail_screen/dog_rates_slider.dart';
import 'package:blocs_without_libs_example/screens/dog_detail_screen/submit_rating_button.dart';
import 'package:flutter/material.dart';

class DogDetailPage extends StatelessWidget {
  final Dog dog;

  DogDetailPage(this.dog);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.black87,
      appBar: new AppBar(
        backgroundColor: Colors.black87,
        title: new Text('Meet ${dog.name}'),
      ),
      body: new ListView(
        children: <Widget>[
          _DogInfo(dog: dog),
          DogRatesSlider(),
          SubmitRatingButton(),
        ],
      ),
    );
  }
}

class _DogInfo extends StatelessWidget {
  final Dog dog;
  final double dogAvatarSize = 150.0;

  const _DogInfo({Key key, this.dog}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: new EdgeInsets.symmetric(vertical: 32.0),
      decoration: new BoxDecoration(
        gradient: new LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          stops: [0.1, 0.5, 0.7, 0.9],
          colors: [
            Colors.indigo[800],
            Colors.indigo[700],
            Colors.indigo[600],
            Colors.indigo[400],
          ],
        ),
      ),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Hero(
            tag: dog,
            child: new Container(
              height: dogAvatarSize,
              width: dogAvatarSize,
              decoration: new BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  const BoxShadow(
                      offset: const Offset(1.0, 2.0),
                      blurRadius: 2.0,
                      spreadRadius: -1.0,
                      color: const Color(0x33000000)),
                  const BoxShadow(
                      offset: const Offset(2.0, 1.0),
                      blurRadius: 3.0,
                      spreadRadius: 0.0,
                      color: const Color(0x24000000)),
                  const BoxShadow(
                      offset: const Offset(3.0, 1.0),
                      blurRadius: 4.0,
                      spreadRadius: 2.0,
                      color: const Color(0x1F000000)),
                ],
                image: new DecorationImage(
                  fit: BoxFit.cover,
                  image: new NetworkImage(dog.imageUrl ?? ''),
                ),
              ),
            ),
          ),
          new Text(
            dog.name + '  🎾',
            style: new TextStyle(fontSize: 32.0),
          ),
          new Text(
            dog.location,
            style: new TextStyle(fontSize: 20.0),
          ),
          new Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
            child: new Text(dog.description),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Icon(
                Icons.star,
                size: 40.0,
              ),
              new Text(' ${dog.rating} / 10', style: Theme.of(context).textTheme.display2),
            ],
          ),
        ],
      ),
    );
  }
}
