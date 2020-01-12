import 'package:aqueduct/aqueduct.dart';

class AppConfig extends Configuration {
  AppConfig(String fileName) : super.fromString(fileName);
}