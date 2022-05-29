import 'package:firebase_auth/firebase_auth.dart';
import 'package:votervalidator/func/msg.dart';

class Auth {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // current uid
  Future<String> uid() async {
    final uid = await _auth.currentUser!.uid;
    // test purp
    print(uid);
    return uid;
  }

  // authorize the login
  Future<bool> authorize(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      final User? user = _auth.currentUser;
      final IdTokenResult claims = await user!.getIdTokenResult();

      if (claims.claims!['admin'] == false &&
          claims.claims!['isValidator'] == true) {
        return true;
      } else {
        return false;
      }
    } on FirebaseAuthException catch (e) {
      showsnak('Error : ${e.code} | ${e.message}');
      return false;
    }
  }

  // is exist admin
  Future<bool> isAdminExist(User? user) async {
    // this code returns additional unexpected false first
    // first async get as false, then claims check
    // user not null

    if (user != null) {
      final IdTokenResult claims = await user.getIdTokenResult();
      // check if user has admin claims
      if (claims.claims!['admin'] == false &&
          claims.claims!['isValidator'] == true) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }
}
