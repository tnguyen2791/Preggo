import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

class DisclaimerAlertDialogue extends StatefulWidget {
  const DisclaimerAlertDialogue({Key? key}) : super(key: key);

  @override
  State<DisclaimerAlertDialogue> createState() =>
      _DisclaimerAlertDialogueState();
}

class _DisclaimerAlertDialogueState extends State<DisclaimerAlertDialogue> {
  String _disclaimer = 'error loading';

  @override
  void initState() {
    _loadDisclaimer();
    super.initState();
  }

  Future<void> _loadDisclaimer() async {
    final loadedDisclaimer =
        await rootBundle.loadString('assets/texts/disclaimer.txt');
    setState(() {
      _disclaimer = loadedDisclaimer;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Disclaimer'),
      content: SizedBox(
          width: 200,
          height: 400,
          child: ListView(children: [Text(_disclaimer.toString())])),
    );
  }
}
