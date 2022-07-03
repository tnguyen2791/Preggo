import 'package:flutter/material.dart';
import 'package:preggo/models/user.dart';
import 'package:preggo/services/database.dart';
import 'package:preggo/shared/constants.dart';
import 'package:provider/provider.dart';

class SettingsForm extends StatefulWidget {
  const SettingsForm({Key? key}) : super(key: key);

  @override
  State<SettingsForm> createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formkey = GlobalKey<FormState>();
  final List<String> pregnantornot = [
    "I am pregnant",
    "I am not pregnant",
    "I don't know if I'm pregnant",
    "the supreme court sucks"
  ];

  String currentdate = 'a date';
  String currentduedate = 'the supreme court sucks';
  double currentweight = 100;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModeling>(context);

    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData userData = snapshot.data!;
            return Form(
              key: _formkey,
              child: Column(children: [
                const Text(
                  'Update your pregnancy settings',
                  style: TextStyle(fontSize: 18),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  initialValue: userData.date,
                  decoration: textInputDecoration,
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return "username must be here";
                    }
                    return null;
                  },
                  onChanged: (value) => setState(() {
                    currentdate = value;
                    print(currentdate);
                  }),
                ),
                const SizedBox(
                  height: 20,
                ),
                DropdownButtonFormField(
                  value: userData.duedate,
                  items: pregnantornot.map((preg) {
                    return DropdownMenuItem(value: preg, child: Text(preg));
                  }).toList(),
                  onChanged: (value) => setState(() {
                    currentduedate = value as String;
                    print('currentDD $currentduedate');
                  }),
                ),
                Slider(
                  value: currentweight,
                  onChanged: (value) => setState(() {
                    currentweight = value;
                  }),
                  max: 400,
                  min: 50,
                  activeColor: Colors.purple,
                  inactiveColor: Colors.pink,
                ),
                ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateColor.resolveWith(
                          (states) => Colors.amber)),
                  onPressed: () async {
                    if (_formkey.currentState!.validate()) {
                      print("current date $currentdate");
                      print('current DD $currentduedate');
                      print('current weight $currentweight');
                      await DatabaseService(uid: user.uid).updateUserData(
                          currentduedate,
                          currentweight.toString(),
                          currentdate ?? 'nodate');
                      // print(user.uid);
                    }
                  },
                  child: const Text('Update'),
                ),
              ]),
            );
          } else {
            return const Text('something went wrong');
          }
        });
  }
}
