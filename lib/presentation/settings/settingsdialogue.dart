import 'package:preggo/models/user.dart';
import 'package:preggo/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> weightInput(BuildContext context) async {
  final weightController = TextEditingController();
  final user = Provider.of<UserUID>(context, listen: false);
  final userData = Provider.of<UserData>(context, listen: false);

  // int userDBweight = await DatabaseService(uid: user.uid).getweight();
  String weight;

  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Pre-Pregnancy Weight'),
          content: TextField(
            controller: weightController..text = userData.weight.toString(),
            onChanged: (value) {
              weight = value;
            },
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Input weight',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (weightController.value.text.isEmpty) {
                  null;
                } else {
                  if (weightController.value.text.contains(
                    RegExp(r'(^[0-9]*$)'),
                  )) {
                    weight = weightController.value.text;
                    if (int.parse(weight) < 600) {
                      DatabaseService(uid: user.uid)
                          .updateWeight(int.parse(weight));
                      Navigator.pop(context);
                    }
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

Future<void> heightInput(BuildContext context) async {
  final heightController = TextEditingController();
  final user = Provider.of<UserUID>(context, listen: false);
  final userData = Provider.of<UserData>(context, listen: false);

  String height;

  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Height in Inches'),
          content: TextField(
            controller: heightController
              ..text = userData.heightininches.toString(),
            onChanged: (value) {
              height = value;
            },
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Input height',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (heightController.value.text.isEmpty) {
                  null;
                } else {
                  if (heightController.value.text.contains(
                    RegExp(r'(^[0-9]*$)'),
                  )) {
                    height = heightController.value.text;
                    if (int.parse(height) < 95) {
                      DatabaseService(uid: user.uid)
                          .updateHeight(int.parse(height));
                      Navigator.pop(context);
                    }
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

  showDatePicker(
    context: context,
    initialDate: DateTime.fromMillisecondsSinceEpoch(
        await DatabaseService(uid: user.uid).getdate()),
    firstDate: DateTime.now(),
    lastDate: DateTime.now().add(
      const Duration(days: 360),
    ),
    cancelText: "Cancel",
  ).then((date) async {
    if (date == null) {
      return;
    } else {
      int adate = date.millisecondsSinceEpoch;
      DatabaseService(uid: user.uid).updateDueDate(adate);
    }
  });
}

Future<void> emailInput(BuildContext context) async {
  String? email;
  final user = Provider.of<UserUID>(context, listen: false);
  final emailTextController = TextEditingController();
  String useremail = await DatabaseService(uid: user.uid).getemail();

  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Provider E-mail'),
          content: TextField(
            controller: emailTextController..text = useremail,
            onChanged: (value) {
              email = value;
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
