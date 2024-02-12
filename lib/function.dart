import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:crud/main.dart';
import 'package:crud/models/book.dart';

import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

Future userRegister(String nama, String email, String password) async {
  var url = Uri.parse('http://10.0.2.2:8080/flutter-login-signup/register.php');
  var response = await http
      .post(url, body: {"nama": nama, "email": email, "password": password});
  String dataUser = response.body;
  print("Data: $dataUser");
  if (dataUser == "Error") {
    return "error";
  } else {
    return "success";
  }
}

Future userLogin() async {
  var url = Uri.parse('http://10.0.2.2:8080/flutter-login-signup/login.php');
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

Future uploadImage() async {
  final ImagePicker picker = ImagePicker();
  final XFile? imagePicked =
      await picker.pickImage(source: ImageSource.gallery);

  if (imagePicked != null) {
    imageFile = File(imagePicked.path);
  } else {
    print('No image selected.');
  }
}

Future uploadBook() async {
  var url =
      Uri.parse('http://10.0.2.2:8080/flutter-login-signup/tambah-buku.php');
  var request = http.MultipartRequest('POST', url);
  request.fields['nama'] = namaBukuController.text;
  request.fields['penerbit'] = penerbitController.text;
  request.fields['penulis'] = penulisController.text;
  request.fields['tahun'] = tahunController.text;
  request.fields['deskripsi'] = deskripsiController.text;
  var pic = await http.MultipartFile.fromPath(
    "foto",
    imageFile!.path,
  );
  request.files.add(pic);
  request.fields['tersedia'] = (availability.index == 0) ? "1" : "0";

  var streamedResponse = await request.send();
  var response = await http.Response.fromStream(streamedResponse);
  print('Response status: ${response.statusCode}');
  print('Response body: ${response.body}');

  if (response.statusCode == 200) {
    return "Success";
  } else {
    return "Error";
  }
}

Future uploadEditBook(int id) async {
  var url =
      Uri.parse('http://10.0.2.2:8080/flutter-login-signup/edit-buku.php');
  var request = http.MultipartRequest('POST', url);
  request.fields['id'] = id.toString();
  request.fields['nama'] = namaBukuController.text;
  request.fields['penerbit'] = penerbitController.text;
  request.fields['penulis'] = penulisController.text;
  request.fields['tahun'] = tahunController.text;
  request.fields['deskripsi'] = deskripsiController.text;
  var pic = await http.MultipartFile.fromPath(
    "foto",
    imageFile!.path,
  );
  request.files.add(pic);
  request.fields['tersedia'] = (availability.index == 0) ? "1" : "0";

  var streamedResponse = await request.send();
  var response = await http.Response.fromStream(streamedResponse);

  print('Response status: ${response.statusCode}');
  print('Response body: ${response.body}');

  if (response.statusCode == 200) {
    return "Success";
  } else {
    return "Error";
  }
}

Future<List<Book>> getData() async {
  var url =
      Uri.parse('http://10.0.2.2:8080/flutter-login-signup/read-buku.php');
  var response = await http.get(url);

  if (response.statusCode == 200) {
    List data = jsonDecode(response.body);
    List<Book> books = data.map((e) => Book.fromMap(e)).toList();
    return books;
  } else {
    return [];
  }
}

Future getDetailBook(int id) async {
  var url =
      Uri.parse('http://10.0.2.2:8080/flutter-login-signup/detail-buku.php');
  var response = await http.post(url, body: {
    "id": id.toString(),
  });

  if (response.statusCode == 200) {
    Map<String, dynamic> data = jsonDecode(response.body);
    Book book = Book.fromMap(data);
    return book;
  } else {
    return [];
  }
}

Future pinjamBuku(int id) async {
  var url =
      Uri.parse('http://10.0.2.2:8080/flutter-login-signup/pinjam-buku.php');
  var response = await http.post(url, body: {
    "id": id.toString(),
  });

  if (response.statusCode == 200) {
    return "Success";
  } else {
    return "Error";
  }
}

Future hapusBuku(int id) async {
  var url =
      Uri.parse('http://10.0.2.2:8080/flutter-login-signup/hapus-buku.php');
  var response = await http.post(url, body: {
    "id": id.toString(),
  });

  if (response.statusCode == 200) {
    return "Success";
  } else {
    return "Error";
  }
}

clearTextFieldBook() {
  namaBukuController.clear();
  penerbitController.clear();
  penulisController.clear();
  tahunController.clear();
  deskripsiController.clear();
}
