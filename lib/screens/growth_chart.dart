import 'package:flutter/material.dart';
import 'package:preggo/components/screenBase.dart';
import 'package:preggo/constants.dart';

class GrowthChart extends StatelessWidget {
  //TODO: Creation of charts can be done with https://pub.dev/packages/syncfusion_flutter_charts
  //TODO: Learn how to create data containers for this
  //TODO: A stacked chart is what you're looking for.

  static const String id = 'growth_screen';

  @override
  Widget build(BuildContext context) {
    return ScreenBaseScaffold(
      titleText: "Growth Chart",
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
