import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:preggo/shared/constants.dart';

class OnTrackGrowth extends StatelessWidget {
  const OnTrackGrowth({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const CircleAvatar(
          backgroundColor: Colors.green,
          radius: 50,
          child: Icon(
            FontAwesomeIcons.faceSmile,
            color: Colors.yellow,
            size: 100.0,
          ),
        ),
        const SizedBox(
          height: 50,
        ),
        Text(
          'Baby is doing good!\nYou are on track for weight gain.',
          style: kGoogleDescription,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

class UnderweightGrowth extends StatelessWidget {
  const UnderweightGrowth({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const CircleAvatar(
          backgroundColor: Colors.orange,
          radius: 50,
          child: Icon(
            FontAwesomeIcons.faceMeh,
            color: Colors.white,
            size: 100.0,
          ),
        ),
        const SizedBox(
          height: 50,
        ),
        Text(
          'Growth is below normal at this gestational period',
          style: kGoogleDescription,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

class OverweightGrowth extends StatelessWidget {
  const OverweightGrowth({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const CircleAvatar(
          backgroundColor: Colors.orange,
          radius: 50,
          child: Icon(
            FontAwesomeIcons.faceMeh,
            color: Colors.white,
            size: 100.0,
          ),
        ),
        const SizedBox(
          height: 50,
        ),
        Text(
          'Growth is above normal at this gestational period',
          style: kGoogleDescription,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
