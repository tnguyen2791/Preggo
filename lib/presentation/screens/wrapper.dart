import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:preggo/login/login.dart';
import 'package:preggo/presentation/screens/datacollectionform.dart';
import 'package:preggo/services/auth.dart';
import 'package:preggo/services/database.dart';
import 'package:preggo/userhome/userhome.dart';
import 'package:provider/provider.dart';
import 'package:preggo/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Wrapper extends StatefulWidget {
  Wrapper({Key? key}) : super(key: key);
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
                        return DataCollectionScreen();
                      default:
                        return DataCollectionScreen();
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

//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder(
//       stream: AuthService().userStream,
//       builder: (context, snapshot1) {
//         final user1 = Provider.of<UserUID>(context);
//         return StreamBuilder(
//             stream: DatabaseService(uid: user1.uid).userData,
//             builder: (context, snapshot2) {
//               if (snapshot2.connectionState == ConnectionState.active){
//                 var snap2 = snapshot2.data;
                
//               }

//               var snap1 = snapshot1.data;
              
//             });
//       },
//     );
//   }
// }