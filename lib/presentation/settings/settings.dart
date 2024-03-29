import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:preggo/models/user.dart';
import 'package:preggo/services/sharedfunctions.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'settingsdialogue.dart';
import 'weighselection.dart';

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

  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<UserData>(context);

    return Column(
      children: [
        Expanded(
          child: SettingsList(
            sections: [
              SettingsSection(
                title: Center(
                  child: Image(
                      image: const AssetImage('assets/png/babycarriage.png'),
                      height: MediaQuery.of(context).size.height * 0.25,
                      fit: BoxFit.fitWidth),
                ),
                tiles: [
                  SettingsTile(
                    title: const Text('Due Date'),
                    leading: const Icon(FontAwesomeIcons.baby),
                    trailing:
                        Text(toPrettyDateMMMddyyyy(userData.epochduedate)),
                    onPressed: enterDueDate,
                  ),
                  if (userData.weighpref != "No Weight")
                    SettingsTile(
                      title: const Text('Pre-pregnancy Weight'),
                      leading: const Icon(FontAwesomeIcons.weightScale),
                      trailing: Text("${userData.weight.toString()} lbs"),
                      onPressed: weightInput,
                    ),
                  if (userData.weighpref != "No Weight")
                    SettingsTile(
                      title: const Text('Height'),
                      leading: const Icon(FontAwesomeIcons.ruler),
                      trailing: Text("${userData.heightininches} inches"),
                      onPressed: heightInput,
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
          ),
        ),
      ],
    );
  }
}
