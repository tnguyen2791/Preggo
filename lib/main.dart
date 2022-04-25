import 'package:flutter/material.dart';
import 'home.dart';

void main() => runApp(PreggoApp());

class PreggoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: Homepage(),
    );
  }
}
