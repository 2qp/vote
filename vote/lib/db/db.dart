import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/candidate.dart';

class DatabaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  /// Query a subcollection

  Stream<List<Weapon>> streamWeapons() {
    var ref = _db.collection('Candidates');

    return ref.snapshots().map(
        (list) => list.docs.map((doc) => Weapon.fromFirestore(doc)).toList());
  }
}
