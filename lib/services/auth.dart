import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:preggo/models/user.dart';
import 'package:preggo/services/database.dart';

class AuthService {
  final userStream = FirebaseAuth.instance.authStateChanges();
  final fbuser = FirebaseAuth.instance.currentUser;
  final auth = FirebaseAuth.instance;

  UserUID _userFromFirebaseUser(User user) {
    return UserUID(uid: user.uid);
  }

  Future<UserUID> createNewUser(String email, String password) async {
    try {
      UserCredential result = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      await DatabaseService(uid: result.user?.uid)
          .updateUserData(1656882023322, 100, 'your@provider.org', false);
      return _userFromFirebaseUser(result.user!);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        print('Invalid password');
      }
      return UserUID();
    }
  }

  Future<UserUID> signInwithEmailandPassword(
      String email, String password) async {
    try {
      UserCredential result = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return _userFromFirebaseUser(result.user!);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email') {
        print('Invalid e-mail');
      }
      if (e.code == 'user-not-found') {
        print('User not found.');
      }
      if (e.code == 'wrong-password') {
        print('Invalid password');
      }
      if (e.code == 'email-already-in-use') {
        print('Invalid password');
      }
      return UserUID();
    }
  }

  //auth change user stream
  //this is a function that will receive from the data base and turn it into a UserID object
  Stream<UserUID> get user {
    return userStream.map(
      (User? user) => _userFromFirebaseUser(user!),
    );
  }

  //now this stream will return our own model of the user

  Future<UserUID> googleLogin() async {
    try {
      final googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) return UserUID();

      final googleAuth = await googleUser.authentication;
      final authCredential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential result =
          await FirebaseAuth.instance.signInWithCredential(authCredential);
      User user = result.user!;

      //creating the document for this user
      // await DatabaseService(uidindatabase: user.uid)
      //     .updateUserData(1656882023322, 100, 'your@provider.org');

      return _userFromFirebaseUser(user);
    } on FirebaseAuthException catch (e) {
      return UserUID();
    }
  }

  Future<UserUID> anonLogin() async {
    try {
      UserCredential result = await FirebaseAuth.instance.signInAnonymously();
      User user = result.user!;
      await DatabaseService(uid: user.uid)
          .updateUserData(1656882023322, 100, 'your@provider.org', false);
      return _userFromFirebaseUser(user);
      //Will return a custom user object instead of Firebaseuser
    } on FirebaseAuthException catch (e) {
      return UserUID();
    }
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}
