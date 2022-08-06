import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:preggo/shared/constants.dart';

class OnTrackGrowth extends StatelessWidget {
  const OnTrackGrowth({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const CircleAvatar(
            backgroundColor: Colors.green,
            radius: 50,
            child: Icon(
              FontAwesomeIcons.faceSmile,
              color: Colors.white,
              size: 100.0,
            ),
          ),
          Text(
            'You are on track!',
            style: kGoogleDescription,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class UnderweightGrowth extends StatelessWidget {
  const UnderweightGrowth({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const CircleAvatar(
            backgroundColor: Colors.green,
            radius: 50,
            child: Icon(
              FontAwesomeIcons.arrowDown,
              color: Colors.white,
              size: 100.0,
            ),
          ),
          Text(
            'Growth is currently below normal\nat this gestational period',
            style: kGoogleDescription,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class OverweightGrowth extends StatelessWidget {
  const OverweightGrowth({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const CircleAvatar(
            backgroundColor: Colors.green,
            radius: 50,
            child: Icon(
              FontAwesomeIcons.arrowUp,
              color: Colors.white,
              size: 100.0,
            ),
          ),
          Text(
            'Growth is higher than\nusual at this point',
            style: kGoogleDescription,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
