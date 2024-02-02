import 'package:crud/function.dart';
import 'package:crud/main.dart';
import 'package:flutter/material.dart';

class TambahBukuScreen extends StatefulWidget {
  const TambahBukuScreen({Key? key}) : super(key: key);

  @override
  _TambahBukuScreenState createState() => _TambahBukuScreenState();
}

class _TambahBukuScreenState extends State<TambahBukuScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _tersedia = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 100),
                Center(
                    child: Text('Tambah Buku', style: TextStyle(fontSize: 20))),
                SizedBox(height: 30),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Nama',
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
                SizedBox(height: 16),
                Center(
                    child: imageFile != null
                        ? Image.file(
                            imageFile!,
                            width: 200,
                            height: 200,
                          )
                        : Image.asset('assets/image_icon.png',
                            color: Colors.grey[300], width: 200, height: 200)),
                SizedBox(height: 30),
                Center(
                  child: FilledButton(
                      style: FilledButton.styleFrom(fixedSize: Size(200, 50)),
                      onPressed: () async {
                        await getImage();
                        setState(() {
                          imageFile;
                        });
                      },
                      child: Text(
                        'Upload Image',
                      )),
                ),
                SizedBox(height: 16),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      RadioMenuButton(
                          value: true,
                          groupValue: _tersedia,
                          onChanged: (value) {
                            setState(() {
                              _tersedia = value!;
                            });
                          },
                          child: Text('Tersedia')),
                      RadioMenuButton(
                          value: false,
                          groupValue: _tersedia,
                          onChanged: (value) {
                            setState(() {
                              _tersedia = value!;
                            });
                          },
                          child: Text('Tidak Tersedia')),
                    ]),
                SizedBox(height: 16),
                Center(
                  child: FilledButton(
                      style: FilledButton.styleFrom(
                          fixedSize: Size(
                              MediaQuery.of(context).size.width * (2 * 24),
                              50)),
                      onPressed: () {},
                      child: Text('Submit')),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
