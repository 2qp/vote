import 'package:flutter/material.dart';
import 'package:splash_screen_view/SplashScreenView.dart';
import 'package:votervalidator/auth/login.dart';
import 'package:votervalidator/func/ui.dart';
import 'package:firebase_auth/firebase_auth.dart';

// navigator
import 'screens/home.dart';

class Splash extends StatelessWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var result = FirebaseAuth.instance.currentUser;
    return SplashScreenView(
      navigateRoute: result != null ? const Home() : const Login(),
      duration: 3000,
      imageSize: 130,
      imageSrc: "lib/assets/approved.png",
      backgroundColor: Colors.white,
      // stylized
      text: "Validator",
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
  }
}
