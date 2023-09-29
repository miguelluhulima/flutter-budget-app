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
          title: const Text("Add transaction"),
          content: SizedBox(
            height: 300,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Category"),
                  TextField(controller: categoryController),
                  // const SizedBox(height: 5.0),
                  const Text("Amount"),
                  TextField(controller: amountController),
                  // const SizedBox(height: 5.0),
                  const Text("Date"),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(selectedDate.toString() ?? ""),
                      ElevatedButton(
                        onPressed: () async {
                          selectedDate = await showDatePicker(
                            context: context,
                            firstDate: DateTime(dateToday.year - 5),
                            lastDate: dateToday,
                            initialDate: dateToday,
                          );
                        },
                        child: const Icon(
                          Icons.calendar_month_rounded,
                        ),
                      ),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Transaction transaction = Transaction(
                          dateTime: selectedDate ?? dateToday,
                          amount: double.parse(amountController.text),
                          category: categoryController.text);
                      manager.addUserTransaction(
                          transaction, manager.getUser.last);
                      Navigator.of(context).pop();
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
