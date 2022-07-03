import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:preggo/shared/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

ValueNotifier<int> fluidsDrank = ValueNotifier(0);

class WaterCounter extends StatefulWidget {
  WaterCounter({Key? key}) : super(key: key);

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
          //redraw the above
        ],
      ),
      WaterTotal(),
    ]);
  }
}

class WaterDroplet extends StatefulWidget {
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
  final _prefs = SharedPreferences.getInstance();
  late Future<int> _waterTotal;

  Future<void> _addeightoz() async {
    final SharedPreferences prefs = await _prefs;
    final int waterTotal = (prefs.getInt('watertotal') ?? 0) + 1;

    setState(() {
      _waterTotal = prefs.setInt('watertotal', waterTotal).then((bool success) {
        return waterTotal;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _waterTotal = _prefs.then((SharedPreferences prefs) {
      return prefs.getInt('watertotal') ?? 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<int>(
      future: _waterTotal,
      builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return const CircularProgressIndicator();
          default:
            if (snapshot.hasError) {
              return Text(
                'Error: ${snapshot.error}',
                style: kGoogleDescription,
              );
            } else {
              return Text(
                'You drank ${snapshot.data} oz of water',
                style: kGoogleDescription,
              );
            }
        }
      },
    );
  }
}


//   @override
//   Widget build(BuildContext context) {
//     return ValueListenableBuilder<int>(
//       builder: (BuildContext context, int value, Widget? child) {
//         // This builder will only get called when the _counter
//         // is updated.
//         return Row(
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           children: <Widget>[
//             Text(
//               '$_waterTotal oz\ntoday!',
//               style: kGoogleDescription,
//             ),
//           ],
//         );
//       },
//       valueListenable: fluidsDrank,
//     );
//   }
// }

/*

The above is using fluidDrank as a notifier
The listener lives in a Listenable Builder
This took forever. Consideration of refactoring
Consideration of deletion of print statement.


 */