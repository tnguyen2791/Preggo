import 'package:cloud_firestore/cloud_firestore.dart';
import 'weightlogmodel.dart';

class WeightDatabaseServices {
  String uid;

  WeightDatabaseServices({this.uid = '0000'});

  final CollectionReference childingCollection =
      FirebaseFirestore.instance.collection('childing');

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

  Future<void> deleteWeight(int epochdate) async {
    final ref = childingCollection.doc(uid);
    final doc = await ref.get();
    print('This is a new list');
    List doclist = doc['loggedweight'];
    List tobedeleted = [];
    for (var item in doclist) {
      if (item['time'] == epochdate) {
        tobedeleted.add(item);
      }
    }
    for (Map item in tobedeleted) {
      doclist.remove(item);
    }
    ref.update({'loggedweight': doclist});
  }

  Future<List<WeightModel>> getWeightList() async {
    int resolvedateofconception = await getDateofConception();

    List<WeightModel> weightpulledfromDB = [];

    final ref = childingCollection.doc(uid);
    final doc = await ref.get();
    List doclist = doc['loggedweight'];
    for (Map item in doclist) {
      int converteddate =
          convertDifference(resolvedateofconception, item['time']);
      weightpulledfromDB
          .add(WeightModel(currentweek: converteddate, weight: item['weight']));
      // print(weightpulledfromDB);
    }
    return weightpulledfromDB;
  }

  Future<List<WeightModel>> getListToEdit() async {
    List<WeightModel> weightpulledfromDB = [];

    final ref = childingCollection.doc(uid);
    final doc = await ref.get();
    List doclist = doc['loggedweight'];
    for (Map item in doclist) {
      weightpulledfromDB
          .add(WeightModel(currentweek: item['time'], weight: item['weight']));
    }
    return weightpulledfromDB;
  }
}
