import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:preggo/models/pregnancy.dart';
import 'package:preggo/models/user.dart';

class DatabaseService {
  final String uid;

  DatabaseService({required this.uid});

  //collection reference
  final CollectionReference childingCollection =
      FirebaseFirestore.instance.collection('childing');

  //will create it automatically

  Future updateUserData(String duedate, String weight, String date) async {
    return await childingCollection.doc(uid).set({
      'duedate': duedate,
      'weight': weight,
      'date': date,
    });
    //this is to create that uid when a user does indeed sign in
    //At the same time, the dummy data will be recorded
  }

  Future updateDueDate(int dueDate) async {
    return await childingCollection.doc(uid).update({
      'duedate': dueDate,
    });
  }

//Getting a list from the snapshot
  List<PregnancyInfo> _pregnancyInfoFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return PregnancyInfo(
        date: doc['date'] ?? '',
        epochduedate: doc['duedate'] ?? '',
        weight: doc['weight'] ?? '',
      );
    }).toList();
  }
//doc is more than enough to actually access it

/* This is a stream that will return a QuerySnapshot as the object type we're expecting when we're getting the userProfile, which we named */

  Stream<List<PregnancyInfo>> get userProfile {
    return childingCollection.snapshots().map(_pregnancyInfoFromSnapshot);
  }

//user data from snapshot
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
      uid: uid,
      date: snapshot['date'],
      duedate: snapshot['duedate'],
      weight: snapshot['weight'],
    );
  }

  //get user doc stream
  Stream<UserData> get userData {
    return childingCollection.doc(uid).snapshots().map(_userDataFromSnapshot);
  }

  Future<bool> checkIfDocExists() async {
    try {
      var doc = await childingCollection.doc(uid).get();
      return doc.exists;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
