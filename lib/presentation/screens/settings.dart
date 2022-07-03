import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:preggo/models/user.dart';
import 'package:preggo/services/database.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:preggo/tools/sharedPreferences.dart';
import 'package:provider/provider.dart';

class Settings extends StatelessWidget {
  static const String id = 'settings screen';
  const Settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        centerTitle: true,
      ),
      body: const SettingsOptions(),
    );
  }
}

class SettingsOptions extends StatefulWidget {
  const SettingsOptions({Key? key}) : super(key: key);

  @override
  State<SettingsOptions> createState() => _SettingsOptionsState();
}

class _SettingsOptionsState extends State<SettingsOptions> {
  bool? settingUserAgreement;

  bool theme2 = false;
  bool toggle1 = true;

  String? _dueDate;
  double? preconweight;
  bool settingsChanges = false;

  //Above is, start the session with the instantiated variable and then pull
  //if we are able to from the SharedPrefs

  final _weightController = TextEditingController();

  //TODO: Creating a setting page: https://www.youtube.com/watch?v=PVuJ-If0AuU

  Future<void> _weightInput(BuildContext context) async {
    var _weight;

    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Pre-conception Weight'),
            content: TextField(
              controller: _weightController,
              onChanged: (value) {
                if (value == null) {
                  Navigator.pop(context);
                }
                try {
                  _weight = int.parse(value).toDouble();
                } catch (e) {
                  print(e);
                }
              },
              keyboardType: TextInputType.number,
            ),
            actions: [
              TextButton(
                onPressed: () {
                  if (_weight == null) {
                    Navigator.pop(context);
                  } else {
                    try {
                      addDoubletoSP('preconweight', _weight);
                      print(getDoublefromSP('preconweight'));
                      setState(() {
                        preconweight = _weight.toDouble();
                      });
                    } catch (e) {
                      print(e);
                    } finally {
                      Navigator.pop(context);
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
    final user = Provider.of<UserModeling>(context, listen: false);

    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2050),
      cancelText: "Cancel",
    ).then((date) async {
      if (date == null) {
        return;
      } else {
        int adate = date.millisecondsSinceEpoch;
        print(adate);
        print(DateTime.fromMillisecondsSinceEpoch(adate));
        DatabaseService(uid: user.uid).updateDueDate(adate);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModeling>(context);

    return StreamBuilder<UserData>(
      stream: DatabaseService(uid: user.uid).userData,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          UserData userData = snapshot.data!;
          return SettingsList(
            sections: [
              SettingsSection(
                title: Text('Profile Settings'),
                tiles: [
                  SettingsTile(
                    title: Text('Due Date'),
                    leading: Icon(FontAwesomeIcons.baby),
                    trailing: Text(userData.duedate.toString()),
                    onPressed: enterDueDate,
                  ),
                  SettingsTile(
                    title: Text('Pre-pregnancy Weight'),
                    leading: Icon(FontAwesomeIcons.weightScale),
                    trailing: Text(preconweight.toString()),
                    onPressed: _weightInput,
                  ),
                  SettingsTile(
                    title: Text('Provider E-mail'),
                    leading: Icon(FontAwesomeIcons.userDoctor),
                    trailing: Text(preconweight.toString()),
                    onPressed: _weightInput,
                  ),
                ],
              ),
            ],
          );
        } else {
          return Container(child: Text('something has gone wrong'));
        }
      },
    );
  }
}
