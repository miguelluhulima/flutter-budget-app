import 'package:budget_app/managers/budget_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/components.dart';
import '../models/budget.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<BudgetManager>(builder: (context, manager, child) {
      User user = manager.getUser.last;
      int selectedMonth = manager.getMonthList.indexOf(manager.getMonth) + 1;

      var income =
          user.transactions.where((element) => element.isExpense == false);
      var incomeByMonth =
          income.where((element) => element.dateTime.month == selectedMonth);
      double totalIncome;
      double totalIncomeByMonth;
      if (income.isEmpty) {
        totalIncome = 0;
      } else {
        totalIncome = income
            .map((e) => e.amount)
            .reduce((value, element) => value + element);
      }
      if (incomeByMonth.isEmpty) {
        totalIncomeByMonth = 0;
      } else {
        totalIncomeByMonth = incomeByMonth
            .map((e) => e.amount)
            .reduce((value, element) => value + element);
      }

      var expense =
          user.transactions.where((element) => element.isExpense == true);
      var expenseByMonth =
          expense.where((element) => element.dateTime.month == selectedMonth);
      double totalExpense;
      double totalExpenseByMonth;
      if (expense.isEmpty) {
        totalExpense = 0;
      } else {
        totalExpense = expense
            .map((e) => e.amount)
            .reduce((value, element) => value + element);
      }
      if (expenseByMonth.isEmpty) {
        totalExpenseByMonth = 0;
      } else {
        totalExpenseByMonth = expenseByMonth
            .map((e) => e.amount)
            .reduce((value, element) => value + element);
      }

      double balance = user.balance + totalIncome - totalExpense;

      return Scaffold(
        floatingActionButton: AddTransactionWidget(manager: manager),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DropdownButton(
                  value: manager.getMonth,
                  underline: const SizedBox(),
                  focusColor: Colors.white,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                  items: months.map<DropdownMenuItem<String>>((String month) {
                    return DropdownMenuItem(
                      value: month,
                      child: Text(month),
                    );
                  }).toList(),
                  onChanged: (String? month) {
                    manager.onSelectMonth(month!);
                  }),
              const SizedBox(height: 15),
              SizedBox(
                height: 250.0,
                child: Column(
                  children: [
                    CardWidget(
                      title: "Balance",
                      data: balance,
                    ),
                    const SizedBox(height: 10.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        CardWidget(
                          title: "Income",
                          data: totalIncomeByMonth,
                          color: Colors.deepPurpleAccent,
                          mini: true,
                        ),
                        const SizedBox(width: 10.0),
                        CardWidget(
                          title: "Expense",
                          data: totalExpenseByMonth,
                          color: Colors.redAccent,
                          mini: true,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              user.transactions
                      .where(
                          (element) => element.dateTime.month == selectedMonth)
                      .isNotEmpty
                  ? TransactionListWidget(
                      user: user,
                      month: selectedMonth,
                    )
                  : const Expanded(
                      child: Center(
                        child: Text("No data available"),
                      ),
                    ),
            ],
          ),
        ),
      );
    });
  }
}
