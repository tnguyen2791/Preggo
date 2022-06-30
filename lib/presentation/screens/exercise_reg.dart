import 'package:flutter/material.dart';
import 'package:preggo/shared/shared.dart';
import 'package:preggo/constants.dart';

class ExerciseRegimen extends StatelessWidget {
static const String id = 'exercise_screen';

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