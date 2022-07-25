import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/volume_info.dart';
// Import the firebase_core and cloud_firestore plugin
import 'package:cloud_firestore/cloud_firestore.dart';

class AddBookDialog extends StatefulWidget {
  @override
  AddBookDialogState createState() => AddBookDialogState();

  // The callback function with data you want to return -------|
  final Function(String value) onConfirm; // <------------|

  Future<VolumeInfo> fetchBook(String title, author) async {
    final response = await http
        .get(Uri.parse('https://www.googleapis.com/books/v1/volumes?q=$title+inauthor:$author'));
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      final decodedJson = jsonDecode(response.body);
      final info = decodedJson['items'][0]['volumeInfo'];
      return VolumeInfo.fromJson(info);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load Book');
    }
  }

  CollectionReference books = FirebaseFirestore.instance.collection('books');

  Future<void> addBook(String title, String author) {
    title = title.replaceAll(' ', '%20');
    author = author.replaceAll(' ', '%20');
    return fetchBook(title, author).then((volumeInfo) => books
        .add({'title': volumeInfo.title, 'author': volumeInfo.author})
        .then((value) => print("Book Added"))
        .catchError((error) => print("Failed to add book: $error")));
  }

  AddBookDialog({
    Key? key,
    required this.onConfirm,
  }) : super(key: key);
}

class AddBookDialogState extends State<AddBookDialog> {
  List<String> val = ['',''];
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: const Text('Add a Book'),
        content: Column(
          children: [
            TextField(
              onChanged: (value) => val[0] = value,
            ),
            TextField(
              onChanged: (value) => val[1] = value,
            )
          ],
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Annuler'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: const Text('Confirmer'),
            onPressed: () {
              widget.addBook(val[0],val[1]);
              Navigator.of(context).pop();
            },
          )
        ]);
  }
}
