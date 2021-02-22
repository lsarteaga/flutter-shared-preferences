import 'package:flutter/material.dart';

class ContentProvider extends ChangeNotifier {
  int _selectedIndex = 0;
  bool _scaleMode = false;

  int get selectedIndex {
    return _selectedIndex;
  }

  set selectedIndex(int value) {
    this._selectedIndex = value;
    notifyListeners();
  }

  bool get scaleMode {
    return this._scaleMode;
  }

  set scaleMode(bool value) {
    this._scaleMode = value;
    notifyListeners();
  }

  initScaleMode(bool value) {
    this._scaleMode = value;
  }
}
