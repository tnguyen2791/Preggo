import 'package:flutter/material.dart';
import 'package:preggo/shared/constants.dart';

class Resources extends StatelessWidget {
  static const String id = 'resources_screen';

  const Resources({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Resources [Placeholder]"),
      ),
      body: Column(
        children: [
          Text(
            'Resource',
            style: kGoogleTitle,
          ),
          Text(
            'Description',
            style: kGoogleDescription,
          ),
          Center(
            child: Image.network(
              'https://i.pinimg.com/736x/af/f9/c1/aff9c15444220ed9832394b21282a39c.jpg',
              height: MediaQuery.of(context).size.height * 0.75,
            ),
          ),
        ],
      ),
    );
  }
}
