import 'package:flutter/material.dart';
import 'package:preggo/constants.dart';

class WaterTotal extends StatefulWidget {
  
  

  @override
  State<WaterTotal> createState() => _WaterTotalState();

}

class _WaterTotalState extends State<WaterTotal> {

  @override
  Widget build(BuildContext context) {
    return Text(' oz today',
        style: kGoogleDescription.copyWith(fontSize: 80.0));
  }


}