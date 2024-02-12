// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:crud/views/editbuku_screen.dart';
import 'package:flutter/material.dart';

import 'package:crud/main.dart';
import 'package:crud/models/book.dart';
import 'package:crud/views/home_screen.dart';
import 'package:crud/views/tambahbuku_screen.dart';
import 'package:crud/function.dart';

class DetailPage extends StatefulWidget {
  Book book;
  DetailPage({
    Key? key,
    required this.book,
  }) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    if (isDetailPage == true) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            SizedBox(height: 50),
            GestureDetector(
                onTap: () => setState(() {
                      isDetailPage = !isDetailPage;
                    }),
                child: Icon(Icons.arrow_back_ios_new_rounded, size: 30)),
            SizedBox(height: 30),
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                    'http://10.0.2.2/flutter-login-signup/${widget.book.foto}',
                    width: MediaQuery.of(context).size.width - (2 * 50)),
              ),
            ),
            SizedBox(height: 40),
            Text(widget.book.nama,
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600)),
            SizedBox(height: 5),
            Text('Penulis : ${widget.book.penulis}',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
            SizedBox(height: 5),
            Text('Penerbit : ${widget.book.penerbit}',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
            SizedBox(height: 5),
            Text('Tahun terbit : ${widget.book.tahun}',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
            SizedBox(height: 5),
            Text('Tersedia : ${widget.book.tersedia}',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
            Divider(thickness: 2),
            SizedBox(height: 12),
            Text(
                '${widget.book.deskripsi.length > 100 ? widget.book.deskripsi.substring(0, 100) + '...' : widget.book.deskripsi}'),
            SizedBox(height: 15),
            isAdmin == true
                ? Row(children: [
                    FilledButton(
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditBukuScreen(
                            book: widget.book,
                          ),
                        ),
                      ),
                      child: Text("Edit Buku"),
                    ),
                    Spacer(),
                    FilledButton(
                        onPressed: () async {
                          var hapusbuku = await hapusBuku(widget.book.id);
                          if (hapusbuku == 'Success') {
                            // Set isDetailPage to false after successful deletion
                            setState(() {
                              isDetailPage = false;
                            });
                          }
                        },
                        child: Text('Hapus Buku',
                            style: TextStyle(color: Colors.white)),
                        style: FilledButton.styleFrom(
                            backgroundColor: Colors.red)),
                  ])
                : Center(
                    child: widget.book.tersedia == true
                        ? FilledButton(
                            onPressed: () async {
                              setState(() {
                                widget.book.tersedia = false;
                              });
                              debugPrint(isTersedia.toString());
                              var pinjambuku = await pinjamBuku(widget.book.id);
                              debugPrint(pinjambuku);
                              if (pinjambuku == 'Success') {
                                // Update page with updated book data
                                var updateBook =
                                    await getDetailBook(widget.book.id);
                                setState(() {
                                  widget.book = updateBook;
                                });
                              }
                            },
                            child: Text('Pinjam Buku'))
                        : Container())
          ]),
        ),
      );
    }
    return HomeScreen(admin: isAdmin);
  }
}
