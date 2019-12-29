import 'package:blocs_without_libs_example/app/models/dog.dart';
import 'package:flutter/material.dart';

const double _avatarSize = 100.0;

class CrossFadeDogImage extends StatelessWidget {
  final String imageUrl;
  final Dog dog;

  const CrossFadeDogImage({Key key, this.dog, this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedCrossFade(
      firstChild: Container(
        width: _avatarSize,
        height: _avatarSize,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.black54,
              Colors.black,
              Colors.blueGrey[600],
            ],
          ),
        ),
        alignment: Alignment.center,
        child: Text(
          dog.name[0],
          textAlign: TextAlign.center,
        ),
      ),
      secondChild: Hero(
        tag: dog,
        child: Container(
          width: _avatarSize,
          height: _avatarSize,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(imageUrl ?? ''),
            ),
          ),
        ),
      ),
      crossFadeState: imageUrl == null ? CrossFadeState.showFirst : CrossFadeState.showSecond,
      duration: Duration(milliseconds: 1000),
    );
  }
}
