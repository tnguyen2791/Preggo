import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'water_total.dart';
import 'watervaluelisten.dart';

class WaterCounter extends StatefulWidget {
  WaterCounter({Key? key}) : super(key: key);

  @override
  State<WaterCounter> createState() => _WaterCounterState();
}

class _WaterCounterState extends State<WaterCounter> {
  @override
  Widget build(BuildContext context) {
    List droplets = [];

    for (int i = fluidsDrank.value; i > 0; i = (i - 8)) {
      droplets.add(WaterDropletFilled());
    }

    for (int i = (64 - fluidsDrank.value); i > 0; i = (i - 8)) {
      droplets.add(WaterDropletEmpty());
    }

    return Column(children: [
      GridView.count(
        crossAxisCount: 4,
        shrinkWrap: true,
        children: [
          ...droplets,
          // WaterDropletEmpty(),
          // WaterDropletEmpty(),
          // WaterDropletEmpty(),
        ],
      ),
      WaterTotal(),
    ]);
  }
}

class WaterDropletEmpty extends StatefulWidget {
  @override
  State<WaterDropletEmpty> createState() => _WaterDropletEmptyState();
}

class _WaterDropletEmptyState extends State<WaterDropletEmpty> {
  Color notDrinkColor = Colors.white;
  bool beenPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        child: Icon(
          FontAwesomeIcons.droplet,
          color: beenPressed ? Colors.blue : Colors.white,
          size: 80.0,
        ),
      ),
      onTap: () {
        setState(() {
          beenPressed = !beenPressed;
          beenPressed ? fluidsDrank.value += 8 : fluidsDrank.value -= 8;
          print(fluidsDrank.value);
        });
      },
    );
  }
}

class WaterDropletFilled extends StatefulWidget {
  @override
  State<WaterDropletFilled> createState() => _WaterDropletFilledState();
}

class _WaterDropletFilledState extends State<WaterDropletFilled> {
  Color notDrinkColor = Colors.white;
  bool beenPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        child: Icon(
          FontAwesomeIcons.droplet,
          color: beenPressed ? Colors.white : Colors.blue,
          size: 80.0,
        ),
      ),
      onTap: () {
        setState(() {
          beenPressed = !beenPressed;
          beenPressed ? fluidsDrank.value -= 8 : fluidsDrank.value += 8;
          print(fluidsDrank.value);
        });
      },
    );
  }
}

/*

The above is using fluidDrank as a notifier
The listener lives in a Listenable Builder
This took forever. Consideration of refactoring
Consideration of deletion of print statement.


 */