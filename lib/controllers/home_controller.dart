import 'package:flutter/material.dart';

class HomeController extends ChangeNotifier {
  int _currentTabIndex = 0;

  int get currentTabIndex => _currentTabIndex;

  void changeTabIndex(int newIndex) {
    if (_currentTabIndex != newIndex) {
      _currentTabIndex = newIndex;
      notifyListeners();
    }
  }
}
