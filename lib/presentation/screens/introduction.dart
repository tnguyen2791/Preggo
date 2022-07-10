//Todo: Creation of introduction screen https://pub.dev/packages/introduction_screen

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:preggo/presentation/screens/eatingdisorderinfo.dart';
import 'package:preggo/presentation/screens/wrapper.dart';

class OnBoardingPage extends StatefulWidget {
  static String id = 'intro_screen';

  const OnBoardingPage({Key? key}) : super(key: key);

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  String? _disclaimer;

  @override
  void initState() {
    _loadDisclaimer();
    super.initState();
  }

/* The section to load the disclaimer */

  Future<void> _loadDisclaimer() async {
    final loadedDisclaimer =
        await rootBundle.loadString('assets/texts/disclaimer.txt');
    setState(() {
      _disclaimer = loadedDisclaimer;
    });
  }

  final introKey = GlobalKey<IntroductionScreenState>();

/* Area dedicated to the introduction page */

  void _onIntroEnd(context) {
    Navigator.pushNamed(context, Wrapper.id);
  }

  bool _agreeDisclaimer = false;

  bool hxeating = false;
  bool hxsick = false;
  bool hxcontrol = false;
  bool hxsecret = false;
  bool hxconcern = false;

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
          bodyWidget: Column(children: [
            Text(_disclaimer ?? "Nothing"),
            const Divider(
              thickness: 5,
              height: 50.0,
            ),
            Center(
              child: CheckboxListTile(
                  title: const Text('I agree with the  disclaimer.'),
                  value: _agreeDisclaimer,
                  onChanged: (bool? value) {
                    setState(() {
                      _agreeDisclaimer = value!;
                    });
                  }),
            ),
            !_agreeDisclaimer
                ? Text("Please check the disclaimer above!")
                : Text("Swipe left to the next screen!"),
          ]),
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
            Divider(),
            TextButton(
              style: TextButton.styleFrom(
                  primary: Colors.purple, backgroundColor: Colors.pink[100]),
              onPressed: (_agreeDisclaimer)
                  ? (() {
                      (hxconcern || hxcontrol || hxeating || hxsecret)
                          ? Navigator.pushReplacementNamed(
                              context, WeighInOptions.id)
                          : Navigator.pushReplacementNamed(context, Wrapper.id);
                    })
                  : null,
              child: const Text('Done!'),
            ),
            !_agreeDisclaimer
                ? const Text("Please accept the disclaimer!")
                : const Text('Welcome aboard!'),
          ]),
        ),
      ],

      onDone: () => _onIntroEnd(context),
      // onSkip: () => _onIntroEnd(context), // You can override onSkip callback
      showSkipButton: false,
      skipOrBackFlex: 0,
      nextFlex: 0,
      showBackButton: false,
      showNextButton: false,
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
