import 'package:flutter/material.dart';
import 'package:preggo/presentation/screens/wrapper.dart';

class WeighInOptions extends StatelessWidget {
  const WeighInOptions({Key? key}) : super(key: key);

  static const String id = 'eatingdisorderinfo';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weigh in Options'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text('Place holder for information about weighing options'),
          WeighRadioChecks(),
          TextButton(
              style: TextButton.styleFrom(backgroundColor: Colors.white),
              onPressed: (() =>
                  Navigator.pushReplacementNamed(context, Wrapper.id)),
              child: Text("Done!"))
        ],
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
            title: Text('Regular Weigh In'),
            value: WeighOptions.regular,
            groupValue: _userweigh,
            onChanged: (WeighOptions? value) {
              setState(() {
                _userweigh = value;
              });
            }),
        RadioListTile(
            title: Text('Partner Weigh In'),
            value: WeighOptions.partner,
            groupValue: _userweigh,
            onChanged: (WeighOptions? value) {
              setState(() {
                _userweigh = value;
              });
            }),
        RadioListTile(
            title: Text('Do not Weigh In'),
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
