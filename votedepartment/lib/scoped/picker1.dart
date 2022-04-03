import 'package:flutter/cupertino.dart';

class Picker extends ChangeNotifier {
  PickerModel pick = PickerModel();

  void changed(int pickReceiver, String pickedString) {
    pick.selectedItem = pickReceiver;
    pick.selectedString = pickedString;
    notifyListeners();
    //
    print(pickReceiver);
  }
}

class PickerModel {
  int selectedItem = 0;
  String selectedString = "";
}
