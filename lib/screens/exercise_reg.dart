import 'package:flutter/material.dart';
import 'package:preggo/components/screenBase.dart';
import 'package:preggo/constants.dart';

class ExerciseRegimen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenBaseScaffold(
      titleText: "Exercise",
      scaffoldBody: Column(
        children: [
          Container(
            child: Text(
              'Exercise Regimen',
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
