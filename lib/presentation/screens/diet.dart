import 'package:flutter/material.dart';
import 'package:preggo/services/auth.dart';
import 'package:preggo/shared/constants.dart';
import 'package:preggo/shared/restartwidget.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Diet extends StatelessWidget {
  static const String id = 'diet_screen';

  const Diet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                AuthService().signOut();
                RestartWidget.restartApp(context);
              },
              icon: const Icon(FontAwesomeIcons.powerOff))
        ],
        title: const Text('Diet [Placeholder]'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Diet',
            style: kGoogleTitle,
          ),
          Text(
            'Description',
            style: kGoogleDescription,
          ),
          Expanded(
            child: Image.network(
                'https://femina.wwmindia.com/content/2020/jul/pregnancy-diet-chart-infographic.jpg'),
          ),
        ],
      ),
    );
  }
}
