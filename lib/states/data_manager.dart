import 'package:flutter/material.dart';

const List<String> months = [
  "January",
  "February",
  "March",
  "April",
  "May",
  "June",
  "July",
  "August",
  "September",
  "October",
  "November",
  "December",
];

class DataManager extends ChangeNotifier {
  String _monthSelected = months.elementAt(0);

  String get getMonth => _monthSelected;

  void onSelectMonth(String month) {
    _monthSelected = months.firstWhere((element) => element == month);
    notifyListeners();
  }
}
