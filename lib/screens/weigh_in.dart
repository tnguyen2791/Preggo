import 'package:flutter/material.dart';
import 'package:preggo/components/screenBase.dart';

class WeighIn extends StatelessWidget {

static const String id = 'weigh_in_screen';

  @override
  Widget build(BuildContext context) {
    return ScreenBaseScaffold(
      titleText: "Weigh-In",
      scaffoldBody: Text('Hello!'),
    );
  }
}
