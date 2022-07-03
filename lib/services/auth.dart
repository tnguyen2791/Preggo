import 'package:firebase_auth/firebase_auth.dart';
import 'database.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:preggo/models/user.dart';

class AuthService {
  final userStream = FirebaseAuth.instance.authStateChanges();
  final fbuser = FirebaseAuth.instance.currentUser;

  UserModeling _userFromFirebaseUser(User user) {
    return UserModeling(uid: user.uid);
  }

  //auth change user stream
  Stream<UserModeling> get user {
    return userStream.map(
      (User? user) => _userFromFirebaseUser(user!),
    );
  }
  //now this stream will return our own model of the user

  Future<UserModeling> googleLogin() async {
    try {
      final googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) return UserModeling();

      final googleAuth = await googleUser.authentication;
      final authCredential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential result =
          await FirebaseAuth.instance.signInWithCredential(authCredential);
      User user = result.user!;

      //creating the document for this user
      // await DatabaseService(uid: user.uid)
      //     .updateUserData('I am pregnant', '100.00', 'This is a date');

      return _userFromFirebaseUser(user);
    } on FirebaseAuthException catch (e) {
      print(e.message);
      return UserModeling();
    }
  }

  Future<UserModeling> anonLogin() async {
    try {
      UserCredential result = await FirebaseAuth.instance.signInAnonymously();
      User user = result.user!;
      return _userFromFirebaseUser(user);
      //Will return a custom user object instead of Firebaseuser
    } on FirebaseAuthException catch (e) {
      return UserModeling();
    }
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}
