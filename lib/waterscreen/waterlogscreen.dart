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
            margin: const EdgeInsets.all(8.0),
            child: Text(
              'How much water should I be drinking?',
              textAlign: TextAlign.center,
              style: kGoogleTitle,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'You should be drinking at least 64 ounces of water every day! That is eight 8-oz glasses of water per day.',
              textAlign: TextAlign.center,
              style: kGoogleDescription,
            ),
          ),
          const SizedBox(
            height: 10.0,
          ),
          const WaterCounter(),
          Image(
              image: const AssetImage('assets/png/kidsgroup.png'),
              height: MediaQuery.of(context).size.height * 0.25,
              fit: BoxFit.fitWidth),
        ],
      ),
    );
  }
}
