// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:crud/views/editbuku_screen.dart';
import 'package:flutter/material.dart';

import 'package:crud/main.dart';
import 'package:crud/models/book.dart';
import 'package:crud/views/home_screen.dart';
import 'package:crud/views/tambahbuku_screen.dart';

class DetailPage extends StatefulWidget {
  var book;
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
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
                                  ))),
                      child: Text("Edit Buku")),
                  Spacer(),
                  FilledButton(
                      onPressed: () {},
                      child: Text('Hapus Buku',
                          style: TextStyle(color: Colors.white)),
                      style:
                          FilledButton.styleFrom(backgroundColor: Colors.red)),
                ])
              : Center(
                  child: FilledButton(
                      onPressed: () {}, child: Text('Pinjam Buku')))
        ]),
      );
    }
    return HomeScreen(admin: isAdmin);
  }
}
