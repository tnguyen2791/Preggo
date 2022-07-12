import "package:flutter/material.dart";
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
      catchError: (context, error) {
        print('an error has occurred $error');
        print(user.uid);
        return UserData();
      },
      value: DatabaseService(uid: user.uid).userData,
      initialData: UserData(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          leading: const Hero(
            tag: 'logo',
            child: CircleAvatar(
                radius: 150.0,
                backgroundImage: AssetImage('assets/icon/icon.png')
                // ,
                ),
          ),
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
      ),
    );
  }
}
