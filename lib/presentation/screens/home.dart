import 'package:flutter/material.dart';
import 'package:preggo/login/login.dart';
import 'package:preggo/services/auth.dart';
import 'package:preggo/userhome/userhome.dart';
import 'all_screens.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:preggo/shared/shared.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  static const String id = 'homepage_screen';

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: AuthService().userStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return const Center(
            child: Text('There was an error'),
          );
        } else if (snapshot.hasData) {
          return const UserHomeScreen();
        } else {
          return const LoginScreen();
        }
      },
    );
  }
}
