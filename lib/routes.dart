import 'package:preggo/login/login.dart';
import 'package:preggo/presentation/screens/all_screens.dart';
import 'package:preggo/presentation/screens/datacollectionform.dart';
import 'package:preggo/presentation/screens/sign_up_screen.dart';
import 'package:preggo/userhome/userhome.dart';

var appRoutes = {
  Wrapper.id: (context) => Wrapper(),
  UserHomeScreen.id: (context) => UserHomeScreen(),
  Diet.id: (context) => Diet(),
  ExerciseRegimen.id: (context) => ExerciseRegimen(),
  GrowthChart.id: (context) => GrowthChart(),
  Resources.id: (context) => Resources(),
  Settings.id: (context) => Settings(),
  WaterLog.id: (context) => WaterLog(),
  LoginScreen.id: (context) => LoginScreen(),
  Settings.id: (context) => Settings(),
  DataCollectionScreen.id: (context) => DataCollectionScreen(),
  SignUpScreen.id: (context) => SignUpScreen(),
};
