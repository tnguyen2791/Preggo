import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:preggo/models/user.dart';
import 'package:preggo/services/database.dart';
import 'package:preggo/services/sharedfunctions.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:preggo/tools/sharedPreferences.dart';
import 'package:provider/provider.dart';
import 'package:preggo/models/pregnancy.dart';
import 'settingsdialogue.dart';

class Settings extends StatelessWidget {
  static const String id = 'settings_screen';
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
  double? preconweight;
  bool settingsChanges = false;

  //Above is, start the session with the instantiated variable and then pull
  //if we are able to from the SharedPrefs

  //TODO: Creating a setting page: https://www.youtube.com/watch?v=PVuJ-If0AuU

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
                title: Text('Profile Settings'),
                tiles: [
                  SettingsTile(
                    title: Text('Due Date'),
                    leading: Icon(FontAwesomeIcons.baby),
                    trailing:
                        Text(toPrettyDateMMMddyyyy(userData.epochduedate)),
                    onPressed: enterDueDate,
                  ),
                  SettingsTile(
                    title: Text('Pre-pregnancy Weight'),
                    leading: Icon(FontAwesomeIcons.weightScale),
                    trailing: Text("${userData.weight.toString()} lbs"),
                    onPressed: weightInput,
                  ),
                  SettingsTile(
                    title: Text('Provider E-mail'),
                    leading: Icon(FontAwesomeIcons.userDoctor),
                    trailing: Text(userData.email.toString()),
                    onPressed: emailInput,
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
