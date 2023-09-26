import 'package:budget_app/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'states/managers.dart';

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
  final _dataManager = DataManager();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (create) => _appStateManager),
        ChangeNotifierProvider(create: (create) => _dataManager)
      ],
      child: MaterialApp(
        theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
            useMaterial3: true),
        home: const Home(),
      ),
    );
  }
}
