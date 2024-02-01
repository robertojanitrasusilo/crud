// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:math';

import 'package:crud/main.dart';
import 'package:crud/views/detail_page.dart';
import 'package:crud/widgets/book_cards.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  bool isAdmin;
  HomeScreen({
    Key? key,
    required this.isAdmin,
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: isDetailPage == false
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 100),
                  Padding(
                    padding: const EdgeInsets.only(left: 24),
                    child: Row(
                      children: [
                        Text("Selamat Datang, Rusdi ",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w500)),
                        Spacer(),
                        FilledButton(
                            onPressed: () {}, child: Text("Tambah Buku"))
                      ],
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
                            crossAxisCount: 2,
                            crossAxisSpacing: 12,
                            mainAxisSpacing: 24),
                        itemBuilder: (context, index) => GestureDetector(
                            onTap: () => setState(() {
                                  isDetailPage = !isDetailPage;
                                }),
                            child: books[index])),
                  )
                ],
              )
            : DetailPage());
  }
}
