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
          ),
          Container(
            child: Text(
              'You should be drinking at least 64 ounces of water every day! That is eight 8-oz glasses of water per day.',
              style: kGoogleDescription,
            ),
          ),
          WaterContainer(),
        ],
      ),
    );
  }
}

class WaterContainer extends StatefulWidget {
  const WaterContainer({Key? key}) : super(key: key);

  @override
  State<WaterContainer> createState() => _WaterContainerState();
}

class _WaterContainerState extends State<WaterContainer> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: const [
            WaterDroplet(),
            WaterDroplet(),
            WaterDroplet(),
            WaterDroplet(),
          ],
        ),
        Row(
          children: const [
            WaterDroplet(),
            WaterDroplet(),
            WaterDroplet(),
            WaterDroplet(),
          ],
        ),
      ],
    );
  }
}
