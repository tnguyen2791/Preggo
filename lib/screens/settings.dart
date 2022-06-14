import 'dart:io';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:preggo/components/base.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:flutter/material.dart';
import 'package:preggo/components/screenBase.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:preggo/tools/sharedPreferences.dart';

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
  final Future<SharedPreferences> _pref = SharedPreferences.getInstance();
  late Future<bool> _userAgreement;
  bool? settingUserAgreement;

  bool theme2 = false;
  bool toggle1 = true;

  String? _dueDate;
  double? preconweight;
  bool settingsChanges = false;

  void refreshData() async {
    final pref = await SharedPreferences.getInstance();
    setState(() {
      _dueDate = pref.getString("dueDate") ?? 'Enter due date!';
      preconweight = pref.getDouble('preconweight') ?? 0.0;
    });
  }

  @override
  void initState() {
    refreshData();
    super.initState();
  }
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
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
      cancelText: "are you sure?",
    ).then((date) async {
      if (date == null) {
        return;
      } else {
        final prefs = await SharedPreferences.getInstance();
        String? aString = '';

        String dueDateYear = date.year.toString();
        String dueDateMonth = date.month.toString();
        String dueDateDay = date.day.toString();

        await prefs.setString(
            'dueDate', '$dueDateDay-$dueDateMonth-$dueDateYear');
        aString = prefs.getString('dueDate');
        print(aString);
        setState(() {
          _dueDate = "$dueDateDay $dueDateMonth $dueDateYear";
        });
      }
      ;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SettingsList(
      sections: [
        SettingsSection(
          title: Text('Childing Application App'),
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
            SettingsTile(
              title: Text('Due Date'),
              leading: Icon(FontAwesomeIcons.baby),
              trailing: Text(_dueDate ?? 'none'),
              onPressed: enterDueDate,
            ),
            SettingsTile(
              title: Text('Pre-Pregnancy Weight'),
              trailing: Text(preconweight.toString()),
              onPressed: _weightInput,
            ),
            SettingsTile.switchTile(
              initialValue: false,
              onToggle: (value) {
                print:
                Text('switched');
              },
              title: Text('Text'),
            ),
          ],
        ),
      ],
    );
  }
}
