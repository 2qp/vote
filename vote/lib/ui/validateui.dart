import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vote/func/msg.dart';

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
                    validate(id.text);
                  },
                  child: const Text('Proceed to Vote'),
                ),
              ],
            )),
      ),
    );
  }

  Future validate(String name) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    final QuerySnapshot result = await firestore
        .collection('users')
        .where('age', isEqualTo: name)
        .limit(1)
        .get();
    final List<DocumentSnapshot> documents = result.docs;
    if (documents.length == 1) {
      showsnak("Id Already Used");
    } else {
      showsnak("lessgoo");
    }
  }
}
