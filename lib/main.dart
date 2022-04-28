import 'package:flutter/material.dart';
import 'package:preggo/screens/diet.dart';
import 'package:preggo/screens/exercise_reg.dart';
import 'package:preggo/screens/growth_chart.dart';
import 'package:preggo/screens/resources.dart';
import 'package:preggo/screens/weigh_in.dart';
import 'screens/home.dart';
import 'screens/water_log.dart';

void main() => runApp(PreggoApp());

class PreggoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      title: 'Pregnancy Weights',
      initialRoute: '/',
      routes: {
        '/': (context) => Homepage(),
        '/WaterLog': (context) => const WaterLog(),
        '/GrowthChart': (context) => GrowthChart(),
        '/WeighIn': (context) => WeighIn(),
        '/Resources': (context) => Resources(),
        '/ExerciseRegimen': (context) => ExerciseRegimen(),
        '/Diet': (context) => Diet(),
      },
    );
  }
}
