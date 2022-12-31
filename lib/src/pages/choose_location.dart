import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/components/controllers/scroll_to_hide.dart';
import "package:http/http.dart";
import 'package:twitter_api_v2/twitter_api_v2.dart' as v2;
import 'package:palette_generator/palette_generator.dart';

import '../components/navigation/bottom_navigation.dart';
import '../components/twitter/profile_card.dart';
import '../components/twitter/twitter_gallery.dart';

class ChooseLocation extends StatefulWidget {
  const ChooseLocation({super.key});

  @override
  State<ChooseLocation> createState() => _ChooseLocationState();
}

class _ChooseLocationState extends State<ChooseLocation> {
  Timer? _debounce;
  List<TwitterProfileCard> results = [];
  PortfolioTwitterGallery? gallery;
  late ScrollController controller;

  void getMyTwitterProfile(String query) async {
    final twitter = v2.TwitterApi(
        bearerToken:
            "AAAAAAAAAAAAAAAAAAAAAOReOwEAAAAAQ%2BTzOFgbArwxexDj%2FiBf9zRX7eA%3D8AAfw29PXAx6t0u5nSEvXKcjvbIFtgYIt0NfZkkGFQ5Ge4uelI",
        retryConfig: v2.RetryConfig(
            maxAttempts: 3, onExecute: (event) => print('Retried')),
        timeout: const Duration(seconds: 10));

    try {
      final users =
          await twitter.users.lookupByName(username: query, userFields: [
        v2.UserField.id,
        v2.UserField.name,
        v2.UserField.profileImageUrl,
        v2.UserField.username,
        v2.UserField.publicMetrics,
        v2.UserField.verified,
      ]);

      setState(() {
        results = [
          TwitterProfileCard(
            id: users.data.id,
            name: users.data.name,
            username: users.data.username,
            profileImageUrl: users.data.profileImageUrl,
            tweetCount: users.data.publicMetrics?.tweetCount,
            followingCount: users.data.publicMetrics?.followingCount,
            followersCount: users.data.publicMetrics?.followersCount,
          )
        ];

        gallery = PortfolioTwitterGallery(users.data.id);
      });
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    controller = ScrollController();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void updateSearchResults(String query) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      // do something with query
      if (kDebugMode) {
        print(query);
        getMyTwitterProfile(query);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        onVerticalDragUpdate: (details) => {},
        child: Scaffold(
            bottomNavigationBar: ScrollToHideController(
                controller: controller,
                child: const PortfolioBottomNavigation(1)),
            body: SafeArea(
              child: SingleChildScrollView(
                  controller: controller,
                  scrollDirection: Axis.vertical,
                  child: Padding(
                      padding: const EdgeInsets.only(top: 16, bottom: 8),
                      child: Column(children: [
                        Padding(
                            padding: const EdgeInsets.only(
                                left: 8, right: 8, top: 8, bottom: 4),
                            child: TextField(
                              decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.all(10.0),
                                  hintText: "Search for account",
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0)),
                                      borderSide: BorderSide()),
                                  prefixIcon: Icon(Icons.search),
                                  suffixIcon: Icon(Icons.clear)),
                              onChanged: updateSearchResults,
                            )),
                        Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            child: Column(
                                children: results.map((e) => e).toList())),
                        gallery ?? const SizedBox()
                      ]))),
            )));
  }
}
