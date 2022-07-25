import 'package:flutter/material.dart';
import 'package:preggo/growthscreen/editweightdialogue.dart';
import 'package:preggo/growthscreen/growthemail.dart';
import 'package:preggo/growthscreen/partnerweighindialogue.dart';
import 'package:preggo/models/user.dart';
import 'package:preggo/services/auth.dart';
import 'package:preggo/shared/constants.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:provider/provider.dart';
import 'package:preggo/growthscreen/weightdatabase.dart';
import 'weightlogmodel.dart';
import 'weighindialogue.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:preggo/shared/restartwidget.dart';

class GrowthChart extends StatefulWidget {
  static const String id = 'growth_screen';

  const GrowthChart({Key? key}) : super(key: key);

  @override
  State<GrowthChart> createState() => _GrowthChartState();
}

class _GrowthChartState extends State<GrowthChart> {
  @override
  Widget build(BuildContext context) {
    List<WeightModel> lowerlimit = [
      WeightModel(currentweek: 1, weight: 150),
      WeightModel(currentweek: 4, weight: 152),
      WeightModel(currentweek: 8, weight: 155),
      WeightModel(currentweek: 12, weight: 158),
      WeightModel(currentweek: 16, weight: 161),
      WeightModel(currentweek: 20, weight: 164),
      WeightModel(currentweek: 24, weight: 166),
      WeightModel(currentweek: 28, weight: 169),
      WeightModel(currentweek: 32, weight: 172),
      WeightModel(currentweek: 36, weight: 175),
      WeightModel(currentweek: 40, weight: 178),
    ];

    List<WeightModel> upperlimit = [
      WeightModel(currentweek: 1, weight: 151),
      WeightModel(currentweek: 4, weight: 154),
      WeightModel(currentweek: 8, weight: 158),
      WeightModel(currentweek: 12, weight: 162),
      WeightModel(currentweek: 16, weight: 166),
      WeightModel(currentweek: 20, weight: 168),
      WeightModel(currentweek: 24, weight: 172),
      WeightModel(currentweek: 28, weight: 176),
      WeightModel(currentweek: 32, weight: 180),
      WeightModel(currentweek: 36, weight: 184),
      WeightModel(currentweek: 40, weight: 188),
    ];

    final user = Provider.of<UserUID>(context);
    final userData = Provider.of<UserData>(context);

    final userWeightList =
        WeightDatabaseServices(uid: user.uid).getWeightList();

    // final String weighpreference = await DatabaseService(uid: user.uid).getWeighPreference();

    return Scaffold(
      appBar: AppBar(
        leading: BackButton(onPressed: () => Navigator.of(context).pop()),
        actions: [
          IconButton(
              onPressed: () {
                AuthService().signOut();
                RestartWidget.restartApp(context);
              },
              icon: const Icon(FontAwesomeIcons.powerOff))
        ],
        title: const Text('Weight During Pregnancy'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Center(
            child: Text(
              'Growth Chart',
              style: kGoogleTitle,
            ),
          ),
          FutureBuilder<List<WeightModel>>(
            future: userWeightList,
            builder: (context, AsyncSnapshot<List> snapshot) {
              if (snapshot.hasError) {
                return const AlertDialog(
                  content: Text('There was an error'),
                );
              }

              if (!snapshot.hasData) {
                return LoadingAnimationWidget.hexagonDots(
                    color: Colors.white, size: 100);
              }

              if (snapshot.connectionState == ConnectionState.done &&
                  snapshot.hasData) {
                List<WeightModel> retrieveddata =
                    snapshot.data!.cast<WeightModel>();

                return Container(
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(100.0))),
                  child: SfCartesianChart(
                      backgroundColor: Colors.white,
                      borderColor: Colors.red,
                      borderWidth: 2.0,
                      primaryXAxis: NumericAxis(
                          maximum: 40,
                          minorTicksPerInterval: 3,
                          minimum: 0,
                          title: AxisTitle(text: 'Week of Pregnancy')),
                      primaryYAxis: NumericAxis(
                          minimum: 130,
                          title: AxisTitle(text: 'Weight in pounds')),
                      // Chart title
                      title: ChartTitle(text: 'How are you and baby growing?'),
                      // Enable legend
                      legend: Legend(isVisible: false),
                      // Enable tooltip
                      tooltipBehavior: TooltipBehavior(enable: true),
                      series: <ChartSeries<WeightModel, int>>[
                        LineSeries<WeightModel, int>(
                          dataSource: lowerlimit,
                          xValueMapper: (WeightModel weight, _) =>
                              weight.currentweek,
                          yValueMapper: (WeightModel weight, _) =>
                              weight.weight,
                          name: 'Lower Limit',
                          // Enable data label
                          dataLabelSettings:
                              const DataLabelSettings(isVisible: false),
                        ),
                        LineSeries<WeightModel, int>(
                          dataSource: upperlimit,
                          xValueMapper: (WeightModel weight, _) =>
                              weight.currentweek,
                          yValueMapper: (WeightModel weight, _) =>
                              weight.weight,
                          name: 'Upper Limit',
                          // Enable data label
                          dataLabelSettings:
                              const DataLabelSettings(isVisible: false),
                        ),
                        ScatterSeries(
                            dataSource: retrieveddata,
                            xValueMapper: (WeightModel weight, _) =>
                                weight.currentweek,
                            yValueMapper: (WeightModel weight, _) =>
                                weight.weight),
                      ]),
                );
              } else {
                return LoadingAnimationWidget.hexagonDots(
                    color: Colors.white, size: 100);
              }
            },
          ),
          ElevatedButton(
            onPressed: () async {
              if (userData.weighpref == 'Partner') {
                showDialog(
                    context: context,
                    builder: (context) {
                      return const PartnerWeighingAlertDialogue();
                    }).then((_) => showDialog(
                    context: context,
                    builder: (context) {
                      return const WeighInDialogueAlert();
                    }).then((_) => setState(() {})));
              } else {
                showDialog(
                    context: context,
                    builder: (context) {
                      return const WeighInDialogueAlert();
                    }).then((_) => setState(() {}));
              }
            },
            child: const Text('Add Weight'),
          ),
          ElevatedButton(
            onPressed: () async {
              showDialog(
                  context: context,
                  builder: (context) {
                    return const EditWeightDialogue();
                  }).then((_) => setState(() {}));
            },
            child: const Text('Edit Weight'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pushNamed(EmailSender.id),
            child: const Text('Email'),
          ),
        ],
      ),
    );
  }
}
