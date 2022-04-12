import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../contract_link.dart';

class Switchy extends ChangeNotifier {
  // instance
  SwitchModel witch = SwitchModel();

  // auto
  Future<void> changes(context) async {
    witch.cswitch = await load(context);
    print("am i future");
    notifyListeners();
  }

  // click event
  void changed(bool state) {
    witch.cswitch = state;

    notifyListeners();
  }

  // data fetcher
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

// model
class SwitchModel {
  bool cswitch = true;
}
