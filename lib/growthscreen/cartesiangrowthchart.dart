import 'package:flutter/material.dart';

import 'package:preggo/models/user.dart';

import 'package:syncfusion_flutter_charts/charts.dart';

import 'weightlogmodel.dart';

class CartesianGrowthChart extends StatelessWidget {
  const CartesianGrowthChart({
    Key? key,
    required this.userData,
    required this.lowerlimitlist,
    required this.upperlimitlist,
    required this.modeleduserWeightList,
  }) : super(key: key);

  final UserData userData;
  final List<WeightModel> lowerlimitlist;
  final List<WeightModel> upperlimitlist;
  final List<WeightModel> modeleduserWeightList;

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
        backgroundColor: Colors.white,
        borderColor: Colors.red,
        borderWidth: 2.0,
        primaryXAxis: NumericAxis(
            maximum: 40,
            minorTicksPerInterval: 3,
            minimum: 0,
            title: AxisTitle(text: 'Week of Pregnancy')),
        primaryYAxis: NumericAxis(
            minimum: userData.weight.toDouble() - 10,
            title: AxisTitle(text: 'Weight in pounds')),
        // Chart title
        title: ChartTitle(text: 'How are you and baby growing?'),
        // Enable legend
        legend: Legend(isVisible: false),
        // Enable tooltip
        tooltipBehavior: TooltipBehavior(enable: true),
        series: <ChartSeries<WeightModel, int>>[
          LineSeries<WeightModel, int>(
            dataSource: lowerlimitlist,
            xValueMapper: (WeightModel weight, _) => weight.currentweek,
            yValueMapper: (WeightModel weight, _) => weight.weight,
            name: 'Lower Limit',
            // Enable data label
            dataLabelSettings: const DataLabelSettings(isVisible: false),
          ),
          LineSeries<WeightModel, int>(
            dataSource: upperlimitlist,
            xValueMapper: (WeightModel weight, _) => weight.currentweek,
            yValueMapper: (WeightModel weight, _) => weight.weight,
            name: 'Upper Limit',
            // Enable data label
            dataLabelSettings: const DataLabelSettings(isVisible: false),
          ),
          ScatterSeries(
              dataSource: modeleduserWeightList,
              xValueMapper: (WeightModel weight, _) => weight.currentweek,
              yValueMapper: (WeightModel weight, _) => weight.weight),
        ]);
  }
}
