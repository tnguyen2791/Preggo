import 'package:flutter/material.dart';
import 'constants.dart';
import 'reusablecard.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Homepage extends StatelessWidget {
  Homepage({Key? key}) : super(key: key);

  DateTime now = DateTime.now();
  String formattedDate =
      '${DateTime.now().month}/${DateTime.now().day}/${DateTime.now().year}';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pregnancy Weight App'),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.baby_changing_station,
            ),
            onPressed: () {
              print('hello');
            },
          )
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: const [
            DrawerHeader(
              child: Center(
                child: Text(
                  'Menu to App!',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ),
            ListTile(
              title: Text(
                'Home',
                style: kMenuTextStyle,
              ),
            ),
            ListTile(
              title: Text(
                'Weigh-In',
                style: kMenuTextStyle,
              ),
            ),
            ListTile(
              title: Text(
                'Food Diary',
                style: kMenuTextStyle,
              ),
            ),
            ListTile(
              title: Text(
                'Water Intake',
                style: kMenuTextStyle,
              ),
            ),
            ListTile(
              title: Text(
                'Blood Sugar Log',
                style: kMenuTextStyle,
              ),
            ),
            ListTile(
              title: Text(
                'Export Information',
                style: kMenuTextStyle,
              ),
            ),
            ListTile(
              title: Text(
                'Resources',
                style: kMenuTextStyle,
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(formattedDate, style: kTitleTextStyle),
                Text('28 Weeks pregnant!!', style: kTitleTextStyle),
                Text('Things To Do Today', style: kTitleTextStyle),
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
                      colour: Colors.grey,
                      onPress: () {
                        print('Hello');
                      },
                      cardDescription: const Text(
                        'Weigh in!',
                        style: kMenuTextStyle,
                      ),
                      cardIcon: const Icon(
                        FontAwesomeIcons.weightScale,
                        size: 40.0,
                      ),
                    ), //Weighing in
                    ReusableCard(
                      colour: Colors.grey,
                      onPress: () {
                        print('Hello');
                      },
                      cardDescription: const Text(
                        'Are you hydrated?',
                        style: kMenuTextStyle,
                      ),
                      cardIcon: const Icon(
                        FontAwesomeIcons.droplet,
                        size: 40.0,
                      ),
                    ), //Hydration
                    ReusableCard(
                      colour: Colors.grey,
                      onPress: () {
                        print('Hello');
                      },
                      cardDescription: const Text(
                        'Exercise Regimen',
                        style: kMenuTextStyle,
                      ),
                      cardIcon: const Icon(
                        FontAwesomeIcons.dumbbell,
                        size: 40.0,
                      ),
                    ), //Exercise Regimen
                    ReusableCard(
                      colour: Colors.grey,
                      onPress: () {
                        print('Hello');
                      },
                      cardDescription: const Text(
                        'Diet',
                        style: kMenuTextStyle,
                      ),
                      cardIcon: const Icon(
                        FontAwesomeIcons.carrot,
                        size: 40.0,
                      ),
                    ), //Diet
                    ReusableCard(
                      colour: Colors.grey,
                      onPress: () {
                        print('Hello');
                      },
                      cardDescription: const Text(
                        'Resources',
                        style: kMenuTextStyle,
                      ),
                      cardIcon: const Icon(
                        FontAwesomeIcons.boxArchive,
                        size: 40.0,
                      ),
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
