import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vote/func/msg.dart';

class DatabaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // checker
  Future<List<DocumentSnapshot>> isAlreadyExist(nic) async {
    final result = await _db
        .collection('voters')
        .where('nic', isEqualTo: nic)
        .limit(1)
        .get();
    return result.docs;
  }
}
