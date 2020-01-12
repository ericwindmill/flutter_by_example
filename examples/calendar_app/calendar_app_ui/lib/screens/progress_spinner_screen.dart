import 'package:calandar_app_ui/screens/screen_container.dart';
import 'package:flutter/material.dart';

class ProgressSpinnerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenContainer(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
