import 'dart:async';
import 'dart:convert';

import 'package:crud/main.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future userRegister() async {
  var url = Uri.parse('http://10.0.2.2:80/flutter-login-signup/register.php');
  var response = await http.post(url, body: {
    "email": userEmailController.text,
    "password": userPasswordController.text,
  });
  String dataUser = response.body;
  if (dataUser == "Error") {
    print("Error");
  } else {
    print("Success");
  }
}

Future userLogin() async {
  var url = Uri.parse('http://10.0.2.2:80/flutter-login-signup/login.php');
  var response = await http.post(url, body: {
    "email": userEmailController.text,
    "password": userPasswordController.text,
  });
  String dataUser = response.body;
  print(dataUser);
  if (dataUser == "Admin") {
    return "1";
  } else {
    return "0";
  }
}
