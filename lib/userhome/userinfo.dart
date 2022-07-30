import 'package:preggo/models/user.dart';
import 'package:preggo/shared/constants.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:preggo/services/sharedfunctions.dart';

import 'package:intl/intl.dart';

class UserDashboardInfo extends StatefulWidget {
  const UserDashboardInfo({Key? key}) : super(key: key);

  @override
  State<UserDashboardInfo> createState() => _UserDashboardInfoState();
}

class _UserDashboardInfoState extends State<UserDashboardInfo> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserData?>(context);
    if (user != null) {
      final int dbuserepoch = user.epochduedate;

      String date = daysLefttoDueDate(dbuserepoch);
      String duedate = toPrettyDateMMMddyyyy(dbuserepoch);
      // DateTime.fromMillisecondsSinceEpoch(user.first.epochduedate)
      //     .toString();
      String today = DateFormat('MMM-dd-yyyy').format(DateTime.now());

      return Column(
        children: [
          Text(
            date,
            style: kGoogleTitle,
          ),
          Text(
            'Due Date: $duedate',
            style: kGoogleTitle,
          ),
          Text(
            'Today: $today',
            style: kGoogleTitle,
          )
        ],
      );
    } else {
      return const Text('Information not found');
    }
  }
}
