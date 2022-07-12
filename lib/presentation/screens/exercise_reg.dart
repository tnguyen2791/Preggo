import 'package:flutter/material.dart';
import 'package:preggo/shared/constants.dart';

class ExerciseRegimen extends StatelessWidget {
  static const String id = 'exercise_screen';

  const ExerciseRegimen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Exercise"),
      ),
      body: Column(
        children: [
          Text(
            'Exercise Regimen',
            style: kGoogleTitle,
          ),
          Text(
            'Description',
            style: kGoogleDescription,
          ),
          Center(
            child: Image.network(
              'https://www.ambitiouskitchen.com/wp-content/uploads/2019/11/pregnancyqa-pin.jpg',
              height: MediaQuery.of(context).size.height * 0.75,
            ),
          ),
        ],
      ),
    );
  }
}
