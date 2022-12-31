import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../components/navigation/bottom_navigation.dart';
import '../components/quote.dart';
import '../components/quote_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // sample variable
  int level = 1;
  bool favourite = false;
  List<String> list = [
    "https://pbs.twimg.com/media/FkPu4JuX0AAWWLm?format=jpg&name=medium",
    "https://pbs.twimg.com/media/FkPu3ErWAAAvymC?format=jpg&name=medium",
    "https://pbs.twimg.com/media/FkPhgXTWIAUpRq0?format=jpg&name=medium",
    "https://pbs.twimg.com/media/FkPU0uWWQAA-w8Z?format=jpg&name=medium"
  ];

  List<Quote> quotes = [
    Quote(
        author: "Oscar Wilde",
        text: "Be yourself; everyone else is already taken."),
    Quote(
        author: "Oscar Wilde",
        text: "I have nothing to declare except my genius."),
    Quote(
        author: "Oscar Wilde",
        text: "The truth is rarely pure and never simple."),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const PortfolioBottomNavigation(0),
      body: SafeArea(
          child: SingleChildScrollView(
              child: Center(
                  child: Stack(
        // fit: StackFit.loose,
        children: [
          Column(
            children: [
              ElevatedButton.icon(
                icon: const Icon(Icons.mail, color: Colors.black),
                onPressed: (() {
                  if (kDebugMode) {
                    print("pressed");
                  }
                }),
                label: const Text("Contact Us",
                    style: TextStyle(color: Colors.black)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.amber,
                ),
              ),
              TextButton(
                onPressed: () {
                  if (kDebugMode) {
                    print("hello");
                  }
                  // print("pressed")
                },
                child: const Text("click me"),
                // icon: Icon(Icons.web),
              ),
              Container(
                  padding: const EdgeInsets.all(10),
                  // margin: ,
                  color: Colors.grey.shade100,
                  child: Text("$level",
                      style: TextStyle(color: Colors.cyan.shade900))),
              Icon(favourite ? Icons.favorite : Icons.favorite_outline,
                  color: favourite ? Colors.pink.shade400 : Colors.black),
              Center(
                  child: Row(
                children: const [
                  Icon(Icons.chevron_left, color: Colors.black),
                  Icon(Icons.chevron_right, color: Colors.black),
                ],
              )),
              Column(
                  children: quotes
                      .map((e) => QuoteCard(
                          quote: e,
                          delete: () {
                            setState(() {
                              quotes.remove(e);
                            });
                          }))
                      .toList()),
              Column(
                children: list.map((e) {
                  return Image(
                    image: NetworkImage(e),
                    width: 100, // Dimension.px(100).value.toDouble(),
                    fit: BoxFit.fitWidth,
                  );
                }).toList(),
              )
            ],
          )
        ],
      )))),
      floatingActionButton: FloatingActionButton(
        child: const Text("+"),
        onPressed: () => {
          setState(() {
            level += 1;
            favourite = !favourite;
          })
        },
      ),
    );
  }
}
