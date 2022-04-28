import 'package:flutter/material.dart';
import 'package:preggo/components/screenBase.dart';
import 'package:preggo/constants.dart';

class GrowthChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenBaseScaffold(
      scaffoldBody: Column(
        children: [
          Container(
            child: Text(
              'Growth Chart',
              style: kGoogleTitle,
            ),
          ),
          Container(
            child: Text(
              'Description',
              style: kGoogleDescription,
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.red,
            ),
          ),
        ],
      ),
    );
  }
}
