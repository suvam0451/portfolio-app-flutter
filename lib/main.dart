// import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/pages/choose_location.dart';
import 'package:flutter_application_1/src/pages/home.dart';
import 'package:flutter_application_1/src/pages/loading.dart';
import 'package:flutter_application_1/src/pages/settings.dart';
// import "pages/home.dart"
import 'src/settings/settings_controller.dart';
import 'src/settings/settings_service.dart';

void main() async {
  // Set up the SettingsController, which will glue user settings to multiple
  // Flutter Widgets.
  final settingsController = SettingsController(SettingsService());

  // Load the user's preferred theme while the splash screen is displayed.
  // This prevents a sudden theme change when the app is first displayed.
  await settingsController.loadSettings();

  // Run the app and pass in the SettingsController. The app listens to the
  // SettingsController for changes, then passes it further down to the
  // SettingsView.
  // runApp(MyApp(settingsController: settingsController));

  runApp(MaterialApp(
    initialRoute: "/home",
    // home: const HomeScreen(),
    routes: {
      '/': (context) {
        return const HomeScreen();
      },
      '/home': (context) {
        return const HomeScreen();
      },
      "/search": (context) {
        return const ChooseLocation();
      },
      "/downloads": (context) {
        return const LoadingScreen();
      },
      "/settings": (context) {
        return const SettingsScreen();
      }
    },
  ));
}
