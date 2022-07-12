import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:preggo/presentation/screens/sign_up_screen.dart';
import 'package:preggo/services/auth.dart';

class LoginScreen extends StatelessWidget {
  static const id = 'login_screen';

  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        padding: const EdgeInsets.all(30),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Hero(
                tag: 'logo',
                child: CircleAvatar(
                    radius: 150.0,
                    backgroundImage: AssetImage('assets/icon/icon.png')
                    // ,
                    ),
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
                  buttontext: 'Register with e-mail',
                  icon: FontAwesomeIcons.ethereum,
                  color: Colors.lightGreen,
                  loginMethod: () {
                    Navigator.pushNamed(context, SignUpScreen.id);
                    // UserUID result = await AuthService().anonLogin();
                    // if (result == null) {
                    //   print('error signing in');
                    // } else {
                    //   print(result.uid);
                    //   print('signed in');
                    // }
                  },
                ),
              ),
              Flexible(
                child: LoginButton(
                  buttontext: 'Feedback',
                  icon: FontAwesomeIcons.thumbsUp,
                  color: Colors.redAccent,
                  loginMethod: () => print('give us feedback!'),
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
          loginMethod();
          //important in tacit programming the method gets called when it is pressed.
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
