import 'package:flutter/material.dart';
import 'package:vote/scoped/counters.dart';
import 'package:provider/provider.dart';

class Widget3 extends StatelessWidget {
  const Widget3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ScopedCounter>(
        builder: (context, model, _) =>
            Text('Widget1 counter is ${model.counter3.count}'));
  }
}
