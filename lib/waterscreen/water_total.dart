import 'package:flutter/material.dart';
import 'package:preggo/shared/constants.dart';
import 'watervaluelisten.dart';

class WaterTotal extends StatefulWidget {
  const WaterTotal({Key? key}) : super(key: key);

  @override
  State<WaterTotal> createState() => _WaterTotalState();
}

class _WaterTotalState extends State<WaterTotal> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: fluidsDrank,
      builder: ((context, int fluid, child) {
        return Text('$fluid oz today',
            style: kGoogleDescription.copyWith(fontSize: 60.0));
      }),
    );
  }
}
