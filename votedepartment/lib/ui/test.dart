import 'package:flutter/material.dart';
import 'package:votedepartment/func/signup.dart';

class Sign extends StatelessWidget {
  const Sign({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController username = TextEditingController();
    TextEditingController password = TextEditingController();
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: username,
              decoration: const InputDecoration(
                hintText: "NIC",
                border: OutlineInputBorder(),
                suffixIcon: Icon(
                  Icons.check_circle,
                ),
              ),
            ),
            TextField(
              controller: password,
              decoration: const InputDecoration(
                hintText: "NIC",
                border: OutlineInputBorder(),
                suffixIcon: Icon(
                  Icons.check_circle,
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
                      reg(context, username.text, password.text);
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
    );
  }
}

void reg(BuildContext context, String email, String pass) async {
  final auth = Auth();

  await auth.sign(email, pass);
}
