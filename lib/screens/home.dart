import 'package:flutter/material.dart';
import 'package:preggo/constants.dart';
import 'package:preggo/screens/diet.dart';
import 'package:preggo/screens/exercise_reg.dart';
import 'package:preggo/screens/growth_chart.dart';
import 'package:preggo/screens/resources.dart';
import 'package:preggo/screens/water_log.dart';
import '../components/reusableCard.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:preggo/components/base.dart';

class Homepage extends StatelessWidget {
  Homepage({Key? key}) : super(key: key);

  static const String id = 'homepage_screen';

  DateTime now = DateTime.now();
  String formattedDate =
      '${DateTime.now().month}/${DateTime.now().day}/${DateTime.now().year}';

  //Todo: Implementation of the ICON into the android and iOS folders.
  //TODO: Creation of the launcher icon https://pub.dev/packages/flutter_launcher_icons

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      scaffoldBody: Column(
        children: [
          Expanded(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(formattedDate, style: kGoogleTitle),
                Text('28 Weeks pregnant!!!', style: kGoogleTitle),
                Text('Things To Do Today', style: kGoogleTitle),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ReusableCard(
                      navigationRoute: GrowthChart.id,
                      cardDescription: 'Weigh-in!',
                      cardIcon: FontAwesomeIcons.weightScale,
                    ), //Weighing in
                    ReusableCard(
                      navigationRoute: WaterLog.id,
                      cardDescription: 'Are you hydrated?',
                      cardIcon: FontAwesomeIcons.droplet,
                    ), //Hydration
                    ReusableCard(
                      navigationRoute: ExerciseRegimen.id,
                      cardDescription: 'Exercise Regimen',
                      cardIcon: FontAwesomeIcons.dumbbell,
                    ), //Exercise Regimen
                    ReusableCard(
                      navigationRoute: Diet.id,
                      cardDescription: 'Diet',
                      cardIcon: FontAwesomeIcons.carrot,
                    ), //Diet
                    ReusableCard(
                      navigationRoute: Resources.id,
                      cardDescription: 'Resources',
                      cardIcon: FontAwesomeIcons.boxArchive,
                    ), //Resources
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
