import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

class PartnerWeighingAlertDialogue extends StatefulWidget {
  const PartnerWeighingAlertDialogue({Key? key}) : super(key: key);

  @override
  State<PartnerWeighingAlertDialogue> createState() =>
      _PartnerWeighingAlertDialogueState();
}

class _PartnerWeighingAlertDialogueState
    extends State<PartnerWeighingAlertDialogue> {
  String _disclaimer = 'error loading';

  @override
  void initState() {
    _loadDisclaimer();
    super.initState();
  }

  Future<void> _loadDisclaimer() async {
    final loadedDisclaimer =
        await rootBundle.loadString('assets/texts/partnerinstructions.txt');
    setState(() {
      _disclaimer = loadedDisclaimer;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        'Partner Weigh-In',
        textAlign: TextAlign.center,
      ),
      content: SizedBox(
        height: MediaQuery.of(context).size.height * 0.35,
        child: Column(
          children: [
            SizedBox(
                width: 200,
                height: 250,
                child: ListView(children: [Text(_disclaimer.toString())])),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Sounds good'),
            ),
          ],
        ),
      ),
    );
  }
}
