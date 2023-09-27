import 'package:budget_app/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'managers/managers.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  final _appStateManager = AppStateManager();
  final _budgetManager = BudgetManager();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (create) => _appStateManager),
        ChangeNotifierProvider(create: (create) => _budgetManager)
      ],
      child: MaterialApp(
        theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
            useMaterial3: true),
        home: const Home(),
      ),
    );
  }
}
