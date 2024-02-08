import 'dart:convert';

class Book {
  int id;
  String nama;
  String penerbit;
  String penulis;
  String tahun;
  String deskripsi;
  String foto;
  bool tersedia;

  Book({
    required this.id,
    required this.nama,
    required this.penerbit,
    required this.penulis,
    required this.tahun,
    required this.deskripsi,
    required this.foto,
    required this.tersedia,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'nama': nama,
      'penerbit': penerbit,
      'penulis': penulis,
      'tahun': tahun,
      'deskripsi': deskripsi,
      'foto': foto,
      'tersedia': tersedia ? '1' : '0',
    };
  }

  factory Book.fromMap(Map<String, dynamic> map) {
    return Book(
      id: int.parse(map['id']),
      nama: map['nama'],
      penerbit: map['penerbit'],
      penulis: map['penulis'],
      tahun: map['tahun'],
      deskripsi: map['deskripsi'],
      foto: map['foto'],
      tersedia: map['tersedia'] == '1',
    );
  }

  String toJson() => json.encode(toMap());

  factory Book.fromJson(String source) =>
      Book.fromMap(json.decode(source) as Map<String, dynamic>);
}
