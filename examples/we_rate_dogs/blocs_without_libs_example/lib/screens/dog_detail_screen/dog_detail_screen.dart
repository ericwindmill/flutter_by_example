import 'package:blocs_without_libs_example/app/bloc_provider.dart';
import 'package:blocs_without_libs_example/app/models/dog.dart';
import 'package:blocs_without_libs_example/screens/dog_detail_screen/dog_rates_slider.dart';
import 'package:blocs_without_libs_example/screens/dog_detail_screen/submit_rating_button.dart';
import 'package:flutter/material.dart';

const double dogAvatarSize = 150.0;

class DogDetailPage extends StatelessWidget {
  const DogDetailPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('building');
    final dogBloc = BlocProvider.of(context).dogBloc;
    dogBloc.selectedDog.listen((d) => print('selevted dog data! $d'));
    print(dogBloc.hashCode);
    return StreamBuilder<Dog>(
        stream: dogBloc.selectedDog,
        builder: (context, snapshot) {
          print(snapshot.data);
          if (!snapshot.hasData) return Text('whoa');
          return Scaffold(
            backgroundColor: Colors.black87,
            appBar: AppBar(
              backgroundColor: Colors.black87,
              title: Text('Meet ${snapshot.data.name}'),
            ),
            body: ListView(
              children: <Widget>[
                _DogInfo(dog: snapshot.data),
                DogRatesSlider(
                  rating: snapshot.data.rating,
                ),
                SubmitRatingButton(),
              ],
            ),
          );
        });
  }
}

class _DogInfo extends StatelessWidget {
  final Dog dog;

  const _DogInfo({Key key, this.dog}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 32.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Hero(
            tag: dog,
            child: Container(
              height: dogAvatarSize,
              width: dogAvatarSize,
              decoration: BoxDecoration(
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
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(dog.imageUrl ?? ''),
                ),
              ),
            ),
          ),
          Text(
            dog.name + '  🎾',
            style: TextStyle(fontSize: 32.0),
          ),
          Text(
            dog.location,
            style: TextStyle(fontSize: 20.0),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
            child: Text(dog.description),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.star,
                size: 40.0,
              ),
              Text(' ${dog.rating} / 10', style: Theme.of(context).textTheme.display2),
            ],
          ),
        ],
      ),
    );
  }
}
