import "package:flutter/material.dart";
import 'package:preggo/models/user.dart';
import 'package:preggo/presentation/screens/all_screens.dart';
import 'package:preggo/services/auth.dart';
import 'package:preggo/shared/constants.dart';
import 'package:preggo/shared/shared.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:preggo/userhome/anonymouswarningdialogue.dart';
import 'package:provider/provider.dart';
import 'userinfo.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserHomeScreen extends StatelessWidget {
  static String id = 'homescreen';

  const UserHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<UserData>(context);
    final fbuseranon = FirebaseAuth.instance.currentUser?.isAnonymous;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: const Hero(
          tag: 'logo',
          child: CircleAvatar(
              radius: 150.0,
              backgroundImage: AssetImage('assets/icon/icon.png')),
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
              if (fbuseranon!) {
                showDialog(
                  context: context,
                  builder: ((context) =>
                      const AnonymousLogoutWarningAlertDialogue()),
                );
              } else {
                AuthService().signOut().whenComplete(
                    () => ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(
                          'Logged Out',
                          style: kGoogleDescription,
                          textAlign: TextAlign.center,
                        ))));
              }
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const SizedBox(
                height: 10.0,
              ),
              CircleAvatar(
                radius: MediaQuery.of(context).size.height / 12,
                backgroundColor: Colors.white,
                child: Icon(
                  FontAwesomeIcons.baby,
                  size: MediaQuery.of(context).size.height / 9,
                  color: Colors.deepPurple,
                ),
              ),
              const UserDashboardInfo(),
            ],
          ),
          Expanded(
            flex: 2,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    if (userData.weighpref != 'No Weight')
                      const ReusableCard(
                        childingNavigationRoute: GrowthChart.id,
                        childingCardDescription: 'Pregnancy Growth',
                        childingCardIcon: FontAwesomeIcons.weightScale,
                      ), //Weighing in
                    const ReusableCard(
                      childingNavigationRoute: WaterLog.id,
                      childingCardDescription: 'Are you hydrated?',
                      childingCardIcon: FontAwesomeIcons.droplet,
                    ), //Hydration
                    const ReusableCard(
                      childingNavigationRoute: ExerciseRegimen.id,
                      childingCardDescription: 'Exercise Regimen',
                      childingCardIcon: FontAwesomeIcons.dumbbell,
                    ), //Exercise Regimen
                    const ReusableCard(
                      childingNavigationRoute: Diet.id,
                      childingCardDescription: 'Diet',
                      childingCardIcon: FontAwesomeIcons.carrot,
                    ), //Diet
                    const ReusableCard(
                      childingNavigationRoute: Resources.id,
                      childingCardDescription: 'Resources',
                      childingCardIcon: FontAwesomeIcons.boxArchive,
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
