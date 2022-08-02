import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:preggo/models/user.dart';
import 'package:preggo/services/database.dart';

class WeighSelection extends StatefulWidget {
  const WeighSelection({Key? key}) : super(key: key);

  @override
  State<WeighSelection> createState() => _WeighSelectionState();
}

class _WeighSelectionState extends State<WeighSelection> {
  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<UserData>(context);
    final user = Provider.of<UserUID>(context);

    String dropdownValue = userData.weighpref;

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
        if (mounted) {
          setState(() {
          dropdownValue = newValue;
        });
        }
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
