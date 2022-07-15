import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:preggo/models/user.dart';

class DatabaseService {
  final String? uid;

  DatabaseService({required this.uid});

  //collection reference
  final CollectionReference childingCollection =
      FirebaseFirestore.instance.collection('childing');

  //will create it automatically

  Future<void> createNewDBUser() async {
    await childingCollection.doc(uid).set({
      'duedate': 1656882023322,
      'weight': 100,
      'provideremail': 'your@provider.org',
      'agreement': false,
      'loggedweight': [],
    });
    //this is to create that uid when a user does indeed sign in
    //At the same time, the dummy data will be recorded
  }

//user data from snapshot
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
      agreement: snapshot['agreement'],
      epochduedate: snapshot['duedate'],
      weight: snapshot['weight'],
      email: snapshot['provideremail'],
    );
  }

  Future<bool> checksDBfordocexistance() async {
    try {
      var doc = await childingCollection.doc(uid).get();
      return doc.exists;
    } catch (e) {
      throw e;
    }
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

  Future<bool> getAgreement() async {
    final ref = childingCollection.doc(uid);
    final doc = await ref.get();
    // print(uid);
    try {
      return doc['agreement'];
    } catch (e) {}
    return false;
    // return true;
  }
}
