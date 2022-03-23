import 'dart:typed_data';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:uuid/uuid_util.dart';
import 'addVoters.dart';
import 'contract_link.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// notifier
import 'msg.dart';

// db schema
import 'package:votervalidator/db/db.dart';

// claim checker
import 'package:firebase_auth/firebase_auth.dart';

class MainUi extends StatelessWidget {
  const MainUi({Key? key, required this.uid}) : super(key: key);
  final String uid;

  @override
  Widget build(BuildContext context) {
    var fire = Provider.of<AddUser>(context);
    var contractLink = Provider.of<ContractLinking>(context, listen: false);
    print(uid);
    TextEditingController id = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Validations"),
        backgroundColor: Colors.black,
      ),
      //backgroundColor: Colors.black,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              TextField(
                controller: id,
                decoration: const InputDecoration(
                  hintText: "NIC",
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
                    // padding: const EdgeInsets.all(20.0),
                    OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        primary: Colors.black,
                        backgroundColor: Colors.white,
                      ),
                      onPressed: () async {
                        inputData(context, id.text);
                        //contractLink.registerVoter(Parse, canid.text);
                      },
                      child: const Text('Register'),
                    ),

                    // claim checker btn
                    OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        primary: Colors.black,
                        backgroundColor: Colors.white,
                      ),
                      onPressed: () async {
                        checkData(context);
                        //contractLink.registerVoter(Parse, canid.text);
                      },
                      child: const Text('Register'),
                    ),

                    const SizedBox(
                      height: 10.0,
                    ),

                    // candidate data
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void inputData(context, String id) async {
    // firestore instance
    final db = DatabaseService();

    // KeyGen
    // String rid = UuidUtil.cryptoRNG().toString();
    //print(rid);
    var uuid = const Uuid();
    String rid = uuid.v1();

    // validations
    final documents = await db.isAlreadyExist(id);
    if (documents.length == 1) {
      showsnak("NIC already used !");
    } else {
      showsnak("Success");

      await db.addVoter(id, rid);

      // contract
      String gg = "ff";
      var contractLink = Provider.of<ContractLinking>(context, listen: false);
      await contractLink.votervalid(rid);
    }
  }

  void returnMap(BuildContext context, String text) async {
    var contractLink = Provider.of<ContractLinking>(context, listen: false);
    var results = await contractLink.keyreturns(text);
    print(results);
  }
}

void checkData(BuildContext context) async {
  FirebaseAuth _auth = FirebaseAuth.instance;
  final User? user = _auth.currentUser;
  IdTokenResult idTokenResult = await (user!.getIdTokenResult());
  print('claims : ${idTokenResult.claims}');
}
