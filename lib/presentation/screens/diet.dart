import 'package:flutter/material.dart';
import 'package:preggo/shared/constants.dart';

class Diet extends StatelessWidget {
  static const String id = 'diet_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Diet [Placeholder]'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Diet',
            style: kGoogleTitle,
          ),
          Text(
            'Description',
            style: kGoogleDescription,
          ),
          Expanded(
            child: Container(
              child: Image.network(
                  'https://femina.wwmindia.com/content/2020/jul/pregnancy-diet-chart-infographic.jpg'),
            ),
          ),
        ],
      ),
    );
  }
}
