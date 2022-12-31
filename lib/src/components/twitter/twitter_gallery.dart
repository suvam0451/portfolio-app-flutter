import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:twitter_api_v2/twitter_api_v2.dart' as v2;

class PortfolioTwitterGallery extends StatefulWidget {
  final String id;
  const PortfolioTwitterGallery(this.id, {super.key});

  @override
  State<PortfolioTwitterGallery> createState() => _PortfolioTwitterGallery();
}

class _PortfolioTwitterGallery extends State<PortfolioTwitterGallery> {
  List<String> imageGallery = [];
  int itemsPerPage = 8;
  List<int> itemsPerPageOptions = [8, 16, 32];
  bool loading = false;

  void getImageGallery() async {
    setState(() {
      loading = true;
    });
    final twitter = v2.TwitterApi(
        bearerToken:
            "AAAAAAAAAAAAAAAAAAAAAOReOwEAAAAAQ%2BTzOFgbArwxexDj%2FiBf9zRX7eA%3D8AAfw29PXAx6t0u5nSEvXKcjvbIFtgYIt0NfZkkGFQ5Ge4uelI",
        retryConfig: v2.RetryConfig(
            maxAttempts: 3, onExecute: (event) => print('Retried')),
        timeout: const Duration(seconds: 10));

    final results = await twitter.tweets
        .lookupTweets(userId: widget.id, maxResults: itemsPerPage, expansions: [
      v2.TweetExpansion.attachmentsMediaKeys,
    ]);
    final valid = results.data
        .where((e) {
          return e.attachments?.mediaKeys?.isNotEmpty ?? false;
        })
        .map((e) => e.id)
        .toList();
    if (kDebugMode) {
      print(valid);
    }

    List<String> images = [];

    if (valid.isEmpty) {
      setState(() {
        loading = false;
      });
      return;
    }
    final tweetsWithMedia =
        await twitter.tweets.lookupByIds(tweetIds: valid, tweetFields: [
      v2.TweetField.possiblySensitive
    ], expansions: [
      v2.TweetExpansion.attachmentsMediaKeys,
    ], mediaFields: [
      v2.MediaField.url,
      v2.MediaField.type,
      v2.MediaField.height,
      v2.MediaField.width,
      v2.MediaField.mediaKey,
      v2.MediaField.previewImageUrl
    ]);
    if (kDebugMode) {
      tweetsWithMedia.includes?.media?.forEach((element) {
        if (element.type == v2.MediaType.photo) {
          if (element.url != null) {
            images.add(element.url!);
          }
        }
      });

      setState(() {
        loading = false;
        imageGallery = images;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Padding(
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            children: [
              ElevatedButton.icon(
                icon: loading
                    ? const SizedBox(
                        height: 16,
                        width: 16,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ))
                    : const Icon(Icons.image),
                onPressed: getImageGallery,
                label: loading
                    ? const Text("Fetching...")
                    : const Text("Fetch Gallery"),
              ),
              const Spacer(
                flex: 1,
              ),
              const Padding(
                  padding: EdgeInsets.only(right: 8),
                  child: Text("Per Page", style: TextStyle(fontSize: 14))),

              // backgroundColor: Colors.white,

              DropdownButton<int>(
                // Initial Value
                value: itemsPerPage,

                // Down Arrow Icon
                icon: const Icon(Icons.keyboard_arrow_down),

                // Array list of items
                items: itemsPerPageOptions.map((int items) {
                  return DropdownMenuItem(
                    value: items,
                    child: Text(items.toString()),
                  );
                }).toList(),
                // After selecting the desired option,it will
                // change button value to selected value
                onChanged: (int? newValue) {
                  setState(() {
                    itemsPerPage = newValue!;
                  });
                },
              ),
              // label: const Text("Download All"))
            ],
          )),
      GridView.count(
        physics: const ScrollPhysics(),
        crossAxisCount: 2,
        shrinkWrap: true,
        children: imageGallery.map((e) {
          return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 1),
              child: Image(
                image: NetworkImage(e),
                fit: BoxFit.fitWidth,
              ));
        }).toList(),
      ),
      Container(
          child: Center(
              child: Row(
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
            IconButton(
              iconSize: 36,
              icon: const Icon(Icons.chevron_left),
              onPressed: () {},
              color: Colors.blue,
              // backgroundColor: Colors.white,
            ),
            Text("1", style: TextStyle(fontSize: 20)),
            IconButton(
              iconSize: 36,
              icon: const Icon(Icons.chevron_right),
              onPressed: () {},
              color: Colors.blue,
              // backgroundColor: Colors.white,
            ),
          ]))),
    ]);
  }
}
