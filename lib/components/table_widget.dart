import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/budget.dart';

class TableWidget extends StatelessWidget {
  final User user;

  const TableWidget({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        bool isSameDate = true;
        final String dateString = user.transactions[index].dateTime.toString();
        final DateTime date = DateTime.parse(dateString);
        final item = user.transactions[index];
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
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
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
      itemCount: user.transactions.length,
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
    return this.year == other.year &&
        this.month == other.month &&
        this.day == other.day;
  }

  int getDifferenceInDaysWithNow() {
    final now = DateTime.now();
    return now.difference(this).inDays;
  }
}
