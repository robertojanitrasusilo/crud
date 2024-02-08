import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:crud/function.dart';
import 'package:crud/main.dart';
import 'package:crud/models/book.dart';
import 'package:crud/views/detail_page.dart';
import 'package:crud/views/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';

class EditBukuScreen extends StatefulWidget {
  final Book book;
  const EditBukuScreen({Key? key, required this.book}) : super(key: key);

  @override
  _EditBukuScreenState createState() => _EditBukuScreenState();
}

class _EditBukuScreenState extends State<EditBukuScreen> {
  @override
  void initState() {
    // TODO: implement initState
    namaBukuController.text = widget.book.nama;
    penerbitController.text = widget.book.penerbit;
    penulisController.text = widget.book.penulis;
    tahunController.text = widget.book.tahun;
    deskripsiController.text = widget.book.deskripsi;
    if (widget.book.tersedia == true) {
      availability = Availability.available;
    } else {
      availability = Availability.notAvailable;
    }
    super.initState();
  }

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
              Center(child: Text('Edit Buku', style: TextStyle(fontSize: 20))),
              SizedBox(height: 30),
              Column(
                children: [
                  SizedBox(height: 16),
                  Text('Id : ${widget.book.id}',
                      style: TextStyle(fontSize: 16)),
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
                                imageFile!,
                                fit: BoxFit.fill,
                                width: 200,
                                height: 200,
                              ),
                            ),
                            SizedBox(height: 2),
                            Text(
                              imageFile!.path,
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
                                  title: Text('Edit Buku'),
                                  content: Text(
                                      'Apakah anda yakin ingin mengedit buku ini?'),
                                  actions: [
                                    TextButton(
                                        onPressed: () async {
                                          await uploadEditBook();
                                          Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      DetailPage(
                                                          book: widget.book)));
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: Text('Berhasil edit'),
                                            ),
                                          );
                                          SnackBar(
                                              content:
                                                  Text('Buku berhasil diedit'));
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
