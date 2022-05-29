import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:votervalidator/db/auth.dart';

// func
import 'package:votervalidator/func/ui.dart';
import 'package:votervalidator/screens/home.dart';

// msg
import '../func/msg.dart';

FirebaseAuth auth = FirebaseAuth.instance;

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController email = TextEditingController();
    TextEditingController password = TextEditingController();
    return Scaffold(
        backgroundColor: Colors.white,
        //backgroundColor: Colors.black,
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                CupertinoFormSection.insetGrouped(
                    backgroundColor: CupertinoColors.white,
                    header: const Text('Login'),
                    children: [
                      CupertinoTextFormFieldRow(
                        controller: email,
                        prefix: const Icon(CupertinoIcons.person),
                        style: const TextStyle(color: Colors.white),
                        placeholder: 'Email',
                      ),
                      CupertinoTextFormFieldRow(
                        controller: password,
                        obscureText: true,
                        prefix:
                            const Icon(CupertinoIcons.person_2_square_stack),
                        style: const TextStyle(color: Colors.white),
                        placeholder: 'Password',
                      ),
                    ]),
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
                          primary: Colors.white,
                          backgroundColor: Colors.blue,
                        ),
                        onPressed: () async {
                          loginCaller(context, email.text, password.text);
                          //contractLink.registerVoter(Parse, canid.text);
                        },
                        child: const Text('Login'),
                      ),

                      // candidate data
                    ],
                  ),
                ),

                Expanded(
                  child: CustomPaint(
                    painter: CurvePainter(),
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  void loginCaller(BuildContext context, String email, String password) async {
    final Auth _auth = Auth();
    if (await _auth.authorize(email, password) == true) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Home()),
      );
    } else {
      showsnak("Not a Validator");
    }
  }
}

class CurvePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = Colors.green;
    paint.style = PaintingStyle.fill;

    var path = Path();

    path.moveTo(0, size.height * 0.9167);
    path.quadraticBezierTo(size.width * 0.25, size.height * 0.875,
        size.width * 0.5, size.height * 0.9167);
    path.quadraticBezierTo(size.width * 0.75, size.height * 0.9584,
        size.width * 1.0, size.height * 0.9167);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
