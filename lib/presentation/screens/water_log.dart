import 'package:flutter/material.dart';
import 'package:preggo/shared/shared.dart';
import 'package:preggo/constants.dart';

class WaterLog extends StatelessWidget {
  WaterLog({Key? key}) : super(key: key);

  static const String id = 'water_screen';

  @override
  Widget build(BuildContext context) {
    return ScreenBaseScaffold(
      titleText: "Water Log",
      scaffoldBody: Column(
        children: [
          Container(
            child: Text(
              'Water Tracker',
              style: kGoogleTitle,
            ),
            margin: EdgeInsets.all(15.0),
          ),
          Container(
            child: Text(
              'You should be drinking at least 64 ounces of water every day! That is eight 8-oz glasses of water per day.',
              style: kGoogleDescription,
            ),
          ),
          const SizedBox(
            height: 25.0,
          ),
          WaterCounter(),
        ],
      ),
    );
  }
}
