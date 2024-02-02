// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Book {
  int id;
  String nama;
  String penerbit;
  int tahun;
  String deskripsi;
  String foto;
  bool tersedia;
  Book({
    required this.id,
    required this.nama,
    required this.penerbit,
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
      'tahun': tahun,
      'deskripsi': deskripsi,
      'foto': foto,
      'tersedia': tersedia,
    };
  }

  factory Book.fromMap(Map<String, dynamic> map) {
    return Book(
      id: map['id'] as int,
      nama: map['nama'] as String,
      penerbit: map['penerbit'] as String,
      tahun: map['tahun'] as int,
      deskripsi: map['deskripsi'] as String,
      foto: map['foto'] as String,
      tersedia: map['tersedia'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory Book.fromJson(String source) =>
      Book.fromMap(json.decode(source) as Map<String, dynamic>);
}
