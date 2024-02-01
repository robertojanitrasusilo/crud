// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:math';

import 'package:crud/widgets/book_cards.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  bool isAdmin;
  HomeScreen({
    Key? key,
    required this.isAdmin,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 100),
        Padding(
          padding: const EdgeInsets.only(left: 24),
          child: Text("Selamat Datang, kontol",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
        ),
        SizedBox(height: 30),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: TextField(
            decoration: InputDecoration(
              filled: true,
              border: OutlineInputBorder(),
              labelText: 'Search Book',
            ),
          ),
        ),
        SizedBox(height: 30),
        Center(
            child: Text(
          'List Book',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        )),
        SizedBox(height: 16),
        Expanded(
          child: GridView.builder(
              itemCount: 10,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, crossAxisSpacing: 12, mainAxisSpacing: 24),
              itemBuilder: (context, index) => BookCard()),
        )
      ],
    ));
  }
}
