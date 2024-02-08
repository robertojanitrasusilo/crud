// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';

import 'package:crud/function.dart';
import 'package:crud/main.dart';
import 'package:crud/models/book.dart';
import 'package:crud/views/detail_page.dart';
import 'package:crud/views/tambahbuku_screen.dart';
import 'package:crud/widgets/book_cards.dart';

class HomeScreen extends StatefulWidget {
  bool admin;
  HomeScreen({
    Key? key,
    required this.admin,
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: isDetailPage == false
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 100),
                  Padding(
                    padding: const EdgeInsets.only(left: 24),
                    child: Row(
                      children: [
                        Text(
                            "Selamat Datang, ${isAdmin == true ? "Admin" : "${userNameController.text}"}",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w500)),
                        Spacer(),
                        widget.admin == true
                            ? FilledButton(
                                onPressed: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            TambahBukuScreen())),
                                child: Text("Tambah Buku"))
                            : Container()
                      ],
                    ),
                  ),
                  SizedBox(height: 30),
                  Center(
                      child: Text(
                    'List Book',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  )),
                  SizedBox(height: 16),
                  Expanded(
                      child: FutureBuilder<List<Book>>(
                    future: getData(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else if (snapshot.hasData) {
                        return GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisSpacing: 24,
                                  mainAxisSpacing: 12,
                                  crossAxisCount: 2),
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                                onTap: () async {
                                  var bookId = snapshot.data![index].id;
                                  var bookData = await getDetailBook(bookId);
                                  setState(() {
                                    isDetailPage = !isDetailPage;
                                    idBook = bookId;
                                    dataBook = bookData;
                                  });
                                  print(dataBook);
                                },
                                child: BookCard(book: snapshot.data![index]));
                          },
                        );
                      } else {
                        return Text('No data');
                      }
                    },
                  )),
                ],
              )
            : FutureBuilder(
                future: getData(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (snapshot.hasData) {
                    return DetailPage(book: dataBook);
                  } else {
                    return Text('No data');
                  }
                },
              ));
  }
}
