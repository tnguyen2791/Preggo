import 'package:flutter/material.dart';
import 'package:preggo/loginscreen/login.dart';
import 'package:preggo/presentation/screens/datacollectionform.dart';
import 'package:preggo/services/auth.dart';
import 'package:preggo/services/database.dart';
import 'package:preggo/userhome/userhome.dart';
import 'package:provider/provider.dart';
import 'package:preggo/models/user.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({Key? key}) : super(key: key);
  static const String id = 'homepage_screen';

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: AuthService().userStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            var user = snapshot.data;
            final user1 = Provider.of<UserUID>(context);
            if (user == null) {
              return const LoginScreen();
            }

            return FutureBuilder(
              future: DatabaseService(uid: user1.uid).getAgreement(),
              builder: ((context, snapshot) {
                try {
                  if (snapshot.hasData) {
                    switch (snapshot.data) {
                      case true:
                        return const UserHomeScreen();
                      case false:
                        return const DataCollectionScreen();
                      default:
                        return const DataCollectionScreen();
                    }
                  } else {
                    return const CircularProgressIndicator();
                  }
                } catch (e) {
                  print(e);
                }
                return const Center(child: Text('error'));
              }),
            );
          } else {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }
        });
  }
}