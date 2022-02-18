import 'package:flutter/material.dart';
import 'addVoters.dart';
import 'package:provider/provider.dart';

class MainUi extends StatelessWidget {
  const MainUi({Key? key, required this.uid}) : super(key: key);
  final String uid;

  @override
  Widget build(BuildContext context) {
    var fire = Provider.of<AddUser>(context);
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
    var fire = Provider.of<AddUser>(context, listen: false);
    await fire.addUser(uid, canid, text);
  }
}
