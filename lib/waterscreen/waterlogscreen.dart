import 'package:flutter/material.dart';
import 'package:preggo/shared/shared.dart';
import 'package:preggo/shared/constants.dart';

class WaterLog extends StatelessWidget {
  const WaterLog({Key? key}) : super(key: key);

  static const String id = 'water_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Water Log'),
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(15.0),
            child: Text(
              'Water Tracker',
              style: kGoogleTitle,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              'You should be drinking at least 64 ounces of water every day! That is eight 8-oz glasses of water per day.',
              style: kGoogleDescription,
            ),
          ),
          const SizedBox(
            height: 25.0,
          ),
          const WaterCounter(),
        ],
      ),
    );
  }
}
