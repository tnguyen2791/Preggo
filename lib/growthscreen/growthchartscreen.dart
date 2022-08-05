import 'package:flutter/material.dart';
import 'package:preggo/growthscreen/editweightdialogue.dart';
import 'package:preggo/emailscreen/growthemail.dart';
import 'package:preggo/growthscreen/growthstatus.dart';
import 'package:preggo/growthscreen/partnerweighindialogue.dart';
import 'package:preggo/models/user.dart';
import 'package:preggo/services/auth.dart';
import 'package:preggo/shared/constants.dart';
import 'package:provider/provider.dart';
import 'weightlogmodel.dart';
import 'weighindialogue.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:preggo/shared/restartwidget.dart';
import 'growthcalculator.dart';
import 'cartesiangrowthchart.dart';
import 'package:preggo/emailscreen/pdfservices.dart';

class GrowthChart extends StatefulWidget {
  static const String id = 'growth_screen';

  const GrowthChart({Key? key}) : super(key: key);

  @override
  State<GrowthChart> createState() => _GrowthChartState();
}

class _GrowthChartState extends State<GrowthChart> {
  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<UserData>(context, listen: false);

    List<WeightModel> upperlimitlist = GrowthCalculator()
        .createUpperLimitBMIModel(userData.weight, userData.heightininches);

    List<WeightModel> lowerlimitlist = GrowthCalculator()
        .createLowerLimitBMIModel(userData.weight, userData.heightininches);

    Map mostrecentweightandtime =
        GrowthCalculator().findMostRecentWeight(userData.weightlist);

    int dateofconception =
        GrowthCalculator().getDateofConceptionEpoch(userData.epochduedate);

    List userWeightList = userData.weightlist;
    List<WeightModel> modeleduserWeightList = [];

    int conceptionInEpoch =
        GrowthCalculator().getDateofConceptionEpoch(userData.epochduedate);

    for (Map item in userWeightList) {
      int week = GrowthCalculator()
          .findWeeksofGestation(item['time'], conceptionInEpoch)
          .floor();
      int weight = item['weight'];
      WeightModel addtolist = WeightModel(currentweek: week, weight: weight);
      modeleduserWeightList.add(addtolist);
    }

    int progressNumber = GrowthCalculator().appraiseWeight(
        userData.weight,
        userData.heightininches,
        mostrecentweightandtime['time'],
        dateofconception,
        mostrecentweightandtime['weight']);

    return Scaffold(
      appBar: AppBar(
        leading: BackButton(onPressed: () => Navigator.of(context).pop()),
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
          if (userData.weighpref != 'Partner')
            Container(
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(100.0))),
              child: CartesianGrowthChart(
                  userData: userData,
                  lowerlimitlist: lowerlimitlist,
                  upperlimitlist: upperlimitlist,
                  modeleduserWeightList: modeleduserWeightList),
            ),
          progressNumber == 0
              ? const UnderweightGrowth()
              : progressNumber == 1
                  ? const OnTrackGrowth()
                  : const OverweightGrowth(),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () =>
                    Navigator.of(context).pushNamed(EmailSender.id),
                child: const Text('Email'),
              ),
              ElevatedButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PdfPreviewPage(userData: userData),
                  ),
                ),
                child: const Text('Create PDF'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
