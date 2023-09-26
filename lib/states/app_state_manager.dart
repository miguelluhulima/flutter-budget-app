import 'package:flutter/material.dart';

class AppTabs {
  static const int dashboard = 0;
  static const int stats = 1;
  static const int profile = 2;
}

class AppStateManager extends ChangeNotifier {
  int _selectedTab = AppTabs.dashboard;

  int get getSelectedTab => _selectedTab;

  void goToTab(index) {
    _selectedTab = index;
    notifyListeners();
  }
}
