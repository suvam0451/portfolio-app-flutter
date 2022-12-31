// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/components/quote.dart';

class QuoteCard extends StatelessWidget {
  final Quote quote;
  final Function() delete;

  const QuoteCard({super.key, required this.quote, required this.delete});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
        child: Card(
          margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  quote.text!,
                  style: TextStyle(fontSize: 18, color: Colors.grey.shade600),
                ),
                const SizedBox(height: 6),
                TextButton.icon(
                  onPressed: delete,
                  icon: const Icon(Icons.delete),
                  label: const Text("Jingle Belles"),
                ),
                Text(
                  quote.author!,
                  style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
                ),
              ]),
        ));
  }
}
