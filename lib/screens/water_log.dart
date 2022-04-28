import 'package:flutter/material.dart';
import 'package:preggo/components/screenBase.dart';
import 'package:preggo/components/water_droplet.dart';
import 'package:preggo/constants.dart';

class WaterLog extends StatelessWidget {
  const WaterLog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenBaseScaffold(
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
                //TODO: Change the water droplets into a gridview. https://api.flutter.dev/flutter/widgets/GridView-class.html
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
