import 'package:flutter/material.dart';
import 'package:ipod_classic/theme.dart';

class IPodClassicApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (BuildContext context, Widget screen) {
        return SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: AppTheme.additionalVerticalSafeArea(context),
            ),
            child: screen,
          ),
        );
      },
      home: Screen(),
    );
  }
}

class Screen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.appColor,
      body: Padding(
        padding: EdgeInsets.all(
          AppTheme.appPadding(context),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Display(),
              ClickWheel(),
            ],
          ),
        ),
      ),
    );
  }
}

class Display extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppTheme.displayWidth(context),
      height: AppTheme.displayHeight(context),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(AppTheme.displayBorderRadiusValue(context)),
        ),
      ),
      child: Center(
        child: Text("display"),
      ),
    );
  }
}

class ClickWheel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: <Widget>[
          OuterClickWheel(),
          Positioned(
            child: InnerClickWheel(),
            width: AppTheme.clickWheelWidth(context),
            top: AppTheme.clickWheelWidth(context) / 2 - AppTheme.innerCircleSize(context) / 2,
          ),
        ],
      ),
    );
  }
}

class OuterClickWheel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragStart: (DragStartDetails details) {
        print(details.globalPosition);
      },
      child: Container(
        width: AppTheme.clickWheelWidth(context),
        height: AppTheme.clickWheelWidth(context),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppTheme.clickWheelColor,
        ),
      ),
    );
  }
}

class InnerClickWheel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print('tap');
      },
      child: Container(
        width: AppTheme.innerCircleSize(context),
        height: AppTheme.innerCircleSize(context),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.grey[900],
        ),
      ),
    );
  }
}
