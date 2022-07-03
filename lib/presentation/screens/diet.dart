import 'package:flutter/material.dart';
import 'package:preggo/shared/shared.dart';
import 'package:preggo/shared/constants.dart';

class Diet extends StatelessWidget {
  static const String id = 'diet_screen';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              child: Text(
                'Diet',
                style: kGoogleTitle,
              ),
            ),
            Container(
              child: Text(
                'Description',
                style: kGoogleDescription,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
