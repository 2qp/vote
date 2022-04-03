import 'dart:js';

import 'package:flutter/material.dart';
import 'package:vote/func/msg.dart';
import 'package:vote/services/db.dart';

// Candidate UI
import 'package:vote/screens/home/candidatesUI.dart';

class ValidateUi extends StatelessWidget {
  const ValidateUi({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController id = TextEditingController();

    return Scaffold(
      body: Center(
        child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                TextField(
                  controller: id,
                  decoration: const InputDecoration(
                    hintText: "ID",
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(
                      Icons.check_circle,
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF6200EE)),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),

                // validation w/ db

                ElevatedButton(
                  style: OutlinedButton.styleFrom(
                    primary: Colors.black,
                    backgroundColor: Colors.white,
                  ),
                  onPressed: () async {
                    validate(context, id.text);
                  },
                  child: const Text('Proceed to Vote'),
                ),
              ],
            )),
      ),
    );
  }

  Future validate(BuildContext context, String id) async {
    final db = DatabaseService();

    final documents = await db.isAlreadyExist(id);
    if (documents.length == 1) {
      // pusher
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const ViewUserPage()),
      );

      showsnak("Go Ahead");
    } else {
      showsnak("No ID Registered");
    }
  }
}
