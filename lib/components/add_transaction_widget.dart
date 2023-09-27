import 'package:budget_app/models/budget.dart';
import 'package:flutter/material.dart';

import '../managers/managers.dart';

class AddTransactionWidget extends StatelessWidget {
  final BudgetManager manager;
  const AddTransactionWidget({super.key, required this.manager});

  @override
  Widget build(BuildContext context) {
    final categoryController = TextEditingController();
    final amountController = TextEditingController();
    final DateTime dateToday = DateTime.now();
    DateTime? selectedDate;

    return FloatingActionButton(
      onPressed: () => showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text("Add Expense"),
          content: SizedBox(
            height: 200,
            child: Column(children: [
              const Text("Category"),
              TextField(controller: categoryController),
              const Text("Amount"),
              TextField(controller: amountController),
              ElevatedButton(
                onPressed: () async {
                  selectedDate = await showDatePicker(
                      context: context,
                      firstDate: dateToday,
                      lastDate: dateToday,
                      initialDate: DateTime(dateToday.year - 5));
                },
                child: const Text("Pick date"),
              ),
              ElevatedButton(
                onPressed: () {
                  Transaction transaction = Transaction(
                      dateTime: selectedDate ?? dateToday,
                      amount: double.parse(amountController.text),
                      category: categoryController.text);
                  manager.addUserTransaction(transaction, manager.getUser.last);
                },
                child: const Text("Submit"),
              )
            ]),
          ),
        ),
      ),
      foregroundColor: Colors.white,
      backgroundColor: Colors.grey,
      child: const Icon(Icons.add),
    );
  }
}
