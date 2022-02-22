import 'package:flutter/material.dart';
import 'addVoters.dart';
import 'contract_link.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class MainUi extends StatelessWidget {
  const MainUi({Key? key, required this.uid}) : super(key: key);
  final String uid;

  @override
  Widget build(BuildContext context) {
    var fire = Provider.of<AddUser>(context);
    var contractLink = Provider.of<ContractLinking>(context, listen: false);
    print(uid);
    TextEditingController fn = TextEditingController();
    TextEditingController co = TextEditingController();
    TextEditingController age = TextEditingController();

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
                controller: fn,
                decoration: const InputDecoration(
                  hintText: "name ID",
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
                controller: co,
                decoration: const InputDecoration(
                  hintText: "compamy",
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
                controller: age,
                decoration: const InputDecoration(
                  hintText: "age",
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
                        inputData(context, fn.text, co.text, age.text);
                        //contractLink.registerVoter(Parse, canid.text);
                      },
                      child: const Text('Save Data'),
                    ),
                    // contract test
                    OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        primary: Colors.black,
                        backgroundColor: Colors.white,
                      ),
                      onPressed: () async {
                        result(context, age.text);
                        //contractLink.registerVoter(Parse, canid.text);
                      },
                      child: const Text('Test Contract'),
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

  void inputData(context, String uid, String canid, String text) async {
// uid
    var uuid = const Uuid();
    String rid = uuid.v1();

// firebase
    var fire = Provider.of<AddUser>(context, listen: false);
    await fire.addUser(uid, canid, text, rid);

// contarct
    var contractLink = Provider.of<ContractLinking>(context, listen: false);

    await contractLink.votervalid(rid);
  }

  void result(context, String rid) async {}
}
