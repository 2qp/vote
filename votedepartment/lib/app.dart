import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'msg.dart';

//import 'screens/home/home.dart';
import 'contract_link.dart';
import 'vote.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ContractLinking>(
      create: (_) => ContractLinking(),
      child: MaterialApp(
        scaffoldMessengerKey: snackbarKey,
        theme:
            ThemeData(brightness: Brightness.dark, primaryColor: Colors.black),
        home: const Voteui(),
      ),
    );
  }
}
