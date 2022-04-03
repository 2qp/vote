import 'package:provider/provider.dart';
import 'package:vote/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:vote/func/msg.dart';

//db
import 'package:vote/db/db.dart';
import 'package:vote/models/candidate.dart';

//import 'screens/home/home.dart';
import 'contract_linking.dart';

import 'vote.dart';
import 'package:vote/ui/validateui.dart';
// testui
import './screens/home/candidatesUI.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ContractLinking()),
        StreamProvider<List<Weapon>>(
          create: (context) => DatabaseService().streamWeapons(),
          initialData: [],
        )
      ],
      child: MaterialApp(
        scaffoldMessengerKey: snackbarKey,
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
        home: const ValidateUi(),
      ),
    );
  }
}
