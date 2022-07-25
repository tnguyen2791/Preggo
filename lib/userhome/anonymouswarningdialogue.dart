import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:preggo/services/auth.dart';
import 'package:preggo/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AnonymousLogoutWarningAlertDialogue extends StatefulWidget {
  const AnonymousLogoutWarningAlertDialogue({Key? key}) : super(key: key);

  @override
  State<AnonymousLogoutWarningAlertDialogue> createState() =>
      _AnonymousLogoutWarningAlertDialogueState();
}

class _AnonymousLogoutWarningAlertDialogueState
    extends State<AnonymousLogoutWarningAlertDialogue> {
  String _disclaimer = 'error loading';

  @override
  void initState() {
    _loadDisclaimer();
    super.initState();
  }

  Future<void> _loadDisclaimer() async {
    final loadedDisclaimer =
        await rootBundle.loadString('assets/texts/anonymoussignout.txt');
    setState(() {
      _disclaimer = loadedDisclaimer;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Partner Weigh-In'),
      content: Column(
        children: [
          SizedBox(
              width: 200,
              height: 400,
              child: ListView(children: [Text(_disclaimer.toString())])),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Go Back'),
          ),
          ElevatedButton(
            onPressed: () {
              final fbuser = FirebaseAuth.instance.currentUser?.uid;

              AuthService().signOut();
              DatabaseService(uid: fbuser).deleteDoc();
              Navigator.pop(context);
            },
            child: Text('Log Out'),
          ),
        ],
      ),
    );
  }
}
