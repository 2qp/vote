import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:vote/func/msg.dart';
import 'package:vote/services/db.dart';

// Candidate UI
import 'package:vote/screens/home/candidatesUI.dart';

class ValidateUi extends StatelessWidget {
  const ValidateUi({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController id = TextEditingController();

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Card(
                  elevation: 20.00,
                  color: Colors.green,
                  child: SizedBox(
                    // height: 80.00,
                    child: Center(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const <Widget>[
                        Text(
                          "General Election",
                          style:
                              TextStyle(fontFamily: ('JetsMono'), fontSize: 25),
                        ),
                        Text(
                          "2022",
                          style: TextStyle(
                              fontFamily: ('JetsMono'),
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 3.0),
                        )
                      ],
                    )),
                  ),
                ),
                const SizedBox(
                  height: 30.00,
                ),

                CupertinoFormSection.insetGrouped(
                    backgroundColor: CupertinoColors.white,
                    header: const Text('National Identity Entry'),
                    children: [
                      CupertinoTextFormFieldRow(
                        controller: id,
                        prefix: const Icon(CupertinoIcons.number),
                        style: const TextStyle(color: Colors.white),
                        placeholder: 'National Indentity Number',
                      ),
                    ]),

                const SizedBox(
                  height: 20.0,
                ),

                // validation w/ db

                ElevatedButton(
                  style: OutlinedButton.styleFrom(
                      primary: Colors.black, backgroundColor: Colors.white60),
                  onPressed: () async {
                    if (id.text.isEmpty) {
                      showsnak('Please enter a value');
                    } else {
                      await validate(context, int.parse(id.text))
                          .then((_) => id.clear());
                    }
                  },
                  child: const Text('Proceed to Vote'),
                ),
                Expanded(
                  child: CustomPaint(
                    painter: CurvePainter(),
                  ),
                ),
              ],
            )),
      ),
    );
  }

  Future validate(BuildContext context, int id) async {
    final db = DatabaseService();

    final documents = await db.isAlreadyExist(id);
    if (documents.length == 1) {
      // pusher
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => CandidatesUI(
                  voter: id,
                )),
      );

      showsnak("Go Ahead");
    } else {
      showsnak("No ID Registered");
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
