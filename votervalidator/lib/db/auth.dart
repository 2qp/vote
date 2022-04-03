import 'package:firebase_auth/firebase_auth.dart';

class Auth {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // current uid
  Future<String> uid() async {
    final uid = await _auth.currentUser!.uid;
    // test purp
    print(uid);
    return uid;
  }
}
