import 'package:flutter/material.dart';
import 'package:preggo/login/login.dart';
import 'package:preggo/routes.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'presentation/screens/introduction.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(PreggoApp());
}

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
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.pink,
        scaffoldBackgroundColor: const Color(0xFF7209B7),
      ),
      title: 'Pregnancy Weights',
      initialRoute: LoginScreen.id,
      routes: appRoutes,
    );
  }
}
