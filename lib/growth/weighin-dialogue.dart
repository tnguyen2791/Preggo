import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:preggo/models/user.dart';
import 'package:provider/provider.dart';
import 'package:preggo/services/database.dart';

Future logWeight1(Map loggedweight, String uid) async {
  final CollectionReference childingCollection =
      FirebaseFirestore.instance.collection('childing');
  return await childingCollection.doc(uid).update({
    'loggedweight': loggedweight,
  });
}

Future<void> logWeight(BuildContext context) async {
  final user = Provider.of<UserUID>(context, listen: false);

  return showDialog(
      context: context,
      builder: (context) {
        String loggedweight = 'test';
        Map toImport = {
          'time': "time",
        };

        return AlertDialog(
          title: const Text('testings'),
          content: Column(children: [
            TextField(
              onChanged: (value) => loggedweight = value,
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('go back'),
            ),
            ElevatedButton(
              onPressed: () {
                logWeight1(toImport, user.uid);
              },
              child: const Text('Log it'),
            ),
          ]),
        );
      });
}
