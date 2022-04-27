import 'package:flutter/material.dart';
import 'package:preggo/components/base.dart';

class WeighIn extends StatelessWidget {
  const WeighIn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(scaffoldBody: Text('Hello!'));
  }
}

class WaterDrops extends StatefulWidget {
  const WaterDrops({Key? key}) : super(key: key);

  @override
  State<WaterDrops> createState() => _WaterDropsState();
}

class _WaterDropsState extends State<WaterDrops> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('Hello!'),
    );
  }
}
