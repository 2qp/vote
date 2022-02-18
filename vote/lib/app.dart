import 'package:provider/provider.dart';
import 'package:vote/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

//import 'screens/home/home.dart';
import 'contract_linking.dart';

import 'vote.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ContractLinking>(
      create: (_) => ContractLinking(),
      child: MaterialApp(
        locale: const Locale('ta'),
        localizationsDelegates: const [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,
        theme:
            ThemeData(brightness: Brightness.dark, primaryColor: Colors.black),
        home: const Voteui(),
      ),
    );
  }
}
