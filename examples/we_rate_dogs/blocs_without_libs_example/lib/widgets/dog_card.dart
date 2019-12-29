import 'package:blocs_without_libs_example/app/bloc_provider.dart';
import 'package:blocs_without_libs_example/app/models/dog.dart';
import 'package:blocs_without_libs_example/screens/dog_detail_screen/dog_detail_screen.dart';
import 'package:blocs_without_libs_example/widgets/cross_fade_dog_image.dart';
import 'package:flutter/material.dart';

class DogCard extends StatelessWidget {
  final Dog dog;

  DogCard(this.dog);

  @override
  Widget build(BuildContext context) {
    return InkWell(
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
                child: Container(
                  width: 290.0,
                  height: 115.0,
                  child: Card(
                    color: Colors.black87,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: 8.0,
                        bottom: 8.0,
                        left: 64.0,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Text(
                            dog.name,
                            style: Theme.of(context).textTheme.headline,
                          ),
                          Text(
                            dog.location,
                            style: Theme.of(context).textTheme.subhead,
                          ),
                          Row(
                            children: <Widget>[
                              Icon(
                                Icons.star,
                              ),
                              Text(': ${dog.rating} / 10')
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 7.5,
                child: CrossFadeDogImage(
                  dog: dog,
                  imageUrl: dog.imageUrl,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  showDogDetailPage(BuildContext context) {
    print('selected dog: ${dog.name}');
    final bloc = BlocProvider.of(context).dogBloc;
    bloc.selectDog(dog);
    print(bloc.hashCode);

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return DogDetailPage();
        },
      ),
    );
  }
}
