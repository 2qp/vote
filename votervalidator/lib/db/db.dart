import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
// models
import '../models/voter.dart';
// notifier
import '../func/msg.dart';

class DatabaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  // ### Getters ###

  Future<List<DocumentSnapshot>> isAlreadyExist(id) async {
    final results = await _db
        .collection('voters')
        .where('nic', isEqualTo: id)
        .limit(1)
        .get();
    return results.docs;
  }

  // ### Setters ###
  // Adding Voter
  Future<void> addVoter(id, rid) async {
    return _db
        .collection("voters")
        .add(Voter(id: id, rid: rid).toMap())
        .then((value) => showsnak("Voter added"))
        .catchError((error) => showsnak("Failed to add voter: $error"));
  }
}
