import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:preggo/introductionscreen/datacollectionform.dart';
import 'package:preggo/presentation/screens/eatingdisorderinfo.dart';
import 'package:preggo/presentation/settings/weighselection.dart';
import 'package:preggo/services/database.dart';
import 'package:preggo/shared/constants.dart';

class WeighingDisclaimer extends StatefulWidget {
  const WeighingDisclaimer({Key? key}) : super(key: key);

  @override
  State<WeighingDisclaimer> createState() => _WeighingDisclaimerState();
}

class _WeighingDisclaimerState extends State<WeighingDisclaimer> {
  String _disclaimer = 'error loading';

  @override
  void initState() {
    _loadDisclaimer();
    super.initState();
  }

  Future<void> _loadDisclaimer() async {
    final loadedDisclaimer =
        await rootBundle.loadString('assets/texts/weighindisclaimer.txt');
    setState(() {
      _disclaimer = loadedDisclaimer;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Weigh-in Options'),
      content: Column(
        children: [
          SizedBox(
            width: 200,
            height: 400,
            child: ListView(children: [
              Text(_disclaimer.toString()),
            ]),
          ),
          const WeighSelection(),
          ElevatedButton(
            style: kElevatedButtonStyle,
            onPressed: () => Navigator.pushReplacementNamed(
                context, DataCollectionScreen.id),
            child: Text("Let's move on"),
          )
        ],
      ),
    );
  }
}
