import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:preggo/presentation/screens/wrapper.dart';
import 'package:preggo/services/auth.dart';
import 'package:preggo/shared/constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SignUpScreen extends StatefulWidget {
  static String id = 'sign_up_screen';

  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final auth = FirebaseAuth.instance;
  String email = 'fakeemail';
  String password = 'fakepassword';
  final GlobalKey<FormState> _signupformKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        // key: scaffoldkey,
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () {
                  AuthService().signOut();
                },
                icon: const Icon(FontAwesomeIcons.powerOff))
          ],
          title: const Text('Email Registration or Sign-in'),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: SingleChildScrollView(
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.9,
              child: Column(children: <Widget>[
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
                const Hero(
                  tag: 'logo',
                  child: CircleAvatar(
                      radius: 150.0,
                      backgroundImage: AssetImage('assets/icon/icon.png')
                      // ,
                      ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
                Form(
                  key: _signupformKey,
                  child: Column(
                    children: [
                      TextFormField(
                        onChanged: (value) => email = value,
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.pink[100],
                            hintText: 'E-mail'),
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              (value.contains(RegExp(
                                      r"([a-z0-9!#&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?)")) ==
                                  false)) {
                            return 'Error in input';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        obscureText: true,
                        decoration: InputDecoration(
                            hintText: 'Password',
                            filled: true,
                            fillColor: Colors.pink[100]),
                        onChanged: (value) => password = value,
                        controller: passwordController,
                      ),
                      const SizedBox(
                        height: 25.0,
                      ),
                      ElevatedButton(
                        style: kElevatedButtonStyle,
                        onPressed: () async {
                          if (_signupformKey.currentState!.validate()) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Welcome')));
                            AuthService().signInwithEmailandPassword(
                                emailController.text, passwordController.text);
                            Navigator.of(context)
                                .pushReplacementNamed(Wrapper.id);
                          }
                        },
                        child: const Text('Sign-In'),
                      ),
                      ElevatedButton(
                        style: kElevatedButtonStyle,
                        onPressed: () async {
                          if (_signupformKey.currentState!.validate()) {
                            await AuthService()
                                .createNewUser(emailController.text,
                                    passwordController.text)
                                .whenComplete(() {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Welcome')));

                              Navigator.of(context)
                                  .pushReplacementNamed(Wrapper.id);
                            });
                          }
                        },
                        child: const Text('Sign-Up!'),
                      ),
                    ],
                  ),
                ),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
