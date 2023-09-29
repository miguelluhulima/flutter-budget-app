import 'package:budget_app/helper/date_helper.dart';
import 'package:flutter/material.dart';

import '../models/budget.dart';

class TransactionListWidget extends StatelessWidget {
  final User user;
  final int month;

  const TransactionListWidget({
    super.key,
    required this.user,
    required this.month,
  });

  @override
  Widget build(BuildContext context) {
    final transactions = user.transactions
        .where((element) => element.dateTime.month == month)
        .toList();

    // Widget transactionAmount =

    return ListView.builder(
      itemBuilder: (context, index) {
        bool isSameDate = true;
        final String dateString = transactions[index].dateTime.toString();
        final DateTime date = DateTime.parse(dateString);
        final Transaction item = transactions[index];

        if (index == 0) {
          isSameDate = false;
        } else {
          final String prevDateString =
              user.transactions[index - 1].dateTime.toString();
          final DateTime prevDate = DateTime.parse(prevDateString);
          isSameDate = date.isSameDate(prevDate);
        }

        if (index == 0 || !(isSameDate)) {
          return Column(children: [
            Text(
              date.day == DateTime.now().day ? "Today" : date.formatDate(),
              style:
                  const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            ListTile(
                title: Text(item.category),
                subtitle: item.isExpense
                    ? const Text("Expense")
                    : const Text("Income"),
                trailing: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "\$${item.amount}",
                      style: TextStyle(
                        color: item.isExpense ? Colors.redAccent : Colors.green,
                        fontSize: 15.0,
                      ),
                    ),
                    const SizedBox(width: 5),
                    item.isExpense
                        ? const Icon(Icons.arrow_downward, color: Colors.red)
                        : const Icon(Icons.arrow_upward, color: Colors.green),
                  ],
                ))
          ]);
        } else {
          return ListTile(
              title: Text(item.category),
              subtitle:
                  item.isExpense ? const Text("Expense") : const Text("Income"),
              trailing: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "\$${item.amount}",
                    style: TextStyle(
                      color: item.isExpense ? Colors.redAccent : Colors.green,
                      fontSize: 15.0,
                    ),
                  ),
                  const SizedBox(width: 5),
                  item.isExpense
                      ? const Icon(Icons.arrow_downward, color: Colors.red)
                      : const Icon(Icons.arrow_upward, color: Colors.green),
                ],
              ));
        }
      },
      itemCount: transactions.length,
      shrinkWrap: true,
    );
  }
}
