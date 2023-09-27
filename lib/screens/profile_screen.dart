import 'package:budget_app/managers/managers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/budget.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController();
    final incomeController = TextEditingController();

    return Consumer<BudgetManager>(builder: (context, manager, child) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            controller: nameController,
          ),
          TextField(
            controller: incomeController,
          ),
          ElevatedButton(
            child: const Text("Add user"),
            onPressed: () {
              User user = User(
                id: 1,
                name: nameController.text,
                balance: double.parse(incomeController.text),
              );
              manager.addUser(user);
            },
          )
        ],
      );
    });
  }
}
