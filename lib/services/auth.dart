import 'package:firebase_auth/firebase_auth.dart';
import 'database.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:preggo/models/user.dart';

class AuthService {
  final userStream = FirebaseAuth.instance.authStateChanges();
  final fbuser = FirebaseAuth.instance.currentUser;

  UserUID _userFromFirebaseUser(User user) {
    return UserUID(uid: user.uid);
  }

  //auth change user stream
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
      await DatabaseService(uid: user.uid)
          .updateUserData(1656882023322, 100, 'your@provider.org');

      return _userFromFirebaseUser(user);
    } on FirebaseAuthException catch (e) {
      print(e.message);
      return UserUID();
    }
  }

  Future<UserUID> anonLogin() async {
    try {
      UserCredential result = await FirebaseAuth.instance.signInAnonymously();
      User user = result.user!;
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
