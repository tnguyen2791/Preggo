import "package:flutter/material.dart";
import 'package:preggo/login/login.dart';
import 'package:preggo/models/pregnancy.dart';
import 'package:preggo/models/user.dart';
import 'package:preggo/presentation/screens/all_screens.dart';
import 'package:preggo/presentation/screens/datacollectionform.dart';
import 'package:preggo/services/database.dart';
import 'package:preggo/services/auth.dart';
import 'package:preggo/shared/shared.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'userinfo.dart';

class UserHomeScreen extends StatelessWidget {
            
  static String id = 'homescreen';

  const UserHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserUID>(context);

    return StreamProvider<UserData>.value(
      value: DatabaseService(uid: user.uid).userData,
      initialData: UserData(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Homescreen'),
          actions: [
            IconButton(
              icon: const Icon(
                Icons.settings,
              ),
              onPressed: () {
                Navigator.pushNamed(context, Settings.id);
              },
            ),
            IconButton(
              icon: const Icon(
                Icons.logout,
              ),
              onPressed: () {
                AuthService().signOut();
              },
            ),
          ],
        ),
        body: Column(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const [
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
                        navigationRoute: DataCollectionScreen.id,
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
