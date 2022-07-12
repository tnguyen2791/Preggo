import 'package:preggo/models/user.dart';
import 'package:preggo/shared/constants.dart';

import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:preggo/services/sharedfunctions.dart';

import 'package:intl/intl.dart';

class UserInfo extends StatefulWidget {
  const UserInfo({Key? key}) : super(key: key);

  @override
  State<UserInfo> createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserData?>(context);
    if (user != null) {
      final int dbuserepoch = user.epochduedate;
      final DateTime dbuserinDT =
          DateTime.fromMillisecondsSinceEpoch(dbuserepoch);
      final Duration difference = dbuserinDT.difference(DateTime.now());

      String date = '${difference.inDays.toString()} days left!';
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
