import 'package:preggo/shared/constants.dart';
import 'package:preggo/models/pregnancy.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:preggo/services/sharedfunctions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserInfo extends StatefulWidget {
  const UserInfo({Key? key}) : super(key: key);

  @override
  State<UserInfo> createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<List<PregnancyInfo>?>(context);

    if (user != null) {
      String date = user.first.date;
      String duedate = toPrettyDateMMMddyyyy(user.first.epochduedate);
      // DateTime.fromMillisecondsSinceEpoch(user.first.epochduedate)
      //     .toString();
      String weight = user.first.weight;

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
            weight,
            style: kGoogleTitle,
          )
        ],
      );
    } else {
      return Text('Information not found');
    }
  }
}
