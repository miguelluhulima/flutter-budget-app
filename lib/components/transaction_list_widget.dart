import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
                trailing: Text(
                  "\$${item.amount}",
                ))
          ]);
        } else {
          return ListTile(
              title: Text(item.category),
              trailing: Text(
                "\$${item.amount}",
              ));
        }
      },
      itemCount: transactions.length,
      shrinkWrap: true,
    );
  }
}

const String dateFormatter = 'MMMM dd, y';

extension DateHelper on DateTime {
  String formatDate() {
    final formatter = DateFormat(dateFormatter);
    return formatter.format(this);
  }

  bool isSameDate(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }

  int getDifferenceInDaysWithNow() {
    final now = DateTime.now();
    return now.difference(this).inDays;
  }
}
