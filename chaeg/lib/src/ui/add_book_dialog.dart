import 'dart:convert';
import 'package:chaeg/src/models/image_links.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/book.dart';
import '../models/volume_info.dart';
// Import the firebase_core and cloud_firestore plugin
import 'package:cloud_firestore/cloud_firestore.dart';

class AddBookDialog extends StatefulWidget {
  @override
  AddBookDialogState createState() => AddBookDialogState();

  // The callback function with data you want to return -------|
  final Function(String value) onConfirm; // <------------|

  Future<Book> fetchBook(String title, author) async {
    String? getUri;
    if (author == '') {
      getUri = 'https://www.googleapis.com/books/v1/volumes?q=$title';
    } else {
      getUri =
          'https://www.googleapis.com/books/v1/volumes?q=$title+inauthor:$author';
    }
    http.Response response = await http.get(Uri.parse(getUri));
    print(getUri);
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      final decodedJson = jsonDecode(response.body);
      final volumeInfoDynamic = decodedJson['items'][0]['volumeInfo'];
      final volumeInfo = VolumeInfo.fromJson(volumeInfoDynamic);
      dynamic imageLinksDynamic =
          decodedJson['items'][0]['volumeInfo']['imageLinks'];
      while (imageLinksDynamic == null) {
        var i = 1;
        imageLinksDynamic = decodedJson['items'][i]['volumeInfo']['imageLinks'];
        i += 1;
      }
      final imageLinks = ImageLinks.fromJson(imageLinksDynamic);
      return Book(volumeInfo: volumeInfo, imageLinks: imageLinks);
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
    print(title);
    print(author);
    return fetchBook(title, author).then((book) => books
        .add({
          'title': book.volumeInfo.title,
          'author': book.volumeInfo.author,
          'smallThumbnail': book.imageLinks.smallThumbnail,
          'thumbnail': book.imageLinks.thumbnail,
          'small': book.imageLinks.small,
          'medium': book.imageLinks.medium,
          'large': book.imageLinks.large,
          'extraLarge': book.imageLinks.extraLarge,
          'inBookPile': book.inBookPile
        })
        .then((value) => print("Book Added"))
        .catchError((error) => print("Failed to add book: $error")));
  }

  AddBookDialog({
    Key? key,
    required this.onConfirm,
  }) : super(key: key);
}

class AddBookDialogState extends State<AddBookDialog> {
  List<String> val = ['', ''];
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: const Text('Add a Book'),
        content: Wrap(
          children: [
            TextField(
              decoration: const InputDecoration(
                  contentPadding: EdgeInsets.all(5.0), labelText: 'Titre'),
              onChanged: (value) => val[0] = value,
            ),
            TextField(
              decoration: const InputDecoration(
                  contentPadding: EdgeInsets.all(5.0), labelText: 'Auteur'),
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
              widget.addBook(val[0], val[1]);
              Navigator.of(context).pop();
            },
          )
        ]);
  }
}
