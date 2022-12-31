import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

class TwitterProfileCard extends StatelessWidget {
  final String id;
  final String username;
  final String name;
  final String? profileImageUrl;
  final int? tweetCount;
  final int? followingCount;
  final int? followersCount;

  // twitter specific parameters
  final String? nextToken;

  const TwitterProfileCard(
      {super.key,
      required this.id,
      required this.username,
      required this.name,
      this.profileImageUrl,
      this.tweetCount,
      this.followingCount,
      this.followersCount,
      this.nextToken});

  void toggleFavourite() async {
    final prefs = await SharedPreferences.getInstance();

    final List<String>? items = prefs.getStringList('twitter_fav');
    if (items != null && items.contains(id)) {
      // remove ite
      items.remove(id);
      prefs.setStringList('twitter_fav', items);
    } else if (items != null) {
      items.add(id);
      prefs.setStringList('twitter_fav', items);
    } else {
      prefs.setStringList('twitter_fav', [id]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0),
            child: Container(
                constraints: const BoxConstraints(maxWidth: 400),
                decoration: BoxDecoration(
                    color: Colors.blue.shade100,
                    borderRadius: BorderRadius.circular(20)),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                        height: 90,
                        child: Stack(children: [
                          ClipPath(
                              clipper: AvatarClipperCircular(),
                              child: Container(
                                height: 48, // 100, 64
                                decoration: BoxDecoration(
                                    color: Colors.green.shade400,
                                    borderRadius: const BorderRadius.only(
                                        topRight: Radius.circular(20),
                                        topLeft: Radius.circular(20))),
                              )),
                          Positioned(
                              left: 10, // 11
                              top: 12, // 50, 64
                              child: Row(
                                children: [
                                  CircleAvatar(
                                      radius: 36, // 50
                                      backgroundImage: NetworkImage(
                                          (profileImageUrl ??
                                                  "https://steamcdn-a.akamaihd.net/steamcommunity/public/images/avatars/22/22a4f44d8c8f1451f0eaa765e80b698bab8dd826_full.jpg")
                                              .replaceFirst(
                                                  "_normal.jpg", "_400x400.jpg")
                                              .replaceFirst("_normal.png",
                                                  "_400x400.png"))),
                                  const SizedBox(width: 20),
                                  Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(bottom: 12),
                                          child: Text(name,
                                              style: const TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.white)),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 0),
                                          child: Text("@$username",
                                              style: const TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.black)),
                                        )
                                      ]),
                                ],
                              )),
                          const SizedBox(height: 40),
                        ])),
                    Padding(
                        padding: const EdgeInsets.only(
                            left: 8.0, right: 8.0, bottom: 8.0),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Column(
                                children: [
                                  const Text("Tweets",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black)),
                                  Text(
                                      NumberFormat.compactCurrency(
                                        decimalDigits: 0,
                                        symbol:
                                            '', // if you want to add currency symbol then pass that in this else leave it empty.
                                      ).format(tweetCount ?? 0).toString(),
                                      style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.normal))
                                ],
                              ),
                              const SizedBox(
                                height: 50,
                                child: VerticalDivider(
                                  color: Color(0xFF9A9A9A),
                                ),
                              ),
                              Column(
                                children: [
                                  const Text("Following",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold)),
                                  Text(
                                      NumberFormat.compactCurrency(
                                        decimalDigits: 0,
                                        symbol:
                                            '', // if you want to add currency symbol then pass that in this else leave it empty.
                                      ).format(followingCount ?? 0).toString(),
                                      style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.normal))
                                ],
                              ),
                              const SizedBox(
                                height: 50,
                                child: VerticalDivider(
                                  color: Color(0xFF9A9A9A),
                                ),
                              ),
                              Column(
                                children: [
                                  const Text("Followers",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold)),
                                  Text(
                                      NumberFormat.compactCurrency(
                                        decimalDigits: 0,
                                        symbol:
                                            '', // if you want to add currency symbol then pass that in this else leave it empty.
                                      ).format(followersCount ?? 0).toString(),
                                      style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.normal))
                                ],
                              ),
                              const SizedBox(
                                height: 50,
                                child: VerticalDivider(
                                  color: Color(0xFF9A9A9A),
                                ),
                              ),
                              IconButton(
                                  onPressed: toggleFavourite,
                                  icon: const Icon(Icons.favorite))
                            ]))
                  ],
                ))));
  }
}

class AvatarClipperCircular extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    return Path()
      ..lineTo(0, size.height)
      ..lineTo(8, size.height) // 8
      // ..arcToPoint(Offset(114, size.height), radius: const Radius.circular(1))
      ..arcToPoint(Offset(84, size.height), radius: const Radius.circular(1))
      ..lineTo(size.width, size.height)
      ..lineTo(size.width, 0)
      ..close();
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
