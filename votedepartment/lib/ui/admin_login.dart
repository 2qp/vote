import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:votedepartment/func/signup.dart';
import 'package:votedepartment/msg.dart';
import 'package:votedepartment/ui/home.dart';

class AdminLog extends StatelessWidget {
  const AdminLog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController _name = TextEditingController();
    TextEditingController _party = TextEditingController();
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const SizedBox(
                height: 30.00,
              ),
              CupertinoFormSection.insetGrouped(
                  backgroundColor: CupertinoColors.white,
                  header: const Text('Login'),
                  children: [
                    CupertinoTextFormFieldRow(
                      controller: _name,
                      prefix: const Icon(CupertinoIcons.person),
                      style: const TextStyle(color: Colors.white),
                      placeholder: 'Email',
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a value';
                        }
                        return null;
                      },
                    ),
                    CupertinoTextFormFieldRow(
                      controller: _party,
                      obscureText: true,
                      prefix: const Icon(CupertinoIcons.person_2_square_stack),
                      style: const TextStyle(color: Colors.white),
                      placeholder: 'Password',
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a value';
                        }
                        return null;
                      },
                    ),
                  ]),
              Padding(
                padding: const EdgeInsets.all(30.00),
                child: CupertinoButton.filled(
                  onPressed: () async {
                    await login(context, _name.text, _party.text);
                  },
                  child: const Text('Login'),
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
      ),
    );
  }

  Future<void> login(
      BuildContext context, String email, String password) async {
    final Auth _auth = Auth();
    if (await _auth.authorize(email, password) == true) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Home()),
      );
    } else {
      showsnak("Not an admin");
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
