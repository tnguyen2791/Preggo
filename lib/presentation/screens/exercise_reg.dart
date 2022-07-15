import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:preggo/services/auth.dart';
import 'package:preggo/shared/constants.dart';
import 'package:preggo/shared/restartwidget.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ExerciseRegimen extends StatelessWidget {
  static const String id = 'exercise_screen';

  const ExerciseRegimen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                AuthService().signOut();
                RestartWidget.restartApp(context);
              },
              icon: const Icon(FontAwesomeIcons.powerOff))
        ],
        title: const Text("Exercise"),
      ),
      body: Column(
        children: [
          Text(
            'Exercise Regimen',
            style: kGoogleTitle,
          ),
          Text(
            'Description',
            style: kGoogleDescription,
          ),
          Center(
            child: Image.network(
              'https://www.ambitiouskitchen.com/wp-content/uploads/2019/11/pregnancyqa-pin.jpg',
              height: MediaQuery.of(context).size.height * 0.75,
              loadingBuilder: (BuildContext context, Widget child,
                  ImageChunkEvent? loadingProgress) {
                if (loadingProgress == null) return child;
                return LoadingAnimationWidget.hexagonDots(
                    color: Colors.white, size: 100);
              },
            ),
          ),
        ],
      ),
    );
  }
}
