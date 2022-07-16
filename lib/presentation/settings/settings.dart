import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:preggo/models/user.dart';
import 'package:preggo/services/database.dart';
import 'package:preggo/services/sharedfunctions.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'settingsdialogue.dart';

class Settings extends StatelessWidget {
  static const String id = 'settings_screen';
  const Settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserUID>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        actions: [
          IconButton(
              onPressed: () =>
                  DatabaseService(uid: user.uid).updateWeighPref('Regular'),
              icon: const Icon(Icons.textsms_sharp))
        ],
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
  double? preconweight;
  bool settingsChanges = false;

  //Above is, start the session with the instantiated variable and then pull
  //if we are able to from the SharedPrefs

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserUID>(context);

    return StreamBuilder<UserData>(
      stream: DatabaseService(uid: user.uid).userData,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          UserData userData = snapshot.data!;
          return SettingsList(
            sections: [
              SettingsSection(
                title: const Text('Profile Settings'),
                tiles: [
                  SettingsTile(
                    title: const Text('Due Date'),
                    leading: const Icon(FontAwesomeIcons.baby),
                    trailing:
                        Text(toPrettyDateMMMddyyyy(userData.epochduedate)),
                    onPressed: enterDueDate,
                  ),
                  SettingsTile(
                    title: const Text('Pre-pregnancy Weight'),
                    leading: const Icon(FontAwesomeIcons.weightScale),
                    trailing: Text("${userData.weight.toString()} lbs"),
                    onPressed: weightInput,
                  ),
                  SettingsTile(
                      title: const Text('Weigh Options'),
                      leading: const Icon(FontAwesomeIcons.person),
                      trailing: const WeighSelection(),
                      onPressed: null),
                  SettingsTile(
                    title: const Text('Provider E-mail'),
                    leading: const Icon(FontAwesomeIcons.userDoctor),
                    trailing: Text(userData.email.toString()),
                    onPressed: emailInput,
                  ),
                ],
              ),
            ],
          );
        } else {
          return const Text('something has gone wrong');
        }
      },
    );
  }
}

class WeighSelection extends StatefulWidget {
  const WeighSelection({Key? key}) : super(key: key);

  @override
  State<WeighSelection> createState() => _WeighSelectionState();
}

class _WeighSelectionState extends State<WeighSelection> {
  String dropdownValue = 'Regular';

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserUID>(context);
    return DropdownButton<String>(
      value: dropdownValue,
      icon: const Icon(Icons.arrow_downward),
      elevation: 16,
      style: const TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: (String? newValue) async {
        await DatabaseService(uid: user.uid).updateWeighPref(newValue!);
        setState(() {
          dropdownValue = newValue;
        });
      },
      items: <String>['Regular', 'Partner', 'No Weight']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
