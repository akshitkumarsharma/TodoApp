import 'package:flutter/cupertino.dart';

class SharedData extends ChangeNotifier {
  int x = 1, y = 1;
  SharedData();
  incrementX() {
    x = x + 1;
    notifyListeners();
  }
}
