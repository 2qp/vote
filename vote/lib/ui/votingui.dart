import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vote/contract_linking.dart';
import 'package:vote/services/db.dart';
import 'package:vote/services/storage.dart';
import 'package:vote/ui/validateui.dart';

import '../func/msg.dart';

class VotingUi extends StatelessWidget {
  const VotingUi(
      {Key? key,
      required this.id,
      required this.name,
      required this.party,
      required this.voter})
      : super(key: key);

  final int id;
  final int voter;
  final String name;
  final String party;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Stack(
        alignment: Alignment.topCenter,
        children: <Widget>[
          Padding(
              padding: const EdgeInsets.only(top: 100.0 / 2.0),
              child: Card(
                child: SizedBox(
                  height: 200,
                  child: Center(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    //crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Padding(
                          padding: const EdgeInsets.only(
                              top: 10, bottom: 10, left: 70, right: 70),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Expanded(
                                  child: Card(
                                elevation: 20.00,
                                color: Colors.teal,
                                child: SizedBox(
                                  height: 30.00,
                                  child: Center(child: Text(name)),
                                ),
                              )),
                              Expanded(
                                  child: Card(
                                elevation: 20.00,
                                color: Colors.teal,
                                child: SizedBox(
                                  height: 30.00,
                                  child: Center(child: Text(party)),
                                ),
                              )),
                            ],
                          )),
                      ElevatedButton(
                        style: OutlinedButton.styleFrom(
                          primary: Colors.black,
                          backgroundColor: Colors.white,
                        ),
                        onPressed: () async {
                          await vote(context, id, voter);
                        },
                        child: const Text('Vote'),
                      ),
                    ],
                  )),
                ),
              )),
          Container(
            width: 100.0,
            height: 100.0,
            decoration: const ShapeDecoration(
                shape: CircleBorder(), color: Colors.white),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: FutureProvider<String>(
                initialData: "assets/img/loading.gif",
                create: (_) async {
                  final Storage _fs = Storage();
                  return await _fs.getUrl(id.toString());
                },
                child: Consumer<String>(
                  builder: (context, value, child) => DecoratedBox(
                    decoration: ShapeDecoration(
                        shape: const CircleBorder(),
                        image: DecorationImage(
                            fit: BoxFit.cover, image: NetworkImage(value))),
                  ),
                ),
              ),
            ),
          )
        ],
      )),
    );
  }

  Future<void> vote(BuildContext context, int id, int voter) async {
    var contractLink = Provider.of<ContractLinking>(context, listen: false);
    final db = DatabaseService();
    BigInt candidate = BigInt.from(id);

    // firestore

    final documents = await db.isAlreadyExist(voter);
    if (documents.length == 1) {
      String rid = documents.first.get("rid");
      var letsvote = await contractLink.vote(candidate, rid);

      Navigator.pop(context);
      Navigator.pop(context);

      // eventer
      // String errorcode = await contractLink.error();
      // showsnak(errorcode);
      showsnak("Vote Casted");

      // ignore: avoid_print
      print(letsvote);
    } else {
      showsnak("No ID Registered");
    }
  }
}
