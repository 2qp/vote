import 'dart:async';

import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:votedepartment/models/validators.dart';

class Auth {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> sign(userName, passWord, id) async {
    final User? user = (await _auth.createUserWithEmailAndPassword(
            email: Validator(username: userName).username.toString(),
            password: Validator(password: passWord).password.toString()))
        .user;

    await claim(user!.uid, id);
  }

  // setting up custom claim fcf
  Future<void> claim(user, id) async {
    HttpsCallable callable = FirebaseFunctions.instance.httpsCallable('Signup');
    await callable.call(<String, dynamic>{
      'uid': user,
      'id': id,
    });
  }
}
