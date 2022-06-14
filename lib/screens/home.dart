import 'package:flutter/material.dart';
import 'package:preggo/screens/diet.dart';
import 'package:preggo/screens/exercise_reg.dart';
import 'package:preggo/screens/growth_chart.dart';
import 'package:preggo/screens/resources.dart';
import 'package:preggo/screens/water_log.dart';
import '../components/reusableCard.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:preggo/components/base.dart';
import 'package:preggo/tools/sharedPreferences.dart';
import 'package:preggo/components/userDashBoard.dart';


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
          UserDashboard(),
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


// class userDashboard extends StatefulWidget {
//   const userDashboard({Key? key}) : super(key: key);

//   @override
//   State<userDashboard> createState() => _userDashboardState();
// }

// class _userDashboardState extends State<userDashboard> {
//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder(
//         future: getdueDate(),
//         builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
//           if (snapshot.hasData) {
//             return Expanded(
//               flex: 1,
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   Text('This is a date', style: kGoogleTitle),
//                   Text('${snapshot.data}', style: kGoogleTitle),
//                   Text('Things To Do Today', style: kGoogleTitle),
//                 ],
//               ),
//             );
//           } else {
//             return CircularProgressIndicator();
//           }
//         });
//   }
// }
