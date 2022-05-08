import 'package:flutter/material.dart';
import 'package:preggo/constants.dart';
import '../components/reusableCard.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:preggo/components/base.dart';

class Homepage extends StatelessWidget {
  Homepage({Key? key}) : super(key: key);

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
                Text('28 Weeks pregnant!!', style: kGoogleTitle),
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
                      navigationRoute: '/GrowthChart',
                      cardDescription: 'Weigh-in!',
                      cardIcon: FontAwesomeIcons.weightScale,
                    ), //Weighing in
                    ReusableCard(
                      navigationRoute: '/WaterLog',
                      cardDescription: 'Are you hydrated?',
                      cardIcon: FontAwesomeIcons.droplet,
                    ), //Hydration
                    ReusableCard(
                      navigationRoute: '/ExerciseRegimen',
                      cardDescription: 'Exercise Regimen',
                      cardIcon: FontAwesomeIcons.dumbbell,
                    ), //Exercise Regimen
                    ReusableCard(
                      navigationRoute: '/Diet',
                      cardDescription: 'Diet',
                      cardIcon: FontAwesomeIcons.carrot,
                    ), //Diet
                    ReusableCard(
                      navigationRoute: '/Resources',
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
