import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_application_1/src/pages/settings.dart';

import 'choose_location.dart';
import '../components/navigation/bottom_navigation.dart';
import 'home.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  int navigationIndex = 3;

  List<String> routes = [
    "/",
    "/home",
    "/search",
    "/settings",
  ];

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        bottomNavigationBar: PortfolioBottomNavigation(2),
        body: Text("loading screen"));
  }
}
