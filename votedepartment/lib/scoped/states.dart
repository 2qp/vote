import 'package:flutter/cupertino.dart';
import 'package:votedepartment/models/state.dart';

class Scoped extends ChangeNotifier {
  Show state1 = Show();

  void togle() {
    state1.togle = !state1.togle;
    notifyListeners();
  }
}
