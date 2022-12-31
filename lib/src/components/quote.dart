import 'package:flutter/material.dart';

class Quote {
  String? text;
  String? author;

  Quote({this.text, this.author});

  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10.0),
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey,
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            text!,
            style: const TextStyle(
              fontSize: 18.0,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 6.0),
          Text(
            'author: ${author!}',
            style: const TextStyle(
              fontSize: 14.0,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
