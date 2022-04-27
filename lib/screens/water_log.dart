import 'package:flutter/material.dart';
import 'package:preggo/components/base.dart';
import 'package:preggo/components/water_droplet.dart';
import 'package:preggo/constants.dart';

class weighin extends StatelessWidget {
  const weighin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
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
            margin: EdgeInsets.all(20.0),
          ),
          SizedBox(
            height: 15.0,
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    WaterDroplet(),
                    WaterDroplet(),
                    WaterDroplet(),
                    WaterDroplet(),
                  ],
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    WaterDroplet(),
                    WaterDroplet(),
                    WaterDroplet(),
                    WaterDroplet(),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
