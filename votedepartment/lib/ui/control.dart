import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:votedepartment/msg.dart';
import 'package:votedepartment/scoped/switch1.dart';

// link
import 'package:provider/provider.dart';
import 'package:votedepartment/contract_link.dart';
import 'package:votedepartment/scoped/switch2.dart';

class Control extends StatelessWidget {
  const Control({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Switchy scopedSWitch = Switchy();
    final Switch2 switch2 = Switch2();
    var link = Provider.of<ContractLinking>(context, listen: false);

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                children: <Widget>[
                  const Expanded(
                      child: Card(
                    elevation: 20.00,
                    color: Colors.teal,
                    child: SizedBox(
                      height: 30.00,
                      child: Center(child: Text("Start / Pause")),
                    ),
                  )),
                  Expanded(
                    child: FutureBuilder(
                      future: scopedSWitch.changes(context),
                      initialData: false,
                      builder: (context, snapshot) =>
                          ChangeNotifierProvider<Switchy>(
                        create: (_) => scopedSWitch,
                        child: Consumer<Switchy>(
                            builder: (_, model, __) => CupertinoSwitch(
                                value: model.witch.cswitch,
                                onChanged: (state) async {
                                  scopedSWitch.changed(state);
                                  if (state == true) {
                                    await link.startVoting();
                                  } else {
                                    await link.stopVoting();
                                  }
                                })),
                      ),
                    ),
                  )
                ],
              ),
              Row(
                children: <Widget>[
                  const Expanded(
                      child: Card(
                    elevation: 20.00,
                    color: Colors.teal,
                    child: SizedBox(
                      height: 30.00,
                      child: Center(child: Text("End")),
                    ),
                  )),
                  Expanded(
                    child: FutureBuilder(
                      future: switch2.changes(context),
                      initialData: false,
                      builder: (context, snapshot) =>
                          ChangeNotifierProvider<Switch2>(
                        create: (_) => switch2,
                        child: Consumer<Switch2>(
                            builder: (_, model, __) => CupertinoSwitch(
                                value: model.witch.endSwitch,
                                onChanged: (state) async {
                                  switch2.changed(state);
                                  if (state == true) {
                                    await link.end();
                                  } else {
                                    showsnak("Election Ended");
                                  }
                                })),
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 20.00,
              ),
              Center(
                child: Flex(
                  direction: Axis.horizontal,
                  children: const <Widget>[
                    Expanded(
                        child: Card(
                      elevation: 20.00,
                      color: Colors.teal,
                      child: SizedBox(
                        height: 30.00,
                        child: Center(child: Text("Security")),
                      ),
                    ))
                  ],
                ),
              )
            ]),
      ),
    );
  }
}


// issue : cannot listen to provider 4 use isLoading/ circular progress
// loop cause
// it calls future function repeatly
// Provider, FutureProvider does not listen for any changes within the model itself.