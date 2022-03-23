import 'dart:async';

import 'package:cloud_functions/cloud_functions.dart';
import 'package:votedepartment/models/validators.dart';

import 'package:firebase_auth/firebase_auth.dart';

class Auth {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> sign(userName, passWord) async {
    final User? user = (await _auth.createUserWithEmailAndPassword(
            email: Validator(username: userName).username.toString(),
            password: Validator(password: passWord).password.toString()))
        .user;

    await claim(user!.uid);
  }

  Future<void> claim(user) async {
    HttpsCallable callable = FirebaseFunctions.instance.httpsCallable('Signup');
    await callable.call(user);
  }
}
