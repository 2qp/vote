import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'contract_linking.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'func/msg.dart';

class Voteui extends StatelessWidget {
  const Voteui({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController userid = TextEditingController();

    TextEditingController canid = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: const Text("Vote")),
      backgroundColor: Colors.black,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              // user id field
              TextField(
                controller: userid,
                decoration: const InputDecoration(
                  hintText: "NIC ID",
                  border: OutlineInputBorder(),
                  suffixIcon: Icon(
                    Icons.check_circle,
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF6200EE)),
                  ),
                ),
              ),
              // user id field  end
              TextField(
                controller: canid,
                decoration: const InputDecoration(
                  hintText: "Candidate ID",
                  border: OutlineInputBorder(),
                  suffixIcon: Icon(
                    Icons.check_circle,
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF6200EE)),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(50.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    ElevatedButton(
                      style: OutlinedButton.styleFrom(
                        primary: Colors.black,
                        backgroundColor: Colors.white,
                      ),
                      onPressed: () async {
                        vote(context, userid.text, canid.text);
                      },
                      child: const Text('Vote'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void vote(context, String text1, String text2) async {
    var contractLink = Provider.of<ContractLinking>(context, listen: false);

    BigInt can2 = BigInt.parse(text2);

    // firestore

    FirebaseFirestore firestore = FirebaseFirestore.instance;

    final QuerySnapshot result = await firestore
        .collection('users')
        .where('nic', isEqualTo: text1)
        .limit(1)
        .get();
    final List<DocumentSnapshot> documents = result.docs;
    if (documents.length == 1) {
      String ff = documents.first.get('rid');
      var letsvote = await contractLink.vote(can2, ff);
      showsnak("Vote Casted");
      // ignore: avoid_print
      print(letsvote);
    } else {
      showsnak("No ID Registered");
    }
  }
}
