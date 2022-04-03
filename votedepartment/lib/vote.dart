import 'dart:async';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:votedepartment/func/addCandidate.dart';

import 'contract_link.dart';
import 'package:votedepartment/db/db.dart';
import 'package:flutter/cupertino.dart';

class Voteui extends StatelessWidget {
  const Voteui({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var contractLink = Provider.of<ContractLinking>(context, listen: true);
    TextEditingController uid = TextEditingController();
    TextEditingController canid = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: const Text("Department")),
      backgroundColor: Colors.black,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: contractLink.isLoading
              ? const Center(
                  child: CupertinoActivityIndicator(),
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    TextField(
                      controller: uid,
                      decoration: const InputDecoration(
                        hintText: "User ID",
                        border: OutlineInputBorder(),
                        suffixIcon: Icon(
                          Icons.check_circle,
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFF6200EE)),
                        ),
                      ),
                    ),
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
                          // padding: const EdgeInsets.all(20.0),
                          OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              primary: Colors.black,
                              backgroundColor: Colors.white,
                            ),
                            onPressed: () async {
                              inputData(context, uid.text, canid.text);
                              //contractLink.registerVoter(Parse, canid.text);
                            },
                            child: const Text('Save Data'),
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),

                          // candidate data

                          ElevatedButton(
                            style: OutlinedButton.styleFrom(
                              primary: Colors.black,
                              backgroundColor: Colors.white,
                            ),
                            onPressed: () async {
                              getData(context, canid.text);
                              //contractLink.registerVoter(Parse, canid.text);
                            },
                            child: const Text('Get Candidates Data'),
                          ),

                          // test
                          ElevatedButton(
                            style: OutlinedButton.styleFrom(
                              primary: Colors.black,
                              backgroundColor: Colors.white,
                            ),
                            onPressed: () async {
                              load(context);
                              //contractLink.registerVoter(Parse, canid.text);
                            },
                            child: const Text('Enum Data'),
                          ),

                          // vote
                          const SizedBox(
                            height: 10.0,
                          ),

                          // vote
                          const SizedBox(
                            height: 10.0,
                          ),
                          ElevatedButton(
                            style: OutlinedButton.styleFrom(
                              primary: Colors.black,
                              backgroundColor: Colors.white,
                            ),
                            onPressed: () async {
                              result(context, canid.text);
                              //contractLink.registerVoter(Parse, canid.text);
                            },
                            child: const Text('Result'),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      //width: 450,
                      child: TextField(
                          controller: contractLink.txt,
                          readOnly: true,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Output',
                          ),
                          style: const TextStyle(
                            fontSize: 25.0,
                            height: 2.0,
                            color: Colors.white,
                            fontFamily: 'JetsMono',
                          )),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}

Future<void> inputData(context, String uid, String canid) async {
  var contractLink = Provider.of<ContractLinking>(context, listen: false);

  // contract call
  await contractLink.registerVoter(uid, canid);

  BigInt gg = await contractLink.returnCandidateID();

  // firebase add candidate id
  final db = DatabaseService();
  await db.addCandidate(gg.toInt(), uid, canid);
}

void getData(context, String canid) async {
  var contractLink = Provider.of<ContractLinking>(context, listen: false);

  BigInt jj = BigInt.parse(canid);

  List cans = await contractLink.getCandidate(jj);

  contractLink.txt.text = "id : " +
      cans[0].toString() +
      "name :" +
      cans[1].toString() +
      "party :" +
      cans[2].toString();
}

void result(BuildContext context, String text) async {
  var contractLink = Provider.of<ContractLinking>(context, listen: false);
  BigInt jj = BigInt.parse(text);
  var results = await contractLink.totalVotes(jj);
  contractLink.txt.text = "Total Votes : $results";
  print(results);
}

Future<BigInt> load(context) async {
  var link = Provider.of<ContractLinking>(context, listen: false);
  BigInt _state = await link.getState();
  print(_state);
  return _state;
}
