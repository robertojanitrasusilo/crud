import 'dart:convert';

import 'package:crud/function.dart';
import 'package:crud/main.dart';
import 'package:crud/views/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';

class TambahBukuScreen extends StatefulWidget {
  const TambahBukuScreen({Key? key}) : super(key: key);

  @override
  _TambahBukuScreenState createState() => _TambahBukuScreenState();
}

class _TambahBukuScreenState extends State<TambahBukuScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 100),
              Center(
                  child: Text('Tambah Buku', style: TextStyle(fontSize: 20))),
              SizedBox(height: 30),
              Column(
                children: [
                  TextFormField(
                    controller: namaBukuController,
                    decoration: const InputDecoration(
                      labelText: 'Nama Buku',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the name';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: penerbitController,
                    decoration: const InputDecoration(
                      labelText: 'Penerbit',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the publisher';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: penulisController,
                    decoration: const InputDecoration(
                      labelText: 'Penulis',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the author';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: tahunController,
                    keyboardType: TextInputType.number,
                    maxLength: 4,
                    decoration: const InputDecoration(
                      labelText: 'Tahun',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the year';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: deskripsiController,
                    maxLines: 5,
                    decoration: const InputDecoration(
                      labelText: 'Deskripsi',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the description';
                      }
                      return null;
                    },
                  ),
                ],
              ),
              SizedBox(height: 16),
              Center(
                  child: imageFile != null
                      ? Column(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.file(
                                fit: BoxFit.fill,
                                imageFile!,
                                width: 200,
                                height: 200,
                              ),
                            ),
                            SizedBox(height: 2),
                            Text(
                              basename(imageFile!.path),
                              style: const TextStyle(fontSize: 12),
                            ),
                          ],
                        )
                      : Image.asset('assets/image_icon.png',
                          color: Colors.grey[300], width: 200, height: 200)),
              SizedBox(height: 30),
              Center(
                child: FilledButton(
                    style: FilledButton.styleFrom(fixedSize: Size(200, 50)),
                    onPressed: () async {
                      await uploadImage();
                      if (imageFile != null) {
                        base64Image = await imageFile!.readAsBytes();
                        debugPrint(base64Encode(base64Image));
                      }
                      setState(() {
                        imageFile;
                      });
                    },
                    child: Text(
                      'Upload Image',
                    )),
              ),
              SizedBox(height: 16),
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                RadioMenuButton(
                    value: Availability.available,
                    groupValue: availability,
                    onChanged: (value) {
                      setState(() {
                        availability = value!;
                      });
                    },
                    child: Text('Tersedia')),
                RadioMenuButton(
                    value: Availability.notAvailable,
                    groupValue: availability,
                    onChanged: (value) {
                      setState(() {
                        availability = value!;
                      });
                    },
                    child: Text('Tidak Tersedia')),
              ]),
              SizedBox(height: 16),
              Center(
                child: FilledButton(
                    style: FilledButton.styleFrom(
                        fixedSize: Size(
                            MediaQuery.of(context).size.width * (2 * 24), 50)),
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                                  title: Text('Tambah Buku'),
                                  content: Text(
                                      'Apakah anda yakin ingin menambahkan buku ini?'),
                                  actions: [
                                    TextButton(
                                        onPressed: () async {
                                          await uploadBook();
                                          Navigator.pushAndRemoveUntil(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      HomeScreen(
                                                          admin: isAdmin)),
                                              (route) => false);
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: Text('Berhasil tambah'),
                                            ),
                                          );
                                          clearTextFieldBook();
                                          setState(() {
                                            imageFile = null;
                                          });
                                        },
                                        child: Text('Submit')),
                                    TextButton(
                                        onPressed: () async {
                                          Navigator.pop(context);
                                        },
                                        child: Text('Cancel'))
                                  ]));
                    },
                    child: const Text('Submit')),
              ),
              SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}
