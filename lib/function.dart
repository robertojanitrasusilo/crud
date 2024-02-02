import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:crud/main.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

Future userRegister(String email, String password) async {
  var url = Uri.parse('http://10.0.2.2/flutter-login-signup/register.php');
  var response =
      await http.post(url, body: {"email": email, "password": password});
  String dataUser = response.body;
  print("Data: $dataUser");
  if (dataUser == "Error") {
    return "error";
  } else {
    return "success";
  }
}

Future userLogin() async {
  var url = Uri.parse('http://10.0.2.2/flutter-login-signup/login.php');
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

Future getImage() async {
  final ImagePicker picker = ImagePicker();
  final XFile? imagePicked =
      await picker.pickImage(source: ImageSource.gallery);

  if (imagePicked != null) {
    imageFile = File(imagePicked.path);
  } else {
    print('No image selected.');
  }
}
