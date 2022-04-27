import 'package:flutter/material.dart';
import 'menu.dart';

class BaseScaffold extends StatelessWidget {
  final Widget scaffoldBody;

  BaseScaffold({required this.scaffoldBody});

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
              print('hello');
            },
          )
        ],
      ),
      drawer: MenuBase(),
      body: scaffoldBody,
    );
  }
}
