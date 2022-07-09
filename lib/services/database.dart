import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:preggo/models/pregnancy.dart';
import 'package:preggo/models/user.dart';

class DatabaseService {
  final String? uid;

  DatabaseService({required this.uid});

  //collection reference
  final CollectionReference childingCollection =
      FirebaseFirestore.instance.collection('childing');

  //will create it automatically

  Future updateUserData(
      int duedate, int weight, String email, bool agreement) async {
    return await childingCollection.doc(uid).set({
      'duedate': duedate,
      'weight': weight,
      'provideremail': email,
      'agreement': agreement,
    });
    //this is to create that uid when a user does indeed sign in
    //At the same time, the dummy data will be recorded
  }

//Getting a list from the snapshot
  // List<PregnancyInfo> _pregnancyInfoFromSnapshot(QuerySnapshot snapshot) {
  //   return snapshot.docs.map((doc) {
  //     return PregnancyInfo(
  //       date: doc['date'] ?? '',
  //       epochduedate: doc['duedate'] ?? 1656882023322,
  //       weight: doc['weight'] ?? '',
  //     );
  //   }).toList();
  // }
//doc is more than enough to actually access it

/* This is a stream that will return a QuerySnapshot as the object type we're expecting when we're getting the userProfile, which we named */

  // Stream<List<PregnancyInfo>> get userProfile {
  //   return childingCollection.snapshots().map(_pregnancyInfoFromSnapshot);
  // }

//user data from snapshot
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
      agreement: snapshot['agreement'],
      epochduedate: snapshot['duedate'],
      weight: snapshot['weight'],
      email: snapshot['provideremail'],
    );
  }

  //get user doc stream
  Stream<UserData> get userData {
    return childingCollection.doc(uid).snapshots().map(_userDataFromSnapshot);
  }

  Future<int> getdate() async {
    final ref = childingCollection.doc(uid);
    final doc = await ref.get();
    return doc['duedate'];
  }

  Future updateDueDate(int dueDate) async {
    return await childingCollection.doc(uid).update({
      'duedate': dueDate,
    });
  }

  Future<int> getweight() async {
    final ref = childingCollection.doc(uid);
    final doc = await ref.get();
    return doc['weight'];
  }

  Future updateWeight(int weight) async {
    return await childingCollection.doc(uid).update({
      'weight': weight,
    });
  }

  Future<String> getemail() async {
    final ref = childingCollection.doc(uid);
    final doc = await ref.get();
    return doc['provideremail'];
  }

  Future updateemail(String? email) async {
    return await childingCollection.doc(uid).update({
      'provideremail': email,
    });
  }

  Future updateagreement(bool? agreement) async {
    return await childingCollection.doc(uid).update({
      'agreement': agreement,
    });
  }

  Future<bool?> getAgreement() async {
    // if (uid == '') {
    //   print('loading');
    // } else {
    //   final ref = childingCollection.doc(uid);
    //   final doc = await ref.get();
    //   // print(doc['agreement']);
    return true;
    // }
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
