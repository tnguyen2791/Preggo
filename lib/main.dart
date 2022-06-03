import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:preggo/screens/diet.dart';
import 'package:preggo/screens/eatingdisorderinfo.dart';
import 'package:preggo/screens/exercise_reg.dart';
import 'package:preggo/screens/growth_chart.dart';
import 'package:preggo/screens/introduction.dart';
import 'package:preggo/screens/resources.dart';
import 'package:preggo/screens/settings.dart';
import 'package:preggo/screens/weigh_in.dart';
import 'screens/home.dart';
import 'screens/water_log.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(PreggoApp());

//TODO Consider putting in a SafeArea widget https://api.flutter.dev/flutter/widgets/SafeArea-class.html

class PreggoApp extends StatelessWidget {
  Future<bool?> _getBoolFromSharedPref() async {
    final prefs = await SharedPreferences.getInstance();
    final disclaimerCheck = prefs.getBool('agreeDisclaimer');
    if (disclaimerCheck == null) {
      return false;
    }
    return disclaimerCheck;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.pink,
        scaffoldBackgroundColor: const Color(0xFF7209B7),
      ),
      title: 'Pregnancy Weights',
      initialRoute:
          (_getBoolFromSharedPref() == false) ? OnBoardingPage.id : Homepage.id,
      routes: {
        Homepage.id: (context) => Homepage(),
        OnBoardingPage.id: (context) => OnBoardingPage(),
        WaterLog.id: (context) => WaterLog(),
        GrowthChart.id: (context) => GrowthChart(),
        WeighIn.id: (context) => WeighIn(),
        Resources.id: (context) => Resources(),
        ExerciseRegimen.id: (context) => ExerciseRegimen(),
        Diet.id: (context) => Diet(),
        Settings.id: (context) => Settings(),
        WeighInOptions.id: (context) => WeighInOptions(),
      },
    );
  }
}
