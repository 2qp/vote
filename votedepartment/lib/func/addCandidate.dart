import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:votedepartment/msg.dart';

class AddCandidate extends ChangeNotifier {
  CollectionReference candidates =
      FirebaseFirestore.instance.collection("Candidates");

  Future addUser(int id, String name, String party) async {
    // Call the user's CollectionReference to add a new user
    return candidates
        .add({'id': id, 'name': name, 'party': party})
        .then((value) => showsnak("Lessgoo, Candidate Added"))
        .catchError((error) => showsnak("Failed to add candidate: $error"));
  }
}

class jj extends StatelessWidget {
  const jj({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamProvider(
      create: (BuildContext context) {},
      initialData: null,
    );
  }
}
