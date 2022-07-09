import 'package:flutter/material.dart';
import 'package:preggo/shared/shared.dart';
import 'package:preggo/shared/constants.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'weighin-dialogue.dart';

class GrowthChart extends StatelessWidget {
  //TODO: Creation of charts can be done with https://pub.dev/packages/syncfusion_flutter_charts
  //TODO: Learn how to create data containers for this
  //TODO: A stacked chart is what you're looking for.

  static const String id = 'growth_screen';

  @override
  Widget build(BuildContext context) {
    List<_GestationalWeight> lowerlimit = [
      _GestationalWeight(1, 150.7),
      _GestationalWeight(4, 152.8),
      _GestationalWeight(8, 155.6),
      _GestationalWeight(12, 158.4),
      _GestationalWeight(16, 161.2),
      _GestationalWeight(20, 164),
      _GestationalWeight(24, 166.8),
      _GestationalWeight(28, 169.6),
      _GestationalWeight(32, 172.4),
      _GestationalWeight(36, 175.9),
      _GestationalWeight(40, 178),
    ];

    List<_GestationalWeight> upperlimit = [
      _GestationalWeight(1, 151),
      _GestationalWeight(4, 154),
      _GestationalWeight(8, 158),
      _GestationalWeight(12, 162),
      _GestationalWeight(16, 166),
      _GestationalWeight(20, 168),
      _GestationalWeight(24, 172),
      _GestationalWeight(28, 176),
      _GestationalWeight(32, 180),
      _GestationalWeight(36, 184),
      _GestationalWeight(40, 188),
    ];

    List<_GestationalWeight> userseries = [
      _GestationalWeight(1, 150),
      _GestationalWeight(4, 152),
      _GestationalWeight(19, 153),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Weight During Pregnancy'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            'Growth Chart',
            style: kGoogleTitle,
          ),
          Text(
            'Description',
            style: kGoogleDescription,
          ),
          SfCartesianChart(
              primaryXAxis: NumericAxis(maximum: 40, minorTicksPerInterval: 3),
              primaryYAxis: NumericAxis(minimum: 130),
              // Chart title
              title: ChartTitle(text: 'Gestational Growth Chart'),
              // Enable legend
              legend: Legend(isVisible: false),
              // Enable tooltip
              tooltipBehavior: TooltipBehavior(enable: true),
              series: <ChartSeries<_GestationalWeight, int>>[
                LineSeries<_GestationalWeight, int>(
                  dataSource: lowerlimit,
                  xValueMapper: (_GestationalWeight weight, _) => weight.week,
                  yValueMapper: (_GestationalWeight weight, _) => weight.weight,
                  name: 'Lower Limit',
                  // Enable data label
                  dataLabelSettings: const DataLabelSettings(isVisible: false),
                ),
                LineSeries<_GestationalWeight, int>(
                  dataSource: upperlimit,
                  xValueMapper: (_GestationalWeight weight, _) => weight.week,
                  yValueMapper: (_GestationalWeight weight, _) => weight.weight,
                  name: 'Upper Limit',
                  // Enable data label
                  dataLabelSettings: const DataLabelSettings(isVisible: false),
                ),
                ScatterSeries(
                    dataSource: userseries,
                    xValueMapper: (_GestationalWeight weight, _) => weight.week,
                    yValueMapper: (_GestationalWeight weight, _) =>
                        weight.weight),
              ]),
          ElevatedButton(
            onPressed: () async {
              logWeight(context);
            }
            // print('button pressed')
            ,
            child: const Text('Add Weight'),
          ),
          const ElevatedButton(
            onPressed: null,
            child: Text('Read Weight'),
          ),
        ],
      ),
    );
  }
}

class _GestationalWeight {
  _GestationalWeight(this.week, this.weight);

  final int week;
  final double weight;
}
