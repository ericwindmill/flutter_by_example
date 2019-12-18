import 'package:blocs_without_libs_example/app/models/dog.dart';
import 'package:blocs_without_libs_example/screens/dog_detail_screen/dog_detail_screen.dart';
import 'package:flutter/material.dart';

class DogCard extends StatelessWidget {
  final Dog dog;

  DogCard(this.dog);

  Widget get dogImage {
    var dogAvatar = new Hero(
      tag: dog,
      child: new Container(
        width: 100.0,
        height: 100.0,
        decoration: new BoxDecoration(
          shape: BoxShape.circle,
          image: new DecorationImage(
            fit: BoxFit.cover,
            image: new NetworkImage(dog.imageUrl), // todo
          ),
        ),
      ),
    );

    var placeholder = new Container(
      width: 100.0,
      height: 100.0,
      decoration: new BoxDecoration(
        shape: BoxShape.circle,
        gradient: new LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.black54, Colors.black, Colors.blueGrey[600]],
        ),
      ),
      alignment: Alignment.center,
      child: new Text(
        'DOGGO',
        textAlign: TextAlign.center,
      ),
    );

    var crossFade = new AnimatedCrossFade(
      firstChild: placeholder,
      secondChild: dogAvatar,
      crossFadeState: dog.imageUrl == null ? CrossFadeState.showFirst : CrossFadeState.showSecond,
      duration: new Duration(milliseconds: 1000),
    );

    return crossFade;
  }

  @override
  Widget build(BuildContext context) {
    return new InkWell(
      onTap: () => showDogDetailPage(context),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 8.0,
        ),
        child: Container(
          height: 115.0,
          child: Stack(
            children: <Widget>[
              Positioned(
                right: 0.0,
                child: new Container(
                  width: 290.0,
                  height: 115.0,
                  child: new Card(
                    color: Colors.black87,
                    child: new Padding(
                      padding: const EdgeInsets.only(
                        top: 8.0,
                        bottom: 8.0,
                        left: 64.0,
                      ),
                      child: new Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          new Text(
                            dog.name,
                            style: Theme.of(context).textTheme.headline,
                          ),
                          new Text(
                            dog.location,
                            style: Theme.of(context).textTheme.subhead,
                          ),
                          new Row(
                            children: <Widget>[
                              new Icon(
                                Icons.star,
                              ),
                              new Text(': ${dog.rating} / 10')
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              new Positioned(
                top: 7.5,
                child: dogImage,
              ),
            ],
          ),
        ),
      ),
    );
  }

  showDogDetailPage(BuildContext context) {
    Navigator.of(context).push(new MaterialPageRoute(
      builder: (context) {
        return DogDetailPage(dog);
      },
    ));
  }
}
