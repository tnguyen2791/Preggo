import 'package:flutter/material.dart';
import 'package:preggo/presentation/screens/wrapper.dart';
import 'package:preggo/services/auth.dart';
import 'package:preggo/shared/restartwidget.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class WeighInOptions extends StatelessWidget {
  const WeighInOptions({Key? key}) : super(key: key);

  static const String id = 'eatingdisorderinfo';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                AuthService().signOut();
                RestartWidget.restartApp(context);
              },
              icon: const Icon(FontAwesomeIcons.powerOff))
        ],
        title: const Text('Weigh in Options'),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Text('Place holder for information about weighing options'),
            const WeighRadioChecks(),
            TextButton(
                style: TextButton.styleFrom(backgroundColor: Colors.white),
                onPressed: (() =>
                    Navigator.pushReplacementNamed(context, Wrapper.id)),
                child: const Text("Done!"))
          ],
        ),
      ),
    );
  }
}

enum WeighOptions { regular, partner, noweigh }

class WeighRadioChecks extends StatefulWidget {
  const WeighRadioChecks({Key? key}) : super(key: key);

  @override
  State<WeighRadioChecks> createState() => _WeighRadioChecksState();
}

class _WeighRadioChecksState extends State<WeighRadioChecks> {
  WeighOptions? _userweigh = WeighOptions.regular;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RadioListTile(
            title: const Text('Regular Weigh In'),
            value: WeighOptions.regular,
            groupValue: _userweigh,
            onChanged: (WeighOptions? value) {
              setState(() {
                _userweigh = value;
              });
            }),
        RadioListTile(
            title: const Text('Partner Weigh In'),
            value: WeighOptions.partner,
            groupValue: _userweigh,
            onChanged: (WeighOptions? value) {
              setState(() {
                _userweigh = value;
              });
            }),
        RadioListTile(
            title: const Text('Do not Weigh In'),
            value: WeighOptions.noweigh,
            groupValue: _userweigh,
            onChanged: (WeighOptions? value) {
              setState(() {
                _userweigh = value;
              });
            }),
      ],
    );
  }
}
