import 'package:flutter/material.dart';
import 'package:preggo/components/screenBase.dart';
import 'package:preggo/constants.dart';

class Diet extends StatelessWidget {
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
