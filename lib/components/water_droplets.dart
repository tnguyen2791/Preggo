import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:preggo/screens/water_log.dart';
import 'package:preggo/constants.dart';

ValueNotifier<int> fluidsDrank = ValueNotifier(0);

class WaterCounter extends StatefulWidget {
  const WaterCounter({Key? key}) : super(key: key);

  @override
  State<WaterCounter> createState() => _WaterCounterState();
}

class _WaterCounterState extends State<WaterCounter> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      GridView.count(
        crossAxisCount: 4,
        shrinkWrap: true,
        children: [
          WaterDroplet(),
          WaterDroplet(),
          WaterDroplet(),
          WaterDroplet(),
          WaterDroplet(),
          WaterDroplet(),
          WaterDroplet(),
          WaterDroplet(),
        ], 
      ),WaterTotal(),
    ]);
  }
}

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
      child: Container(
        margin: const EdgeInsets.all(3.0),
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

class WaterTotal extends StatefulWidget {
  @override
  State<WaterTotal> createState() => _WaterTotalState();
}

class _WaterTotalState extends State<WaterTotal> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
        builder: (BuildContext context, int value, Widget? child) {
      // This builder will only get called when the _counter
      // is updated.
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Text('$value oz\ntoday!', style: kGoogleDescription.copyWith(fontSize: 80.0),),
        ],
      );
    }, valueListenable: fluidsDrank,);
  }
}

/*

The above is using fluidDrank as a notifier
The listener lives in a Listenable Builder
This took forever. Consideration of refactoring
Consideration of deletion of print statement.


 */