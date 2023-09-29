import 'package:budget_app/helper/date_helper.dart';
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

    const List<Widget> transactionType = [
      Text("Income"),
      Text("Expense"),
    ];
    final List<bool> selectedType = <bool>[true, false];

    return FloatingActionButton(
      tooltip: "Add a transaction",
      onPressed: () => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Add transaction"),
          content: StatefulBuilder(builder: (context, setState) {
            DateTime date = selectedDate ?? DateTime.now();
            String dateString = date.formatDate();

            return SizedBox(
              height: 350,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Category"),
                  TextField(controller: categoryController),
                  const Text("Amount"),
                  TextField(controller: amountController),
                  const Text("Date"),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(dateString),
                      ElevatedButton(
                        onPressed: () async {
                          selectedDate = await showDatePicker(
                            context: context,
                            firstDate: DateTime(dateToday.year - 5),
                            lastDate: dateToday,
                            initialDate: dateToday,
                          );
                          setState(() {});
                        },
                        child: const Icon(
                          Icons.calendar_month_rounded,
                        ),
                      ),
                    ],
                  ),
                  const Text("Select transaction type: "),
                  ToggleButtons(
                    direction: Axis.horizontal,
                    onPressed: (int index) {
                      setState(() {
                        for (int i = 0; i < selectedType.length; i++) {
                          selectedType[i] = i == index;
                        }
                      });
                    },
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                    selectedBorderColor:
                        selectedType[0] ? Colors.green[700] : Colors.red[700],
                    selectedColor: Colors.white,
                    fillColor:
                        selectedType[0] ? Colors.green[200] : Colors.red[200],
                    color:
                        selectedType[0] ? Colors.red[400] : Colors.green[400],
                    constraints: const BoxConstraints(
                      minHeight: 40.0,
                      minWidth: 80.0,
                    ),
                    isSelected: selectedType,
                    children: transactionType,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Transaction transaction = Transaction(
                          dateTime: selectedDate ?? dateToday,
                          amount: double.parse(amountController.text),
                          category: categoryController.text,
                          isExpense: selectedType[1] == true);
                      manager.addUserTransaction(
                          transaction, manager.getUser.last);
                      Navigator.of(context).pop();
                    },
                    child: const Text("Submit"),
                  )
                ],
              ),
            );
          }),
        ),
      ),
      foregroundColor: Colors.white,
      backgroundColor: Colors.grey,
      child: const Icon(Icons.add),
    );
  }
}
