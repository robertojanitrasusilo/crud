import 'dart:io';

import 'package:crud/function.dart';
import 'package:crud/main.dart';
import 'package:crud/models/book.dart';
import 'package:crud/views/home_screen.dart';
import 'package:flutter/material.dart';

class EditBukuScreen extends StatefulWidget {
  final Book book;

  const EditBukuScreen({Key? key, required this.book})
      : super(key: key); // Update this line

  @override
  _EditBukuScreenState createState() => _EditBukuScreenState();
}

class _EditBukuScreenState extends State<EditBukuScreen> {
  @override
  void initState() {
    super.initState();
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback((_) {
      namaBukuController.text = widget.book.nama;
      penerbitController.text = widget.book.penerbit;
      penulisController.text = widget.book.penulis;
      tahunController.text = widget.book.tahun.toString();
      deskripsiController.text = widget.book.deskripsi;
      availability = widget.book.tersedia == true
          ? Availability.available
          : Availability.notAvailable;
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    namaBukuController.dispose();
    penerbitController.dispose();
    penulisController.dispose();
    tahunController.dispose();
    deskripsiController.dispose();
    availability = Availability.available;
    super.dispose();
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
              const SizedBox(height: 100),
              const Center(
                  child: Text('Edit Buku', style: TextStyle(fontSize: 20))),
              const SizedBox(height: 30),
              Column(
                children: [
                  const SizedBox(height: 16),
                  Text('Id : ${widget.book.id}',
                      style: const TextStyle(fontSize: 16)),
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
                  const SizedBox(height: 16),
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
                  const SizedBox(height: 16),
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
                  const SizedBox(height: 16),
                  TextFormField(
                    onSaved: (newValue) => tahunController.text = newValue!,
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
                  const SizedBox(height: 16),
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
              const SizedBox(height: 16),
              Center(
                  child: imageFile != null
                      ? Column(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.file(
                                File(imageFile!.path),
                                fit: BoxFit.fill,
                                width: 200,
                                height: 200,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              imageFile!.path,
                              style: const TextStyle(fontSize: 12),
                            ),
                          ],
                        )
                      : Image.network(
                          'http://10.0.2.2/flutter-login-signup/${widget.book.foto}',
                          width: 200,
                          height: 200)),
              const SizedBox(height: 30),
              Center(
                child: ElevatedButton(
                  style:
                      ElevatedButton.styleFrom(fixedSize: const Size(200, 50)),
                  onPressed: () async {
                    await uploadImage();
                    if (imageFile != null) {
                      base64Image = await imageFile!.readAsBytes();
                    }
                    setState(() {
                      imageFile;
                    });
                  },
                  child: const Text('Upload Image'),
                ),
              ),
              const SizedBox(height: 16),
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                RadioMenuButton(
                    value: Availability.available,
                    groupValue: availability,
                    onChanged: (value) {
                      setState(() {
                        availability = value!;
                      });
                    },
                    child: const Text('Tersedia')),
                RadioMenuButton(
                    value: Availability.notAvailable,
                    groupValue: availability,
                    onChanged: (value) {
                      setState(() {
                        availability = value!;
                      });
                    },
                    child: const Text('Tidak Tersedia')),
              ]),
              const SizedBox(height: 16),
              Center(
                child: FilledButton(
                    style: FilledButton.styleFrom(
                        fixedSize: Size(
                            MediaQuery.of(context).size.width * (2 * 24), 50)),
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                                  title: const Text('Edit Buku'),
                                  content: const Text(
                                      'Apakah anda yakin ingin mengedit buku ini?'),
                                  actions: [
                                    TextButton(
                                        onPressed: () async {
// Assume this function returns the updated book
                                          Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      HomeScreen(
                                                          admin: isAdmin)));
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            const SnackBar(
                                              content: Text('Berhasil edit'),
                                            ),
                                          );
                                          setState(() {
                                            isDetailPage = false;
                                          });
                                          const SnackBar(
                                              content:
                                                  Text('Buku berhasil diedit'));
                                        },
                                        child: const Text('Submit')),
                                    TextButton(
                                        onPressed: () async {
                                          Navigator.pop(context);
                                        },
                                        child: const Text('Cancel'))
                                  ]));
                    },
                    child: const Text('Submit')),
              ),
              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}
