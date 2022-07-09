import 'dart:math';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:preggo/presentation/screens/wrapper.dart';
import 'package:preggo/services/auth.dart';
import 'package:preggo/userhome/userhome.dart';

class SignUpScreen extends StatefulWidget {
  static String id = 'sign_up_screen';

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final auth = FirebaseAuth.instance;
  String email = 'fakeemail';
  String password = 'fakepassword';
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Scaffold(
          appBar: AppBar(),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Form(
                      key: formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            onChanged: (value) => email = value,
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
                            onChanged: (value) => password = value,
                            controller: passwordController,
                          ),
                        ],
                      )),
                  ElevatedButton(
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Submitting!')));
                        AuthService().signInwithEmailandPassword(
                            emailController.text, passwordController.text);
                        Navigator.of(context).pushReplacementNamed(Wrapper.id);
                      }
                    },
                    child: const Text('Sign-In!'),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Submitting!')));
                        AuthService().createNewUser(
                            emailController.text, passwordController.text);
                        Navigator.of(context).pushReplacementNamed(Wrapper.id);
                      }
                    },
                    child: const Text('Sign-Up!'),
                  ),
                ]),
          ),
        ));
  }
}
