import 'package:preggo/growthscreen/growthemail.dart';
import 'package:preggo/loginscreen/login.dart';
import 'package:preggo/presentation/screens/all_screens.dart';
import 'package:preggo/presentation/screens/datacollectionform.dart';
import 'package:preggo/presentation/screens/sign_up_screen.dart';
import 'package:preggo/userhome/userhome.dart';

var appRoutes = {
  Wrapper.id: (context) => const Wrapper(),
  UserHomeScreen.id: (context) => const UserHomeScreen(),
  Diet.id: (context) => const Diet(),
  ExerciseRegimen.id: (context) => const ExerciseRegimen(),
  GrowthChart.id: (context) => const GrowthChart(),
  Resources.id: (context) => const Resources(),
  Settings.id: (context) => const Settings(),
  WaterLog.id: (context) => WaterLog(),
  LoginScreen.id: (context) => const LoginScreen(),
  Settings.id: (context) => const Settings(),
  DataCollectionScreen.id: (context) => const DataCollectionScreen(),
  SignUpScreen.id: (context) => const SignUpScreen(),
  EmailSender.id: (context) => const EmailSender(),
};
