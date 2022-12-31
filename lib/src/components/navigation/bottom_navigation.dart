import 'package:flutter/material.dart';

import '../../pages/home.dart';
import '../../pages/loading.dart';
import '../../pages/settings.dart';
import '../../pages/choose_location.dart';

class PortfolioBottomNavigation extends StatefulWidget {
  final int currentNavigationIndex;

  const PortfolioBottomNavigation(this.currentNavigationIndex, {super.key});

  @override
  State<PortfolioBottomNavigation> createState() =>
      _PortfolioBottomNavigation();
}

class _PortfolioBottomNavigation extends State<PortfolioBottomNavigation> {
  int navigationIndex = 0;

  List<Widget> routes = [
    const HomeScreen(),
    const ChooseLocation(),
    const LoadingScreen(),
    const SettingsScreen()
  ];

  @override
  void initState() {
    super.initState();
    navigationIndex = widget.currentNavigationIndex;
  }

  @override
  Widget build(BuildContext context) {
    return NavigationBarTheme(
        data: const NavigationBarThemeData(
            labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
            labelTextStyle: MaterialStatePropertyAll(
                TextStyle(fontSize: 14, fontWeight: FontWeight.w600))),
        child: NavigationBar(
            height: 64,
            backgroundColor: Colors.amber.shade200,
            selectedIndex: navigationIndex,
            onDestinationSelected: (index) => {
                  setState(() => navigationIndex = index),
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => routes[index]))
                },
            labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
            destinations: const [
              NavigationDestination(icon: Icon(Icons.home), label: "Home"),
              NavigationDestination(icon: Icon(Icons.search), label: "Browse"),
              NavigationDestination(
                  icon: Icon(Icons.download), label: "Downloads"),
              NavigationDestination(
                  icon: Icon(Icons.settings), label: "Settings"),
            ]));
  }
}
