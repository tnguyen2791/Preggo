import 'package:flutter/material.dart';
import 'package:preggo/shared/shared.dart';
import 'package:preggo/constants.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class GrowthChart extends StatelessWidget {
  //TODO: Creation of charts can be done with https://pub.dev/packages/syncfusion_flutter_charts
  //TODO: Learn how to create data containers for this
  //TODO: A stacked chart is what you're looking for.

  static const String id = 'growth_screen';

  @override
  Widget build(BuildContext context) {
    List<_GestationalWeight> lowerlimit = [
      _GestationalWeight('W1', 150.7),
      _GestationalWeight('W4', 152.8),
      _GestationalWeight('W8', 155.6),
      _GestationalWeight('W12', 158.4),
      _GestationalWeight('W16', 161.2),
      _GestationalWeight('W20', 164),
      _GestationalWeight('W24', 166.8),
      _GestationalWeight('W28', 169.6),
      _GestationalWeight('W32', 172.4),
      _GestationalWeight('W36', 175.9),
      _GestationalWeight('W40', 178),
    ];

    List<_GestationalWeight> upperlimit = [
      _GestationalWeight('W1', 151),
      _GestationalWeight('W4', 154),
      _GestationalWeight('W8', 158),
      _GestationalWeight('W12', 162),
      _GestationalWeight('W16', 166),
      _GestationalWeight('W20', 168),
      _GestationalWeight('W24', 172),
      _GestationalWeight('W28', 176),
      _GestationalWeight('W32', 180),
      _GestationalWeight('W36', 184),
      _GestationalWeight('W40', 188),
    ];

    return ScreenBaseScaffold(
      titleText: "Growth Chart",
      scaffoldBody: Column(
        children: [
          Container(
            child: Text(
              'Growth Chart',
              style: kGoogleTitle,
            ),
          ),
          Container(
            child: Text(
              'Description',
              style: kGoogleDescription,
            ),
          ),
          SfCartesianChart(
              primaryXAxis: CategoryAxis(),
              primaryYAxis: NumericAxis(minimum: 130),
              // Chart title
              title: ChartTitle(text: 'Gestational Growth Chart'),
              // Enable legend
              legend: Legend(isVisible: false),
              // Enable tooltip
              tooltipBehavior: TooltipBehavior(enable: true),
              series: <ChartSeries<_GestationalWeight, String>>[
                LineSeries<_GestationalWeight, String>(
                  dataSource: lowerlimit,
                  xValueMapper: (_GestationalWeight weight, _) => weight.week,
                  yValueMapper: (_GestationalWeight weight, _) => weight.weight,
                  name: 'Lower Limit',
                  // Enable data label
                  dataLabelSettings: DataLabelSettings(isVisible: true),
                ),
                LineSeries<_GestationalWeight, String>(
                  dataSource: upperlimit,
                  xValueMapper: (_GestationalWeight weight, _) => weight.week,
                  yValueMapper: (_GestationalWeight weight, _) => weight.weight,
                  name: 'Upper Limit',
                  // Enable data label
                  dataLabelSettings: DataLabelSettings(isVisible: true),
                )
              ]),
          Expanded(
            child: Container(
              color: Colors.red,
            ),
          ),
        ],
      ),
    );
  }
}

class _GestationalWeight {
  _GestationalWeight(this.week, this.weight);

  final String week;
  final double weight;
}
