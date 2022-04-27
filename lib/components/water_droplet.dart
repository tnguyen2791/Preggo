import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class WaterDroplet extends StatefulWidget {
  const WaterDroplet({Key? key}) : super(key: key);

  @override
  State<WaterDroplet> createState() => _WaterDropletState();
}

class _WaterDropletState extends State<WaterDroplet> {
  Color dropColor = Colors.white;
  bool beenPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Icon(
        FontAwesomeIcons.droplet,
        color: beenPressed ? Colors.blue : Colors.white,
      ),
      onTap: () {
        setState(() {
          beenPressed = !beenPressed;
        });
      },
    );
  }
}
