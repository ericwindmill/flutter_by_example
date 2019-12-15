import 'package:flutter/material.dart';

class AppTheme {
  static double additionalVerticalSafeArea(BuildContext context) => 90.0;
  static double appPadding(BuildContext context) => MediaQuery.of(context).size.width * .05;
  static Color appColor = Colors.grey[900];
  static double clickWheelWidth(BuildContext context) => MediaQuery.of(context).size.width * .7;
  static Color clickWheelColor = Colors.grey[700];
  static double displayBorderRadiusValue(BuildContext context) => 6.0;
  static double displayHeight(BuildContext context) => MediaQuery.of(context).size.width * .65;
  static double displayWidth(BuildContext context) => MediaQuery.of(context).size.width * .85;
  static double innerCircleSize(BuildContext context) => MediaQuery.of(context).size.width * .3;
}
