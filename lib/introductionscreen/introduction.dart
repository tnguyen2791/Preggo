import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:preggo/presentation/screens/wrapper.dart';
import 'package:preggo/introductionscreen/datacollectionform.dart';
import 'package:preggo/introductionscreen/disclaimerdialogue.dart';

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
  final GlobalKey<ScaffoldState> scaffoldkey = GlobalKey<ScaffoldState>();

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
    } else {
      setState(() {
        hxeating = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      key: scaffoldkey,
      globalBackgroundColor: Colors.white,
      globalHeader: const Align(
        alignment: Alignment.topCenter,
        child: Placeholder(child: Text('Its really hot')),
      ),
      pages: [
        PageViewModel(
          title: "Welcome to Childing",
          bodyWidget: Column(children: [
            const Hero(
              tag: 'logo',
              child: Padding(
                padding: EdgeInsets.only(bottom: 20),
                child: CircleAvatar(
                    radius: 100.0,
                    backgroundImage: AssetImage('assets/icon/icon.png')),
              ),
            ),
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
                ? const Text("Please check the disclaimer above!")
                : const Text("Swipe left to the next screen!"),
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
            const Divider(),
            TextButton(
              style: TextButton.styleFrom(
                  primary: Colors.purple, backgroundColor: Colors.pink[100]),
              onPressed: (_agreeDisclaimer)
                  ? (() {
                      (hxconcern || hxcontrol || hxeating || hxsecret)
                          ? showDialog(
                              context: context,
                              builder: (context) {
                                return const WeighingDisclaimer();
                              })
                          : Navigator.pushReplacementNamed(
                              context, DataCollectionScreen.id);
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
      showSkipButton: false,
      skipOrBackFlex: 0,
      nextFlex: 0,
      showBackButton: false,
      showNextButton: false,
      isTopSafeArea: true,
      skip: const Text('Skip', style: TextStyle(fontWeight: FontWeight.w600)),
      showDoneButton: false,
      curve: Curves.fastLinearToSlowEaseIn,
      controlsMargin: const EdgeInsets.all(16),
    );
  }
}
