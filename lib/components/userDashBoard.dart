import 'package:flutter/material.dart';
import 'package:preggo/tools/sharedPreferences.dart';
import 'package:preggo/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserDashboard extends StatefulWidget {
  @override
  State<UserDashboard> createState() => _UserDashboardState();
}

class _UserDashboardState extends State<UserDashboard> {
  dynamic dueDate;

  Future<void> getData() async {
    String dueDatefromDB = await getStringfromSP('dueDate') ?? "no due date";
    String _dueDate = dueDatefromDB;
    setState(() {
      dueDate = _dueDate;
    });
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text('This is a date', style: kGoogleTitle),
        Text(dueDate.toString(), style: kGoogleTitle),
        Text('Things To Do Today', style: kGoogleTitle),
      ],
    );
  }
}
