import 'package:budget_app/models/budget.dart';
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
  "December"
];

class BudgetManager extends ChangeNotifier {
  final List<User> _user = <User>[User(id: 0, name: "")];
  String _monthSelected = months.elementAt(DateTime.now().month - 1);
  final List<String> _monthList = months;

  List<User> get getUser => List.unmodifiable(_user);
  String get getMonth => _monthSelected;
  List<String> get getMonthList => _monthList;

  void addUser(User user) {
    _user.add(user);
    notifyListeners();
  }

  void removeUser() {}

  void addUserTransaction(Transaction transaction, User user) {
    User currUser = _user.where((element) => element.name == user.name).first;
    currUser.transactions = [...currUser.transactions, transaction];
    currUser.transactions.sort((a, b) => b.dateTime.compareTo(a.dateTime));
    notifyListeners();
  }

  void onSelectMonth(String month) {
    _monthSelected = months.firstWhere((element) => element == month);
    notifyListeners();
  }
}
