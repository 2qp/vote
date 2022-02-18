import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

// func
import 'package:votervalidator/func/ui.dart';

FirebaseAuth auth = FirebaseAuth.instance;

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController email = TextEditingController();
    TextEditingController password = TextEditingController();
    return Scaffold(
        //backgroundColor: Colors.black,
        body: Center(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: email,
              decoration: const InputDecoration(
                hintText: "Email",
                border: OutlineInputBorder(),
                suffixIcon: Icon(
                  Icons.check_circle,
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF6200EE)),
                ),
              ),
            ),
            // pw
            TextField(
              controller: password,
              decoration: const InputDecoration(
                hintText: "password",
                border: OutlineInputBorder(),
                suffixIcon: Icon(
                  Icons.check_circle,
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF6200EE)),
                ),
              ),
            ),
            // btn
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
                      inputData(context, email.text, password.text);
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
    ));
  }

  void inputData(BuildContext context, String text, String text2) async {
    try {
      FirebaseAuth.instance
          .signInWithEmailAndPassword(email: text, password: text2)
          .then((result) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => MainUi(uid: result.user!.uid)),
        );
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }
}
