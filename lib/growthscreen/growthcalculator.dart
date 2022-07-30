import 'dart:math';
import 'weightlogmodel.dart';

class GrowthCalculator {
  int getDateofConceptionEpoch(int epochduedate) {
    int epochninemonths = 23668200000;
    int epochstart = epochduedate - epochninemonths;
    return epochstart;
  }

  Map findMostRecentWeight(List listOfKeysofWeightEntries) {
    List<int> dates = [];

    for (Map item in listOfKeysofWeightEntries) {
      dates.add(item['time']);
    }
    dates.sort(); //the last number will be the highest epch date

    if (dates.isEmpty == false) {
      int mostrecentdate = dates.last;

      Map mostrecentweight = {};

      for (Map item in listOfKeysofWeightEntries) {
        if (item['time'] == mostrecentdate) {
          mostrecentweight.addAll(item);
        }
      }

      return mostrecentweight;
    } else {
      return {'time': 0, 'weight': 0};
    }
  }

  double findWeeksofGestation(int mostRecentEpochDate, int dateofconception) {
    int weeksgestationinepoch = (mostRecentEpochDate - dateofconception);
    int daysofgestation =
        Duration(seconds: (weeksgestationinepoch / 1000).floor()).inDays;
    return (daysofgestation / 7);
  }

  int appraiseWeight(int startingWeight, int height, int mostRecentEpochDate,
      int dateofconception, int mostrecentweight) {
    double userBMI = findBMI(startingWeight, height);
    double gestationalweek =
        findWeeksofGestation(mostRecentEpochDate, dateofconception);

    double upperlimitfactor = 1.0;
    double lowerlimitfactor = 1.0;

    (userBMI < 18.5)
        ? upperlimitfactor = 1.0
        : (userBMI > 18.5 && userBMI < 24.9)
            ? upperlimitfactor = 0.8
            : (userBMI > 25 && userBMI < 29.9)
                ? upperlimitfactor = 0.6
                : upperlimitfactor = 0.5;

    (userBMI < 18.5)
        ? lowerlimitfactor = 0.7
        : (userBMI > 18.5 && userBMI < 24.9)
            ? lowerlimitfactor = 0.6
            : (userBMI > 25 && userBMI < 29.9)
                ? lowerlimitfactor = 0.4
                : lowerlimitfactor = 0.3;

    double upperlimitweight =
        (gestationalweek * upperlimitfactor) + startingWeight;

    double lowerlimitweight =
        (gestationalweek * lowerlimitfactor) + startingWeight;

    int appraisal = 1;

    mostrecentweight > upperlimitweight
        ? appraisal = 2
        : mostrecentweight < lowerlimitweight
            ? appraisal = 0
            : appraisal = 1;

    return appraisal;
  }

  double findBMI(int prepregweight, int heightininches) {
    return ((703 * prepregweight) / pow(heightininches, 2));
  }

  List<WeightModel> createUpperLimitBMIModel(int startingWeight, int height) {
    double userBMI = findBMI(startingWeight, height);

    double upperlimitfactor = 1.0;

    (userBMI < 18.5)
        ? upperlimitfactor = 1.0
        : (userBMI > 18.5 && userBMI < 24.9)
            ? upperlimitfactor = 0.8
            : (userBMI > 25 && userBMI < 29.9)
                ? upperlimitfactor = 0.6
                : upperlimitfactor = 0.5;

    // print('BMI is $userBMI');
    // print('Upper limit is $upperlimitfactor');

    List<WeightModel> upperlimitlist = [];
    for (int i = 0; i < 41; i = i + 2) {
      WeightModel modeled = WeightModel(
          currentweek: i,
          weight: (startingWeight + (i * upperlimitfactor).floor()));
      upperlimitlist.add(modeled);
    }
    return upperlimitlist;
  }

  List<WeightModel> createLowerLimitBMIModel(int startingWeight, int height) {
    double userBMI = findBMI(startingWeight, height);

    double lowerlimitfactor = 1.0;

    (userBMI < 18.5)
        ? lowerlimitfactor = 0.7
        : (userBMI > 18.5 && userBMI < 24.9)
            ? lowerlimitfactor = 0.6
            : (userBMI > 25 && userBMI < 29.9)
                ? lowerlimitfactor = 0.4
                : lowerlimitfactor = 0.3;

    // print('BMI is $userBMI');
    // print('Lower limit is $lowerlimitfactor');

    List<WeightModel> lowerlimitlist = [];
    for (int i = 0; i < 41; i = i + 2) {
      WeightModel modeled = WeightModel(
          currentweek: i,
          weight: (startingWeight + (i * lowerlimitfactor).floor()));
      lowerlimitlist.add(modeled);
    }
    return lowerlimitlist;
  }
}
