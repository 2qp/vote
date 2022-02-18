import 'package:provider/provider.dart';
import 'package:votervalidator/scoped/counters.dart';
import 'package:flutter/material.dart';

//  Widgets

import 'widget1.dart';
import 'widget2.dart';
import 'widget3.dart';

class MyHomePage extends StatelessWidget {
  //const MyHomePage({Key? key}) : super(key: key);

  final ScopedCounter scopedCounter = ScopedCounter();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ScopedCounter>(
      create: (_) => scopedCounter,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Hello World with Scoped Model'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const <Widget>[
              Widget1(),
              Widget2(),
              Widget3(),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => scopedCounter.increment(),
          tooltip: 'Increment',
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
