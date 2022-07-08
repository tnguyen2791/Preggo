import 'package:flutter/material.dart';
import 'package:preggo/models/user.dart';
import 'package:preggo/presentation/screens/wrapper.dart';
import 'package:preggo/routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:preggo/services/auth.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(PreggoApp());
}

class PreggoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<UserUID>.value(
      value: AuthService().user,
      initialData: UserUID(),
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.pink,
          scaffoldBackgroundColor: const Color(0xFF7209B7),
        ),
        title: 'Pregnancy Weights',
        initialRoute: Wrapper.id,
        routes: appRoutes,
      ),
    );
  }
}
