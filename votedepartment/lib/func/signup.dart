import 'dart:async';

import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:votedepartment/models/validators.dart';
import 'package:votedepartment/msg.dart';

class Auth {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> sign(userName, passWord, id) async {
    try {
      final User? user = (await _auth.createUserWithEmailAndPassword(
              email: Validator(username: userName).username.toString(),
              password: Validator(password: passWord).password.toString()))
          .user;

      await claim(user!.uid, id);
    } on FirebaseAuthException catch (e) {
      showsnak('Error : ${e.code} | ${e.message}');
    }
  }

  // setting up custom claim fcf
  Future<void> claim(user, id) async {
    HttpsCallable callable = FirebaseFunctions.instance.httpsCallable('Signup');
    await callable.call(<String, dynamic>{
      'uid': user,
      'id': id,
    });
  }

  // admin

  Future<bool> authorize(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      final User? user = _auth.currentUser;
      final IdTokenResult claims = await user!.getIdTokenResult();
      print('claims : ${claims.claims}');

      if (claims.claims!['admin'] == true &&
          claims.claims!['isValidator'] == false) {
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
      if (claims.claims!['admin'] == true &&
          claims.claims!['isValidator'] == false) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }
}
