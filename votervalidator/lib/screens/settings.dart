import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Settings extends StatelessWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          primary: Colors.black,
          backgroundColor: Colors.white,
        ),
        onPressed: () async {
          logout();
        },
        child: const Text('Logout'),
      ),
    );
  }
}

void logout() async {
  final auth = FirebaseAuth.instance;
  await auth.signOut();
}
