import 'package:budget_app/states/data_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/components.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  String dropdownValue = months.first;
  @override
  Widget build(BuildContext context) {
    return Consumer<DataManager>(builder: (context, dataManager, child) {
      return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: Icon(Icons.add),
          foregroundColor: Colors.white,
          backgroundColor: Colors.grey,
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DropdownButton(
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                  underline: const SizedBox(),
                  focusColor: Colors.white,
                  value: dataManager.getMonth,
                  items: months.map<DropdownMenuItem<String>>((String month) {
                    return DropdownMenuItem(
                      value: month,
                      child: Text(month),
                    );
                  }).toList(),
                  onChanged: (String? month) {
                    dataManager.onSelectMonth(month!);
                  }),
              const SizedBox(height: 15),
              const SizedBox(
                height: 280.0,
                child: Column(
                  children: [
                    CardWidget(
                      title: "Balance",
                      data: 1000,
                    ),
                    SizedBox(height: 10.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        CardWidget(
                          title: "Income",
                          data: 42000,
                          color: Colors.deepPurpleAccent,
                          mini: true,
                        ),
                        SizedBox(width: 10.0),
                        CardWidget(
                          title: "Expense",
                          data: 1000,
                          color: Colors.redAccent,
                          mini: true,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
