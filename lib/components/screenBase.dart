import 'package:flutter/material.dart';
import 'menu.dart';

class ScreenBaseScaffold extends StatelessWidget {
  final Widget scaffoldBody;

  ScreenBaseScaffold({required this.scaffoldBody});

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
