import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mobile_app/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final FirebaseApp app = await FirebaseApp.configure(
    name: 'recurring-todos',
    options: const FirebaseOptions(
      googleAppID: '1:815691565827:ios:b9e6c8f7dc8c1c4d8ff736',
      apiKey: 'AIzaSyAbJIsRH0U3GnnPcxLfCxqz7ZCB0ASL01A',
      projectID: 'recurring-todos',
    ),
  );
  final Firestore firestore = Firestore(app: app);

  runApp(App());
}
