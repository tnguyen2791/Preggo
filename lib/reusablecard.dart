import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ReusableCard extends StatelessWidget {
  final Color colour;
  final Function onPress;
  final Text cardDescription;
  final Icon cardIcon;

  ReusableCard({
    required this.colour,
    required this.onPress,
    required this.cardDescription,
    required this.cardIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          print('tap detected');
        },
        child: Container(
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: cardIcon,
              ),
              Expanded(
                flex: 2,
                child: cardDescription,
              ),
            ],
          ),
          margin: EdgeInsets.all(5.0),
          decoration: BoxDecoration(
            color: colour,
            borderRadius: BorderRadius.all(
              Radius.circular(25.0),
            ),
          ),
        ),
      ),
    );
  }
}
