import 'package:flutter/material.dart';
import 'menu.dart';

class BaseScaffold extends StatelessWidget {
  final Widget scaffoldBody;

  BaseScaffold({required this.scaffoldBody});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Childing"),
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
      drawer: MenuBase(),
      body: scaffoldBody,
    );
  }
}
