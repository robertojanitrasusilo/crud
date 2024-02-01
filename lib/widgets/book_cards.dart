import 'package:flutter/material.dart';

class BookCard extends StatelessWidget {
  final int id;
  final String title;
  final String image;
  final bool statusPinjam;

  const BookCard({
    Key? key,
    required this.id,
    required this.title,
    required this.image,
    required this.statusPinjam,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 110,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                image: DecorationImage(
                    image: AssetImage(image),
                    fit: BoxFit.fitWidth,
                    alignment: Alignment.topCenter)),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        overflow: TextOverflow.ellipsis),
                    maxLines: 2),
                SizedBox(height: 5),
                Text(statusPinjam ? 'Dipinjam' : 'Tersedia')
              ],
            ),
          )
        ],
      ),
    );
  }
}
