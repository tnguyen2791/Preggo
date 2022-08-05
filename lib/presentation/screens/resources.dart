import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:preggo/shared/constants.dart';
import 'package:url_launcher/url_launcher.dart';

class Resources extends StatelessWidget {
  static const String id = 'resources_screen';

  const Resources({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Resources"),
      ),
      body: Column(
        children: [
          Text(
            'Resources',
            style: kGoogleTitle,
            textAlign: TextAlign.center,
          ),
          Text(
            'Extra tools below to help during this journey!',
            style: kGoogleDescription,
            textAlign: TextAlign.center,
          ),
          GridView(
            padding: const EdgeInsets.all(12.0),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 5,
              mainAxisSpacing: 5,
            ),
            shrinkWrap: true,
            children: const [
              GridWidget(
                nameofCard: "Prenatal Care",
                iconforCard: FontAwesomeIcons.personRunning,
                urlLink:
                    "https://www.womenshealth.gov/pregnancy/youre-pregnant-now-what/prenatal-care-and-tests",
              ),
              GridWidget(
                nameofCard: "Stages of Pregnancy",
                iconforCard: FontAwesomeIcons.babyCarriage,
                urlLink:
                    "https://www.womenshealth.gov/pregnancy/youre-pregnant-now-what/stages-pregnancy",
              ),
              GridWidget(
                nameofCard: "Body Changes",
                iconforCard: FontAwesomeIcons.heartPulse,
                urlLink:
                    "https://www.womenshealth.gov/pregnancy/youre-pregnant-now-what/body-changes-and-discomforts",
              ),
              GridWidget(
                nameofCard: "Health Tips",
                iconforCard: FontAwesomeIcons.staffAesculapius,
                urlLink:
                    "https://www.womenshealth.gov/pregnancy/youre-pregnant-now-what/staying-healthy-and-safe",
              ),
            ],
          ),
          Image(
              image: const AssetImage('assets/png/babycarriage.png'),
              height: MediaQuery.of(context).size.height * 0.25,
              fit: BoxFit.fitWidth),
        ],
      ),
    );
  }
}

class GridWidget extends StatelessWidget {
  final IconData iconforCard;
  final String nameofCard;
  final VoidCallback? tappingFunction;
  final String urlLink;

  const GridWidget({
    this.iconforCard = FontAwesomeIcons.question,
    this.nameofCard = "Empty Resource",
    this.urlLink = "https://www.google.com",
    this.tappingFunction,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void _launchURL() async {
      Uri uri = Uri.parse(urlLink);

      if (await canLaunchUrl(uri)) {
        await launchUrl(uri);
      } else {
        throw 'Could not launch $urlLink';
      }
    }

    return Card(
      borderOnForeground: true,
      margin: const EdgeInsets.all(8.0),
      elevation: 10.0,
      shadowColor: Colors.black,
      color: Colors.pink,
      child: GestureDetector(
        onTap: _launchURL,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Icon(
                  iconforCard,
                  color: Colors.white,
                  size: 80,
                ),
              ),
              Text(
                nameofCard,
                style: kGoogleDescription,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
