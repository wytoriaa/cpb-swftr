import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';

class BookInfo{
  final String? key;
  final String title;
  final String author;
  final String about;
  final Uint8List? image;

  BookInfo({
    this.key,
    required this.title,
    required this.author,
    required this.about,
    required this.image,
  });

  static BookInfo fromMap(Map<String, dynamic> map, [String? key]) => 
    BookInfo(
      title: map["title"], 
      author: map ["author"],
      about: map["about"], 
      image: map ["image"]?.bytes
    );
  Map<String, dynamic> toMap() =>{
    'title': title,
    'author': author,
    'about': about,
    'image': image != null ? Blob(image!) : null
  };
}