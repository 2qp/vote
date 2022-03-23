import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:votedepartment/func/addCandidate.dart';
import 'msg.dart';

//import 'screens/home/home.dart';
import 'contract_link.dart';
//import 'vote.dart';
import 'package:votedepartment/ui/home.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AddCandidate()),
        ChangeNotifierProvider(create: (context) => ContractLinking()),
      ],
      child: MaterialApp(
        scaffoldMessengerKey: snackbarKey,
        theme:
            ThemeData(brightness: Brightness.dark, primaryColor: Colors.black),
        home: const Home(),
      ),
    );
  }
}
