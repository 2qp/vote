import 'package:flutter/material.dart';
// import 'package:votervalidator/auth/login.dart';
// import 'package:votervalidator/func/ui.dart';
import 'package:provider/provider.dart';
import 'package:votervalidator/func/addVoters.dart';
import 'package:votervalidator/func/contract_link.dart';

import 'package:votervalidator/func/msg.dart';
import 'package:votervalidator/splash.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AddUser()),
        ChangeNotifierProvider(create: (context) => ContractLinking()),
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
