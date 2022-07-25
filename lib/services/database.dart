import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:preggo/models/user.dart';

class DatabaseService {
  final String? uid;

  DatabaseService({required this.uid});

  //collection reference
  final CollectionReference childingCollection =
      FirebaseFirestore.instance.collection('childing');

  static String keyagreement = 'agreement';
  static String keyduedate = 'duedate';
  static String keyloggedweight = 'loggedweight';
  static String keyprovideremail = 'provideremail';
  static String keyweighpref = 'weighpref';
  static String keyweight = 'weight';

  //will create it automatically

  Future<void> checkDatabaseStartup() async {
    try {
      final ref = childingCollection.doc(uid);
      final doc = await ref.get();
      final Map usermap = doc.data() as Map;

      Map dbtemplate = {
        keyagreement: true,
        keyduedate: DateTime.now().millisecondsSinceEpoch,
        keyloggedweight: [],
        keyprovideremail: 'myprovider@email.com',
        keyweighpref: 'Regular',
        keyweight: 250,
      };

      for (MapEntry e in dbtemplate.entries) {
        if (!usermap.containsKey(e.key)) {
          childingCollection.doc(uid).update({e.key: e.value});
        }
      }
    } catch (e) {}
  }

  Future<void> createNewDBUser() async {
    await childingCollection.doc(uid).set({
      'duedate': 1656882023322,
      'weight': 100,
      'provideremail': 'your@provider.org',
      'agreement': false,
      'loggedweight': [],
      'weighpref': 'Regular',
    });
    //this is to create that uid when a user does indeed sign in
    //At the same time, the dummy data will be recorded
  }

  //get user doc stream
  Stream<UserData> get userData {
    return childingCollection.doc(uid).snapshots().map(_userDataFromSnapshot);
  }

//user data from snapshot
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
      agreement: snapshot['agreement'],
      epochduedate: snapshot['duedate'],
      weight: snapshot['weight'],
      email: snapshot['provideremail'],
      weighpref: snapshot['weighpref'],
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

  Future<int> getdate() async {
    final ref = childingCollection.doc(uid);
    final doc = await ref.get();
    return doc['duedate'];
  }

  Future<String> getWeighPreference() async {
    final ref = childingCollection.doc(uid);
    final doc = await ref.get();
    try {
      return doc['weighpref'];
    } catch (e) {}
    return 'Regular';
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

  Future<void> updateWeighPref(String weighpref) async {
    final ref = childingCollection.doc(uid);
    final doc = await ref.get();
    final Map usermap = doc.data() as Map;
    String keysearchedfor = 'weighpref';

    if (!usermap.containsKey(keysearchedfor)) {
      try {
        return await childingCollection.doc(uid).update({
          keysearchedfor: 'Regular',
        });
      } catch (e) {}
    }
    if (usermap.containsKey(keysearchedfor)) {
      try {
        return await childingCollection.doc(uid).update({
          keysearchedfor: weighpref,
        });
      } catch (e) {}
    }
  }

  Future<void> checkExistenceofDocandUpdate(
      String keysearched, String weighpref, String defaultvalue) async {
    final ref = childingCollection.doc(uid);
    final doc = await ref.get();
    final Map usermap = doc.data() as Map;

    if (!usermap.containsKey(keysearched)) {
      try {
        return await childingCollection.doc(uid).update({
          keysearched: defaultvalue,
        });
      } catch (e) {}
    }
    if (usermap.containsKey(keysearched)) {
      try {
        return await childingCollection.doc(uid).update({
          keysearched: weighpref,
        });
      } catch (e) {}
    }
  }

  Future<String> checkExistenceofDocStringandGet(
      String keysearched, String weighpref, String defaultvalue) async {
    final ref = childingCollection.doc(uid);
    final doc = await ref.get();
    final Map usermap = doc.data() as Map;

    if (!usermap.containsKey(keysearched)) {
      try {
        await childingCollection.doc(uid).update({
          keysearched: defaultvalue,
        });
      } catch (e) {}
    }
    if (usermap.containsKey(keysearched)) {
      try {
        return doc[keysearched];
      } catch (e) {}
    }
    return defaultvalue;
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
