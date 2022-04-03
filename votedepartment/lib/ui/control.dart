import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:votedepartment/contract_link.dart';

class Control extends StatelessWidget {
  const Control({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var link = Provider.of<ContractLinking>(context, listen: true);

    return FutureProvider<bool>(
      initialData: false,
      create: (_) {
        // print('calling future');
        return load(context);
      },
      child: Consumer<bool>(
        builder: (_, value, __) => Center(
          child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: link.isLoading
                  ? const Center(
                      child: CupertinoActivityIndicator(),
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        CupertinoSwitch(
                          value: (value),
                          onChanged: (bool state) async {
                            if (state == true) {
                              await link.startVoting();
                            } else {
                              await link.stopVoting();
                            }
                          },
                        )
                      ],
                    )),
        ),
      ),
    );
  }

  Future<bool> load(context) async {
    var link = Provider.of<ContractLinking>(context, listen: false);
    late bool data;

    // getter current state
    BigInt _state = await link.getState();

    print(_state);
    if (_state.toInt() == 1) {
      data = true;
      print(data);
    } else {
      data = false;
    }
    return data;
  }
}
