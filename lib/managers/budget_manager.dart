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
  "December",
];

class BudgetManager extends ChangeNotifier {
  final List<User> _user = <User>[User(id: 0, name: "")];
  // final List<Transaction> _budget = <Transaction>[];
  String _monthSelected = months.elementAt(0);

  List<User> get getUser => List.unmodifiable(_user);
  // List<Transaction> get getBudget => List.unmodifiable()
  String get getMonth => _monthSelected;

  void addUser(User user) {
    _user.add(user);
    notifyListeners();
  }

  void removeUser() {}

  void addUserTransaction(Transaction transaction, User user) {
    User currUser = _user.where((element) => element.name == user.name).first;
    print(currUser.name);
    currUser.transactions = [...currUser.transactions, transaction];
    notifyListeners();
  }

  void onSelectMonth(String month) {
    _monthSelected = months.firstWhere((element) => element == month);
    notifyListeners();
  }
}
