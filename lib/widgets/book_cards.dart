// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:crud/models/book.dart';

class BookCard extends StatelessWidget {
  Book book;
  BookCard({
    Key? key,
    required this.book,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          image: DecorationImage(
              opacity: 0.5,
              image: NetworkImage(
                  'http://10.0.2.2:8080/flutter-login-signup/${book.foto}'),
              fit: BoxFit.fitWidth,
              alignment: Alignment.topCenter)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(book.nama,
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    overflow: TextOverflow.ellipsis),
                maxLines: 2),
          ),
          SizedBox(height: 5),
          Center(
            child: Text(book.tersedia == true ? 'Tersedia' : 'Dipinjam',
                style: TextStyle(
                    fontSize: 14,
                    color: book.tersedia == true
                        ? Colors.green
                        : Colors.redAccent)),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
