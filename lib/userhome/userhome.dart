import "package:flutter/material.dart";
import 'package:preggo/models/pregnancy.dart';
import 'package:preggo/models/user.dart';
import 'package:preggo/presentation/screens/all_screens.dart';
import 'package:preggo/services/database.dart';
import 'package:preggo/shared/shared.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'userinfo.dart';

class UserHomeScreen extends StatelessWidget {
  const UserHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModeling>(context);

    return StreamProvider<List<PregnancyInfo>?>.value(
      value: DatabaseService(uid: user.uid).userProfile,
      initialData: null,
      child: BaseScaffold(
        scaffoldBody: Column(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                UserInfo(),
              ],
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
                        navigationRoute: Settings.id,
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
      ),
    );
  }
}
