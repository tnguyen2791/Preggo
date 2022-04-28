import 'package:flutter/material.dart';
import 'package:preggo/components/screenBase.dart';
import 'package:preggo/constants.dart';

class Resources extends StatelessWidget {
  const Resources({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenBaseScaffold(
      scaffoldBody: Column(
        children: [
          Container(
            child: Text(
              'Resource',
              style: kGoogleTitle,
            ),
          ),
          Container(
            child: Text(
              'Description',
              style: kGoogleDescription,
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.red,
            ),
          ),
        ],
      ),
    );
  }
}
