import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:votedepartment/models/candidate.dart';
import 'package:votedepartment/msg.dart';

class DatabaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // setters
  Future<void> addCandidate(id, name, party) async {
    return _db
        .collection("Candidates")
        .add(Candidate(id: id, name: name, party: party).toMap())
        .then((value) => showsnak("Lessgoo, Candidate Added"))
        .catchError((error) => showsnak("Failed to add candidate: $error"));
  }
}
