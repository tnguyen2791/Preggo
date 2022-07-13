import 'package:cloud_firestore/cloud_firestore.dart';
import 'weightlogmodel.dart';

class WeightDatabaseServices {
  String uid;

  WeightDatabaseServices({this.uid = '0000'});

  final CollectionReference childingCollection =
      FirebaseFirestore.instance.collection('childing');

  Future<List<WeightModel>> getWeightList() async {
    int convertDifference(int epochdateinitial, epochdatefinal) {
      DateTime convertedinitial =
          DateTime.fromMillisecondsSinceEpoch(epochdateinitial);

      DateTime convertedfinal =
          DateTime.fromMillisecondsSinceEpoch(epochdatefinal);

      Duration differencedate = convertedfinal.difference(convertedinitial);

      int intodays = (differencedate.inDays / 7).floor();

      return intodays;
    }

    Future<int> getDateofConception() async {
      final ref = childingCollection.doc(uid);
      final doc = await ref.get();
      int epochninemonths = 23668200000;
      int epochduedate = doc['duedate'];
      int epochstart = epochduedate - epochninemonths;
      return epochstart;
    }

    int resolvedateofconception = await getDateofConception();

    List<WeightModel> weightpulledfromDB = [];
    final ref = childingCollection.doc(uid);
    final doc = await ref.get();
    List doclist = doc['loggedweight'];
    for (Map item in doclist) {
      // WeightModel(
      //   dateinepoch: item['time'],
      //   weight: item['weight']
      // );
      int converteddate =
          convertDifference(resolvedateofconception, item['time']);
      // print(item['time']);
      // print(item['weight']);
      // print(toPrettyDateMMMddyyyy(resolvedateofconception));
      // print(toPrettyDateMMMddyyyy(item['time']));
      // print(converteddate);

      weightpulledfromDB
          .add(WeightModel(currentweek: converteddate, weight: item['weight']));
      // print(weightpulledfromDB);
    }
    return weightpulledfromDB;
  }
}