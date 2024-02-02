import 'dart:io';

import 'package:crud/views/home_screen.dart';
import 'package:crud/views/login_screen.dart';
import 'package:crud/views/tambahbuku_screen.dart';
import 'package:crud/widgets/book_cards.dart';
import 'package:flutter/material.dart';

void main(List<String> args) => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      title: 'CRUD',
      home: LoginScreen(),
    );
  }
}

bool isAdmin = false;
bool isLogin = false;
bool isRegister = false;
bool isDetailPage = false;
File? imageFile;

String? dataUser;
List<BookCard> books = List<BookCard>.generate(
  10,
  (i) => BookCard(
    id: i,
    title: 'Book ${i + 1}',
    image: 'assets/example.jpg',
    statusPinjam: i % 2 == 0,
  ),
);

//* user Controllers
TextEditingController userEmailController = TextEditingController();
TextEditingController userPasswordController = TextEditingController();
TextEditingController searchingBookController = TextEditingController();
