import 'package:crud/views/home_screen.dart';
import 'package:crud/views/login_screen.dart';
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
      home: HomeScreen(isAdmin: false),
    );
  }
}

bool isAdmin = false;
bool isLogin = false;
bool isRegister = false;
String? dataUser;

//* user Controllers
TextEditingController userEmailController = TextEditingController();
TextEditingController userPasswordController = TextEditingController();
TextEditingController searchingBookController = TextEditingController();
