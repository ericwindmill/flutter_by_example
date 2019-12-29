import 'package:blocs_without_libs_example/app/bloc_provider.dart';
import 'package:blocs_without_libs_example/app/models/dog.dart';
import 'package:flutter/material.dart';

class SubmitRatingButton extends StatelessWidget {
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
    final bloc = BlocProvider.of(context).ratingBloc;
    final dogBloc = BlocProvider.of(context).dogBloc;
    return StreamBuilder<Dog>(
      stream: dogBloc.selectedDog,
      builder: (context, snapshot) {
        return RaisedButton(
          onPressed: () {
            if (true) {
              _ratingErrorDialog(context);
            } else {
              bloc.updateDog(snapshot.data);
            }
          },
          child: new Text('Submit'),
          color: Colors.indigoAccent,
        );
      }
    );
  }
}
