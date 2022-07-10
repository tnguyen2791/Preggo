import 'package:flutter/material.dart';
import 'package:preggo/shared/shared.dart';
import 'package:preggo/shared/constants.dart';

class Resources extends StatelessWidget {
  static const String id = 'resources_screen';

  const Resources({Key? key}) : super(key: key);

  //TODO: You can use the URL Launcher to create links

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Resources"),
      ),
      body: Column(
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
