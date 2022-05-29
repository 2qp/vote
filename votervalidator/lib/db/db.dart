import 'package:cloud_firestore/cloud_firestore.dart';
// models
import '../models/voter.dart';
// notifier
import '../func/msg.dart';

class DatabaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  // ### Getters ###

  Future<List<DocumentSnapshot>> isAlreadyExist(int id) async {
    final results = await _db
        .collection('voters')
        .where('nic', isEqualTo: id)
        .limit(1)
        .get();
    return results.docs;
  }

  // category id fetcher
  Future<int> catIdFetcher(String uid) async {
    print(uid);
    final results = await _db.collection('Validators').doc(uid).get();

    int id = results.get("catId");
    print(id);
    return id;
  }

  // ### Setters ###
  // Adding Voter
  Future<void> addVoter(int id, rid) async {
    return _db
        .collection("voters")
        .add(Voter(id: id, rid: rid).toMap())
        .then((value) => showsnak("Voter added"))
        .catchError((error) => showsnak("Failed to add voter: $error"));
  }
}
