import 'package:flutter/material.dart';
import 'package:vote/scoped/counters.dart';
import 'package:provider/provider.dart';

class Widget1 extends StatelessWidget {
  const Widget1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ScopedCounter>(
        builder: (context, model, _) =>
            Text('Widget1 counter is ${model.counter1.count}'));
  }
}
