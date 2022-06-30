import 'package:flutter/material.dart';
import 'package:preggo/services/auth.dart';
import 'menu.dart';
import 'package:flutter/services.dart';

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
              AuthService().signOut();
            },
          )
        ],
      ),
      drawer: MenuBase(),
      body: scaffoldBody,
    );
  }
}
