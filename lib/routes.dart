import 'package:flutter/material.dart';
import 'package:preggo/login/login.dart';
import 'package:preggo/presentation/screens/all_screens.dart';

var appRoutes = {
  HomeScreen.id: (context) => HomeScreen(),
  Diet.id: (context) => Diet(),
  ExerciseRegimen.id: (context) => ExerciseRegimen(),
  GrowthChart.id: (context) => GrowthChart(),
  Resources.id: (context) => Resources(),
  Settings.id: (context) => Settings(),
  WaterLog.id: (context) => WaterLog(),
  WeighIn.id: (context) => WeighIn(),
  LoginScreen.id: (context) => LoginScreen(),
};