import 'package:flutter/material.dart';

// Import the firebase_core and cloud_firestore plugin
import 'package:cloud_firestore/cloud_firestore.dart';

import 'msg.dart';

class AddUser extends ChangeNotifier {
// Create a CollectionReference called users that references the firestore collection
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  Future addUser(fullName, company, age, String rid) async {
    // Call the user's CollectionReference to add a new user
    return users
        .add({
          'full_name': fullName, // John Doe
          'company': company, // Stokes and Sons
          'age': age, // 42
          'rid': rid
        })
        .then((value) => showsnak("Lessgoo, VOter Added"))
        .catchError((error) => showsnak("Failed to add user: $error"));
  }
}
