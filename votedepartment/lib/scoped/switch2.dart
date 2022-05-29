import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../contract_link.dart';

class Switch2 extends ChangeNotifier {
  // instance
  Switch2Model witch = Switch2Model();

  // auto
  Future<void> changes(context) async {
    witch.endSwitch = await load(context);

    notifyListeners();
  }

  // click event
  void changed(bool state) {
    witch.endSwitch = state;

    notifyListeners();
  }

  // data fetcher
  Future<bool> load(context) async {
    var link = Provider.of<ContractLinking>(context, listen: false);
    late bool data;

    // getter current state
    BigInt _state = await link.getState();

    if (_state.toInt() == 2) {
      data = true;
    } else {
      data = false;
    }
    return data;
  }
}

// model
class Switch2Model {
  bool endSwitch = true;
}
