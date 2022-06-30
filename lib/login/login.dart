import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:preggo/services/auth.dart';

class LoginScreen extends StatelessWidget {
  static const id = 'login_screen';

  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(30),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const FlutterLogo(
                size: 150,
              ),
              Flexible(
                child: LoginButton(
                  buttontext: 'Google Login',
                  icon: FontAwesomeIcons.google,
                  color: Colors.lightBlue,
                  loginMethod: AuthService().googleLogin,
                ),
              ),
              Flexible(
                child: LoginButton(
                  buttontext: 'Anonymous Login',
                  icon: FontAwesomeIcons.userNinja,
                  color: Colors.lightGreen,
                  loginMethod: AuthService().anonLogin,
                ),
              ),
              Flexible(
                child: LoginButton(
                  buttontext: 'Log Out',
                  icon: FontAwesomeIcons.stop,
                  color: Colors.redAccent,
                  loginMethod: AuthService().signOut,
                ),
              ),
            ]),
      ),
    );
  }
}

class LoginButton extends StatelessWidget {
  final Color color;
  final IconData icon;
  final String buttontext;
  final Function loginMethod;

  const LoginButton(
      {Key? key,
      required this.color,
      required this.icon,
      required this.buttontext,
      required this.loginMethod})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: ElevatedButton.icon(
        onPressed: () {
          print('login/logout button was pressed');
          print(FirebaseAuth.instance.currentUser);
          loginMethod();
          //important in tacit programming the method gets called when it is pressed.
          print(FirebaseAuth.instance.currentUser);
        },
        icon: Icon(
          icon,
          color: Colors.white,
        ),
        label: Text(
          buttontext,
          textAlign: TextAlign.center,
        ),
        style: TextButton.styleFrom(
          padding: const EdgeInsets.all(24),
          backgroundColor: color,
        ),
      ),
    );
  }
}
