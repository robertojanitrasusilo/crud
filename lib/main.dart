import 'dart:io';
import 'dart:typed_data';

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
      home: const LoginScreen(),
    );
  }
}

bool isAdmin = false;
bool isLogin = false;
bool isRegister = false;
bool isDetailPage = false;
int? idBook;
bool isEditBook = false;
// ignore: prefer_typing_uninitialized_variables
var dataBook;

String? dataUser;

//* user Controllers
TextEditingController userNameController = TextEditingController();
TextEditingController userEmailController = TextEditingController();
TextEditingController userPasswordController = TextEditingController();

//* book controllers
TextEditingController idBukuController = TextEditingController();
TextEditingController namaBukuController = TextEditingController();
TextEditingController penerbitController = TextEditingController();
TextEditingController penulisController = TextEditingController();
TextEditingController tahunController = TextEditingController();
TextEditingController deskripsiController = TextEditingController();
File? imageFile;
bool isTersedia = false;
Uint8List? base64Image;

enum Availability { available, notAvailable }

Availability availability = Availability.available;
