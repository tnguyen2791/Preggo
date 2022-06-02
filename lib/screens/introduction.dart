//Todo: Creation of introduction screen https://pub.dev/packages/introduction_screen

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:preggo/screens/home.dart';

class OnBoardingPage extends StatefulWidget {
  static String id = 'intro_screen';

  const OnBoardingPage({Key? key}) : super(key: key);

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  @override
  void initState() {
    _loadDisclaimer();
    super.initState();
  }

  final introKey = GlobalKey<IntroductionScreenState>();
  String? _disclaimer;

  bool hxeating = false;
  bool hxsick = false;
  bool hxcontrol = false;
  bool hxsecret = false;
  bool hxconcern = false;
  bool _notapplicable = false;

  Future<void> _loadDisclaimer() async {
    final _loadedDisclaimer =
        await rootBundle.loadString('assets/texts/disclaimer.txt');
    setState(() {
      _disclaimer = _loadedDisclaimer;
    });
  }

  void _onIntroEnd(context) {
    Navigator.pushNamed(context, Homepage.id);
  }

  void toggleSwitch(bool value) {
    if (hxeating == false) {
      setState(() {
        hxeating = true;
      });
      print('Switch Button is ON');
    } else {
      setState(() {
        hxeating = false;
      });
      print('Switch Button is OFF');
    }
  }

  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      key: introKey,
      globalBackgroundColor: Colors.white,
      globalHeader: const Align(
        alignment: Alignment.topCenter,
        child: Placeholder(child: Text('Its really hot')),
      ),
      pages: [
        PageViewModel(
          title: "Disclaimer",
          bodyWidget: Text(_disclaimer ?? "Nothing"),
        ),
        PageViewModel(
          title: "Medical History",
          bodyWidget: Column(children: [
            SwitchListTile(
              title: const Text(
                  "Have you ever been diagnosed with disordered eating, whether related to pregnancy or not?"),
              value: hxeating,
              onChanged: (bool value) {
                setState(() {
                  hxeating = value;
                });
              },
              secondary: const Icon(FontAwesomeIcons.kitMedical),
            ),
            const ListTile(
              title: Center(
                child: Text('Do any of the following apply to you?'),
              ),
              leading: Icon(FontAwesomeIcons.carrot),
            ),
            SwitchListTile(
              title: const Text(
                  "Do you ever make yourself sick when you feel uncomfortably full?"),
              value: hxsick,
              onChanged: (bool value) {
                setState(() {
                  hxsick = value;
                });
              },
            ),
            SwitchListTile(
              title: const Text(
                  "Do you worry you have lost control over how much you eat?"),
              value: hxcontrol,
              onChanged: (bool value) {
                setState(() {
                  hxcontrol = value;
                });
              },
            ),
            SwitchListTile(
              title: const Text("Do you ever eat in secret?"),
              value: hxsecret,
              onChanged: (bool value) {
                setState(() {
                  hxsecret = value;
                });
              },
            ),
            SwitchListTile(
              title: const Text(
                  "Are you concerned with how much or how often you eat?"),
              value: hxconcern,
              onChanged: (bool value) {
                setState(() {
                  hxconcern = value;
                });
              },
            ),
          ]),
        ),
        PageViewModel(
          title: "Select Weigh-in Options",
          bodyWidget: Column(
            children: [
              (hxconcern || hxcontrol || hxeating || hxsecret || hxsick)
                  ? Text(
                      'You answered yes to either the question asking about a history of disordered eating or to the four screening questions for disordered eating. We strongly suggest bringing this up with your physician so that he or she can more fully care for you through your pregnancy and beyond. Since recording and viewing your weight may be triggering, this tool has the following options:')
                  : Text('Select an option for weighing-in!'),
              Text(
                  'Partner weighing: you weigh yourself weekly, but a partner logs your weigh in the app without you seeing the number. The number will only be visible when you export your data to your physician.'),
              TextButton(onPressed: null, child: Text('Partner Weigh-in')),
              Text(
                  "No-weigh option: you don't weigh yourself at all. You can still use all the other functions of the app, but skip the weekly weigh ins."),
              TextButton(onPressed: null, child: Text('No Weigh-in')),
              Text(
                  'Standard weigh-in: you weigh yourself weekly and log it using the default setting.'),
              TextButton(onPressed: null, child: Text('Regular Weigh-in')),
              Text(
                  'You can change your preference in the settings at any time.'),
              TextButton(
                  onPressed: (() {
                    Navigator.pushNamed(context, Homepage.id);
                  }),
                  child: Text('Done!'))
            ],
          ),
        )
      ],

      onDone: () => _onIntroEnd(context),
      // onSkip: () => _onIntroEnd(context), // You can override onSkip callback
      showSkipButton: false,
      skipOrBackFlex: 0,
      nextFlex: 0,
      showBackButton: true,
      back: const Text('Back'),
      showNextButton: true,
      next: const Text('Next'),
      //rtl: true, // Display as right-to-left
      isTopSafeArea: true,
      skip: const Text('Skip', style: TextStyle(fontWeight: FontWeight.w600)),
      showDoneButton: false,
      curve: Curves.fastLinearToSlowEaseIn,
      controlsMargin: const EdgeInsets.all(16),
    );
  }

  Widget _buildPopupDialog(BuildContext context) {
    return AlertDialog(
      title: const Text('Popup example'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const <Widget>[
          Text(
              "You answered yes to either the question asking about a history of disordered eating or to the four screening questions for disordered eating. We strongly suggest bringing this up with your physician so that he or she can more fully care for you through your pregnancy and beyond."),
        ],
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Close'),
        ),
      ],
    );
  }
}
