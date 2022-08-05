import 'package:flutter/material.dart';
import 'package:preggo/loginscreen/login.dart';
import 'package:preggo/presentation/settings/datacollectionform.dart';
import 'package:preggo/presentation/screens/loading_screen.dart';
import 'package:preggo/services/auth.dart';
import 'package:preggo/services/database.dart';
import 'package:preggo/userhome/userhome.dart';
import 'package:provider/provider.dart';
import 'package:preggo/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({Key? key}) : super(key: key);
  static const String id = 'homepage_screen';

  @override
  State<Wrapper> createState() => _WrapperState();
}
class _WrapperState extends State<Wrapper> {
  final fbuser = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    final userprovider = Provider.of<UserUID>(context);
    final userData = Provider.of<UserData>(context);
    DatabaseService(uid: userprovider.uid).checkDatabaseStartup();

    return StreamBuilder<User?>(
        stream: AuthService().userStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            var user = snapshot.data;
            if (user == null) {
              return const LoginScreen();
            } else {
              if (userData.agreement == true) {
                return const UserHomeScreen();
              } else {
                return const DataCollectionScreen();
              }
            }
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingScreen();
          }

          if (snapshot.connectionState == ConnectionState.none) {
            return const Scaffold(
                body: Center(
                    child: Text('You do not have an internet connection')));
          }
          return const LoginScreen();
        });
  }
}
