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
  runApp(const PreggoApp());
}

class PreggoApp extends StatelessWidget {
  const PreggoApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamProvider<UserUID>.value(
      catchError: (_, error) => UserUID(),
      value: AuthService().user,
      initialData: UserUID(),
      child: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: MaterialApp(
          theme: ThemeData(
            primarySwatch: Colors.pink,
            scaffoldBackgroundColor: const Color(0xFF7209B7),
          ),
          title: 'Pregnancy Weights',
          initialRoute: Wrapper.id,
          routes: appRoutes,
        ),
      ),
    );
  }
}
