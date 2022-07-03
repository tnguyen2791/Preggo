import 'package:flutter/material.dart';
import 'package:preggo/presentation/screens/wrapper.dart';
import 'package:flutter/services.dart';
import 'package:preggo/services/auth.dart';

class ScreenBaseScaffold extends StatelessWidget {
  final Widget scaffoldBody;
  String titleText;

  ScreenBaseScaffold({required this.scaffoldBody, required this.titleText});

  //TODO: Can use the circle avatar for the home screen and icon. https://api.flutter.dev/flutter/material/CircleAvatar-class.html
  //TODO: Create a splash screen https://pub.dev/packages/flutter_native_splash
  //TODO: Make a sliver app bar https://api.flutter.dev/flutter/material/SliverAppBar-class.html

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () {
            Navigator.pop(
                context, MaterialPageRoute(builder: (context) => Wrapper()));
          },
        ),
        title: Text(titleText),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.baby_changing_station,
            ),
            onPressed: () {
              AuthService().signOut();
            },
          )
        ],
      ),
      body: scaffoldBody,
    );
  }
}
