import 'package:preggo/components/base.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:flutter/material.dart';
import 'package:preggo/components/screenBase.dart';

class Settings extends StatelessWidget {
  static const String id = 'settings screen';
  const Settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenBaseScaffold(
        scaffoldBody: SettingsOptions(), titleText: "Settings");
  }
}

class SettingsOptions extends StatefulWidget {
  const SettingsOptions({Key? key}) : super(key: key);

  @override
  State<SettingsOptions> createState() => _SettingsOptionsState();
}

class _SettingsOptionsState extends State<SettingsOptions> {
  bool theme2 = false;
  bool toggle1 = true;

  //TODO: Creating a setting page: https://www.youtube.com/watch?v=PVuJ-If0AuU

  @override
  Widget build(BuildContext context) {
    return SettingsList(
      sections: [
        SettingsSection(
          title: Text('Common'),
          tiles: [
            SettingsTile.navigation(
              leading: Icon(Icons.language),
              title: Text('Language'),
              value: Text('English'),
            ),
            SettingsTile.switchTile(
              onToggle: (value) {
                setState(() {
                  this.toggle1 = value;
                });
              },
              initialValue: toggle1,
              leading: Icon(Icons.format_paint),
              title: Text('Toggle 1'),
            ),
            SettingsTile.switchTile(
              onToggle: (value) {
                setState(() {
                  theme2 = value;
                });
                print(value);
              },
              initialValue: theme2,
              leading: Icon(Icons.format_paint),
              title: Text('Theme 2'),
            ),
          ],
        ),
      ],
    );
  }
}
