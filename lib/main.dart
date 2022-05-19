import 'package:flutter/material.dart';
import 'package:preggo/screens/diet.dart';
import 'package:preggo/screens/exercise_reg.dart';
import 'package:preggo/screens/growth_chart.dart';
import 'package:preggo/screens/resources.dart';
import 'package:preggo/screens/settings.dart';
import 'package:preggo/screens/weigh_in.dart';
import 'screens/home.dart';
import 'screens/water_log.dart';

void main() => runApp(PreggoApp());

//TODO Consider putting in a SafeArea widget https://api.flutter.dev/flutter/widgets/SafeArea-class.html

class PreggoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.pink,
        scaffoldBackgroundColor: const Color(0xFF7209B7),
      ),
      title: 'Pregnancy Weights',
      initialRoute: Homepage.id,
      routes: {
        Homepage.id: (context) => Homepage(),
        WaterLog.id: (context) => WaterLog(),
        GrowthChart.id: (context) => GrowthChart(),
        WeighIn.id: (context) => WeighIn(),
        Resources.id: (context) => Resources(),
        ExerciseRegimen.id: (context) => ExerciseRegimen(),
        Diet.id: (context) => Diet(),
        Settings.id: (context) => Settings()
      },
    );
  }
}
