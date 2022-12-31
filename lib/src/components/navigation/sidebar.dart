import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PortfolioSideBar extends StatefulWidget {
  const PortfolioSideBar({super.key});

  @override
  State<PortfolioSideBar> createState() => _SideBar();
}

class _SideBar extends State<PortfolioSideBar> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(children: [
        const UserAccountsDrawerHeader(
            accountName: Text("Example User"),
            accountEmail: Text("suvam0451@gmail.com"))
      ]),
    );
  }
}
