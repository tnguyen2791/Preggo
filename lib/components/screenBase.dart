import 'package:flutter/material.dart';

class ScreenBaseScaffold extends StatelessWidget {
  final Widget scaffoldBody;

  ScreenBaseScaffold({required this.scaffoldBody});

  //TODO: Can use the circle avatar for the home screen and icon. https://api.flutter.dev/flutter/material/CircleAvatar-class.html
  //TODO: Create a splash screen https://pub.dev/packages/flutter_native_splash
  //TODO: Make a sliver app bar https://api.flutter.dev/flutter/material/SliverAppBar-class.html

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dat App Tho'),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.baby_changing_station,
            ),
            onPressed: () {
              print('Hello');
            },
          )
        ],
      ),
      body: scaffoldBody,
    );
  }
}
