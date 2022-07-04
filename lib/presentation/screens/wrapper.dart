import 'package:flutter/material.dart';
import 'package:preggo/login/login.dart';
import 'package:preggo/services/auth.dart';
import 'package:preggo/services/database.dart';
import 'package:preggo/userhome/userhome.dart';
import 'package:provider/provider.dart';
import 'package:preggo/models/user.dart';

class Wrapper extends StatelessWidget {
  Wrapper({Key? key}) : super(key: key);
  static const String id = 'homepage_screen';

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: AuthService().userStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            var user = snapshot.data;
            if (user == null) {
              return const LoginScreen();
            }
            return const UserHomeScreen();
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