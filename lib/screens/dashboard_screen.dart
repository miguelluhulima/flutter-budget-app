import 'package:budget_app/managers/budget_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/components.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  String dropdownValue = months.last;
  @override
  Widget build(BuildContext context) {
    return Consumer<BudgetManager>(builder: (context, manager, child) {
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
                      data: 10,
                    ),
                    SizedBox(height: 10.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        CardWidget(
                          title: "Income",
                          data: manager.getUser.last.balance,
                          color: Colors.deepPurpleAccent,
                          mini: true,
                        ),
                        const SizedBox(width: 10.0),
                        CardWidget(
                          title: "Expense",
                          data: 10,
                          color: Colors.redAccent,
                          mini: true,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              manager.getUser.last.transactions.isNotEmpty
                  ? TableWidget(user: manager.getUser.last)
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
