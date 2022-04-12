import 'package:flutter/cupertino.dart';
import 'package:votedepartment/msg.dart';
import 'package:votedepartment/scoped/switch1.dart';

// link
import 'package:provider/provider.dart';
import 'package:votedepartment/contract_link.dart';

class Control extends StatelessWidget {
  const Control({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Switchy scopedSWitch = Switchy();
    var link = Provider.of<ContractLinking>(context, listen: false);

    return Center(
      child: FutureBuilder(
        future: scopedSWitch.changes(context),
        initialData: false,
        builder: (context, snapshot) => ChangeNotifierProvider<Switchy>(
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
    );
  }
}


// issue : cannot listen to provider 4 use isLoading/ circular progress
// loop cause
// it calls future function repeatly
// Provider, FutureProvider does not listen for any changes within the model itself.