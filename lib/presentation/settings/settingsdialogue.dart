import 'package:flutter/services.dart';
import 'package:preggo/models/user.dart';
import 'package:preggo/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> weightInput(BuildContext context) async {
  final _weightController = TextEditingController();
  final user = Provider.of<UserUID>(context, listen: false);

  int _userDBweight = await DatabaseService(uid: user.uid).getweight();
  var _weight;

  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Pre-Pregnancy Weight'),
          content: TextField(
            controller: _weightController..text = _userDBweight.toString(),
            onChanged: (value) {
              _weight = value;
              // print(_weight);
            },
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Input weight',
              // errorText: _errorText(_weightController)
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                // print(_weightController.value.text.isEmpty);
                if (_weightController.value.text.isEmpty) {
                  null;
                } else {
                  if (_weightController.value.text
                      .contains(RegExp(r'(^[0-9]*$)'))) {
                    _weight = _weightController.value.text;
                    DatabaseService(uid: user.uid)
                        .updateWeight(int.parse(_weight));
                    Navigator.pop(context);
                  } else {
                    null;
                  }
                }
              },
              child: const Text("Done"),
            ),
            TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'))
          ],
        );
      });
}

Future<void> enterDueDate(BuildContext context) async {
  final user = Provider.of<UserUID>(context, listen: false);
  // final userdata = Provider.of<UserData>(context, listen: false);

  showDatePicker(
    context: context,
    initialDate: DateTime.fromMillisecondsSinceEpoch(
        await DatabaseService(uid: user.uid).getdate()),
    firstDate: DateTime(2000),
    lastDate: DateTime(2050),
    cancelText: "Cancel",
  ).then((date) async {
    if (date == null) {
      return;
    } else {
      int adate = date.millisecondsSinceEpoch;
      // print(adate);
      // print(DateTime.fromMillisecondsSinceEpoch(adate));
      DatabaseService(uid: user.uid).updateDueDate(adate);
    }
  });
}

Future<void> emailInput(BuildContext context) async {
  String? email;
  final user = Provider.of<UserUID>(context, listen: false);
  final emailTextController = TextEditingController();
  String _useremail = await DatabaseService(uid: user.uid).getemail();

  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Provider E-mail'),
          content: TextField(
            controller: emailTextController..text = _useremail,
            onChanged: (value) {
              email = value;
              print(email);
            },
            keyboardType: TextInputType.emailAddress,
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (emailTextController.value.text.isEmpty) {
                  null;
                } else {
                  if (emailTextController.value.text.contains(RegExp(
                      r"([a-z0-9!#&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?)"))) {
                    DatabaseService(uid: user.uid)
                        .updateemail(emailTextController.value.text);
                    Navigator.pop(context);
                  } else {
                    null;
                  }
                }
              },
              child: const Text("Done"),
            ),
            TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'))
          ],
        );
      });
}
