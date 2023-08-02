import 'package:flutter/material.dart';

class BottomNavigationProvider extends ChangeNotifier {
  int _currentScreenIndex = 0;

  int get currentScreenIndex => _currentScreenIndex;

  set currentScreenIndex(int value) {
    _currentScreenIndex = value;
    notifyListeners();
  }
}
