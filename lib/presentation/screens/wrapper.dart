import 'package:flutter/material.dart';
import 'package:preggo/loginscreen/login.dart';
import 'package:preggo/presentation/screens/datacollectionform.dart';
import 'package:preggo/presentation/screens/loading_screen.dart';
import 'package:preggo/services/auth.dart';
import 'package:preggo/services/database.dart';
import 'package:preggo/userhome/userhome.dart';
import 'package:provider/provider.dart';
import 'package:preggo/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({Key? key}) : super(key: key);
  static const String id = 'homepage_screen';

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  final fbuser = FirebaseAuth.instance.currentUser;
  final bool signUp = false;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: AuthService().userStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            var user = snapshot.data;
            if (user == null) {
              return const LoginScreen();
            } else {
              return FutureBuilder(
                future: DatabaseService(uid: fbuser?.uid).getAgreement(),
                builder: ((context, snapshot) {
                  try {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const LoadingScreen();
                    }
                    if (snapshot.hasData) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        switch (snapshot.data) {
                          case true:
                            return const UserHomeScreen();
                          case false:
                            return const DataCollectionScreen();
                          default:
                            return const DataCollectionScreen();
                        }
                      }
                    }
                  } catch (e) {
                    print(e);
                  }
                  return const Center(child: Text('error'));
                }),
              );
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
          return const LoadingScreen();
        });
  }
}
