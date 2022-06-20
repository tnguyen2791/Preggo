import 'package:flutter/material.dart';
import 'package:preggo/presentation/router/app_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'presentation/screens/introduction.dart';

void main() => runApp(PreggoApp());

class PreggoApp extends StatelessWidget {
  Future<bool?> _getBoolFromSharedPref() async {
    final prefs = await SharedPreferences.getInstance();
    final disclaimerCheck = prefs.getBool('agreeDisclaimer');
    if (disclaimerCheck == null) {
      return false;
    } else {
      return disclaimerCheck;
    }
  }

  @override
  Widget build(BuildContext context) {
    final AppRouter _appRouter = AppRouter();

    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.pink,
        scaffoldBackgroundColor: const Color(0xFF7209B7),
      ),
      title: 'Pregnancy Weights',
      initialRoute: OnBoardingPage.id,
      //(_getBoolFromSharedPref() == false) ? OnBoardingPage.id : Homepage.id,
      onGenerateRoute: _appRouter.onGenerateRoute,
    );
  }
}
