import 'package:chaeg/src/models/book.dart';
import 'package:flutter/material.dart';

// Import the firebase_core and cloud_firestore plugin
import 'package:cloud_firestore/cloud_firestore.dart';

class AddBook extends StatelessWidget {
  final Book book;

  const AddBook({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    // Create a CollectionReference called users that references the firestore collection
    CollectionReference books = FirebaseFirestore.instance.collection('books');

    Future<void> addBook() {
      // Call the user's CollectionReference to add a new user
      return books
          .add({'name': book.name})
          .then((value) => print("Book Added"))
          .catchError((error) => print("Failed to add book: $error"));
    }

    return TextButton(
      onPressed: () {
        addBook();
        Navigator.pop(context);
      },
      child: const Text(
        "Add Book",
      ),
    );
  }
}
