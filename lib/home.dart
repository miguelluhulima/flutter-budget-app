import 'package:budget_app/states/app_state_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'screens/screens.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  static List<Widget> screens = [
    const DashboardScreen(),
    const StatsScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<AppStateManager>(
      builder: (context, appManager, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Budget App"),
          ),
          bottomNavigationBar: BottomNavigationBar(
              currentIndex: appManager.getSelectedTab,
              onTap: (index) {
                appManager.goToTab(index);
              },
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.dashboard),
                  label: "Dashboard",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.bar_chart),
                  label: "Statistics",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: "Profile",
                )
              ]),
          body: IndexedStack(
            index: appManager.getSelectedTab,
            children: screens,
          ),
        );
      },
    );
  }
}
