import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:preggo/presentation/screens/wrapper.dart';
import 'package:preggo/services/auth.dart';

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
      title: const Text('Delete Data?'),
      content: FittedBox(
        fit: BoxFit.fitHeight,
        child: Column(
          children: [
            SizedBox(
                width: 200,
                height: 150,
                child: ListView(children: [Text(_disclaimer.toString())])),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Go Back'),
            ),
            ElevatedButton(
              onPressed: () {
                AuthService().signOut();
                Navigator.popUntil(context, ModalRoute.withName(Wrapper.id));
              },
              child: const Text('Log Out'),
            ),
          ],
        ),
      ),
    );
  }
}
