import 'dart:convert';

import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'contract_linking.dart';

class Voteui extends StatelessWidget {
  const Voteui({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var contractLink = Provider.of<ContractLinking>(context);
    TextEditingController uid = TextEditingController();
    TextEditingController canid = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: const Text("Vote")),
      body: Center(
        child: Column(
          children: <Widget>[
            TextField(
              controller: uid,
              decoration: const InputDecoration(hintText: "User ID"),
            ),
            TextField(
              controller: canid,
              decoration: const InputDecoration(hintText: "Candidate ID"),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: ElevatedButton(
                onPressed: () {

                  inputData(context, uid.text, canid.text);
                  //contractLink.registerVoter(Parse, canid.text);
                },
                child: const Text('Save Data'),
              ),
            )
          ],
        ),
      ),
    );
  }

  void inputData(context, String uid, String canid) {

    var contractLink = Provider.of<ContractLinking>(context, listen: false);
    String source = uid;
    String source2 = canid;


    List<int> list = utf8.encode(source);
    Uint8List bytes = Uint8List.fromList(list);

    List<int> list2 = utf8.encode(source2);
    Uint8List bytes2 = Uint8List.fromList(list2);

    contractLink.registerVoter(bytes, bytes2);

  }
}
