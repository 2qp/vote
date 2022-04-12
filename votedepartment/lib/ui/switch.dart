import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../scoped/switch1.dart';

class Switches extends StatefulWidget {
  const Switches({Key? key}) : super(key: key);

  @override
  State<Switches> createState() => _SwitchesState();
}

class _SwitchesState extends State<Switches> {
  @override
  initState() {
    super.initState();
  }

  final Switchy scopedSWitch = Switchy();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ChangeNotifierProvider<Switchy>(
        create: (_) => scopedSWitch,
        child: Consumer<Switchy>(
            builder: (context, model, _) => FutureProvider(
                create: (BuildContext context) {
                  scopedSWitch.changes(context);
                },
                initialData: false,
                child: CupertinoSwitch(
                    value: model.witch.cswitch,
                    onChanged: (state) async {
                      scopedSWitch.changed(state);
                    }))),
      ),
    );
  }
}
