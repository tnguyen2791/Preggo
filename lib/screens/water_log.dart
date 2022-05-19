import 'package:flutter/material.dart';
import 'package:preggo/components/screenBase.dart';
import 'package:preggo/components/water_droplets.dart';
import 'package:preggo/constants.dart';

class WaterLog extends StatelessWidget {
  const WaterLog({Key? key}) : super(key: key);

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
            margin: const EdgeInsets.all(20.0),
          ),
          const SizedBox(
            height: 30.0,
          ),
          WaterCounter(),
        ],
      ),
    );
  }
}
