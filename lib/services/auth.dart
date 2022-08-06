import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:preggo/models/user.dart';
import 'package:preggo/services/database.dart';

class AuthService {
  final userStream = FirebaseAuth.instance.authStateChanges();
  final fbuser = FirebaseAuth.instance.currentUser;
  final auth = FirebaseAuth.instance;

  UserUID _userFromFirebaseUser(User? user) {
    if (user != null) {
      return UserUID(uid: user.uid);
    } else {
      return (UserUID());
    }
  }

  Future<UserUID> createNewUser(String email, String password) async {
    try {
      UserCredential result = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return await DatabaseService(uid: result.user!.uid)
          .createNewDBUser()
          .then((value) => _userFromFirebaseUser(result.user!));
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

  Future<void> signInAnonymously() async {
    try {
      final userCredential = await FirebaseAuth.instance.signInAnonymously();
      await DatabaseService(uid: userCredential.user?.uid).createNewDBUser();
      print("Signed in with temporary account.");
      // return _userFromFirebaseUser(userCredential.user!);
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "operation-not-allowed":
          print("Anonymous auth hasn't been enabled for this project.");
          break;
        default:
          print("Unknown error.");
      }
    }
    print('returning default');
  }

  Stream<UserUID> get user {
    return userStream.map(
      (User? user) => _userFromFirebaseUser(user),
    );
  }

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

      if (await DatabaseService(uid: user.uid).checksDBfordocexistance() ==
          false) {
        DatabaseService(uid: user.uid).createNewDBUser();
      }
      return _userFromFirebaseUser(user);
    } on FirebaseAuthException catch (e) {
      return UserUID();
    }
  }

  Future<void> signOut() async {
    // Provider.of<UserUID>(context, listen: false);
    await FirebaseAuth.instance.signOut();
  }
}
