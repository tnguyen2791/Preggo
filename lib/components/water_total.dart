import 'package:flutter/material.dart';
import 'package:preggo/screens/water_log.dart';
import 'package:preggo/constants.dart';

class WaterTotal extends StatefulWidget {
  
  

  @override
  State<WaterTotal> createState() => _WaterTotalState();

}

class _WaterTotalState extends State<WaterTotal> {

  @override
  Widget build(BuildContext context) {
    return Text('${WaterLog.fluidsDrank} oz today',
        style: kGoogleDescription.copyWith(fontSize: 80.0));
  }

void updateWater (){
  setState(() {
  });
}

}