// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:crud/main.dart';
import 'package:crud/views/home_screen.dart';

class DetailPage extends StatefulWidget {
  bool isAdmin;
  DetailPage({
    Key? key,
    required this.isAdmin,
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
              child: Image.asset('assets/example.jpg',
                  width: MediaQuery.of(context).size.width - (2 * 50)),
            ),
          ),
          SizedBox(height: 40),
          Text('Atomic Habits',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600)),
          SizedBox(height: 5),
          Text('Penulis : Jamie Foxx',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
          SizedBox(height: 5),
          Text('Penerbit : PT. Gramedia Pustaka Utama',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
          SizedBox(height: 5),
          Text('Tahun terbit : 1998',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
          Divider(thickness: 2),
          SizedBox(height: 12),
          Text(
              'Atomic Habits menjelaskan tentang bagaimana kebiasaan-kebiasaan kecil dapat menghasilkan perubahan yang luar biasa dalam hidup kita. Buku ini menawarkan solusi ilmiah dan praktis untuk membangun kebiasaan baik dan menghilangkan kebiasaan buruk.'),
          SizedBox(height: 15),
          isAdmin == true
              ? Row(children: [
                  FilledButton(onPressed: () {}, child: Text('Edit Buku')),
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
    return HomeScreen(isAdmin: !isAdmin);
  }
}
