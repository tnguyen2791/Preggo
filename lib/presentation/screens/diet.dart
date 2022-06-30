import 'package:flutter/material.dart';
import 'package:preggo/shared/shared.dart';
import 'package:preggo/constants.dart';

class Diet extends StatelessWidget {
  static const String id = 'diet_screen';

  @override
  Widget build(BuildContext context) {
    return ScreenBaseScaffold(
      titleText: "Diet",
      scaffoldBody: Column(
        children: [
          Container(
            child: Text(
              'Diet',
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
