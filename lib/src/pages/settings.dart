import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:twitter_api_v2/twitter_api_v2.dart' as v2;

import '../components/navigation/bottom_navigation.dart';
import '../components/twitter/profile_card.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

GestureDetector buildAccountOption(BuildContext context, String title) {
  return GestureDetector(
      onTap: () {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text(title),
                content: const Text("This is a test"),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("Close"),
                  )
                ],
              );
            });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(title,
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey.shade600)),
          Icon(Icons.arrow_forward, color: Colors.grey.shade600)
        ]),
      ));
}

class _SettingsScreenState extends State<SettingsScreen> {
  List<TwitterProfileCard> results = [];

  void getMyTwitterProfile() async {
    final twitter = v2.TwitterApi(
        bearerToken:
            "AAAAAAAAAAAAAAAAAAAAAOReOwEAAAAAQ%2BTzOFgbArwxexDj%2FiBf9zRX7eA%3D8AAfw29PXAx6t0u5nSEvXKcjvbIFtgYIt0NfZkkGFQ5Ge4uelI",
        retryConfig: v2.RetryConfig(
            maxAttempts: 3, onExecute: (event) => print('Retried')),
        timeout: const Duration(seconds: 10));
    try {
      // final me = await twitter.users.lookupMe();
      final users =
          await twitter.users.lookupByName(username: "Genshin", userFields: [
        // v2.UserFields.description,
        // v2.UserFields.entities,
        v2.UserField.id,
        // v2.UserFields.location,
        v2.UserField.name,
        // v2.UserFields.pinned_tweet_id,
        v2.UserField.profileImageUrl,
        v2.UserField.username,
        // v2.UserFields.protected,
        // v2.UserFields.public_metrics,
        // v2.UserFields.url,
        // v2.UserFields.username,
        v2.UserField.verified,
        // v2.UserFields.withheld
      ]);
      // userFields: [v2.UserField., v2.UserFields.description, v2.UserFields.entities, v2.UserFields.id, v2.UserFields.location, v2.UserFields.name, v2.UserFields.pinned_tweet_id, v2.UserFields.profile_image_url, v2.UserFields.protected, v2.UserFields.public_metrics, v2.UserFields.url, v2.UserFields.username, v2.UserFields.verified, v2.UserFields.withheld]);
      if (kDebugMode) {
        print(users.data.id);
        print(users.data.name);
        print(users.data.username);
        print(users.data.profileImageUrl);

        setState(() {
          results.add(TwitterProfileCard(
              id: users.data.id,
              name: users.data.name,
              username: users.data.username,
              profileImageUrl: users.data.profileImageUrl));
        });
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Settings',
          style: TextStyle(fontSize: 22),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      bottomNavigationBar: const PortfolioBottomNavigation(3),
      // drawer: PortfolioSideBar(),
      body: Container(
          padding: const EdgeInsets.all(10),
          child: ListView(
            children: [
              const SizedBox(height: 40),
              Row(
                children: const [
                  Icon(
                    Icons.person,
                    color: Colors.blue,
                  ),
                  SizedBox(width: 10),
                  Text(
                    "Account",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const Divider(
                height: 20,
                thickness: 2,
              ),
              const SizedBox(
                height: 10,
              ),
              buildAccountOption(context, "Change Password"),
              buildAccountOption(context, "Content Settings"),
              buildAccountOption(context, "Privacy and Security"),
              ElevatedButton(
                  onPressed: () async {
                    getMyTwitterProfile();
                  },
                  child: const Text("My Profile")),
              Column(children: results.map((e) => e).toList())
            ],
          )),
    );
  }
}
