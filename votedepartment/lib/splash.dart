import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:splash_screen_view/SplashScreenView.dart';

import 'package:votedepartment/func/signup.dart';

// navigator
import 'package:votedepartment/ui/home.dart';
import 'package:votedepartment/ui/admin_login.dart';

class Splash extends StatelessWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Auth _auth = Auth();
    var user = Provider.of<User?>(context);
    return FutureBuilder(
        future: _auth.isAdminExist(user),
        builder: ((context, snapshot) {
          return SplashScreenView(
            navigateRoute: user != null && snapshot.data == true
                ? const Home()
                : const AdminLog(),
            duration: 3000,
            imageSize: 130,
            imageSrc: "lib/assets/department.png",
            backgroundColor: Colors.white,
            // stylized
            text: "Department",
            textType: TextType.ColorizeAnimationText,
            textStyle: const TextStyle(
              fontSize: 40.0,
            ),
            colors: const [
              Colors.purple,
              Colors.blue,
              Colors.yellow,
              Colors.red,
            ],
          );
        }));
  }
}
