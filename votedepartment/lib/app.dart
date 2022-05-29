import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:votedepartment/func/addCandidate.dart';
import 'package:votedepartment/splash.dart';

//import 'screens/home/home.dart';
import 'contract_link.dart';
import 'msg.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AddCandidate()),
        ChangeNotifierProvider(create: (context) => ContractLinking()),
        StreamProvider<User?>.value(
          value: FirebaseAuth.instance.authStateChanges(),
          initialData: null,
        ),
      ],
      child: MaterialApp(
        scaffoldMessengerKey: snackbarKey,
        theme:
            ThemeData(brightness: Brightness.dark, primaryColor: Colors.black),
        home: const Splash(),
      ),
    );
  }
}
