import 'package:chaeg/src/services/add_book.dart';
import 'package:flutter/material.dart';

import '../models/book.dart';

class AddBookDialog extends StatefulWidget {
  @override
  _AddBookDialogState createState() => _AddBookDialogState();

  // The callback function with data you want to return -------|
  final Function(String value) onConfirm; // <------------|

  const AddBookDialog({
    Key? key,
    required this.onConfirm,
  }) : super(key: key);
}

class _AddBookDialogState extends State<AddBookDialog> {
  Book book = Book(name: "");

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: const Text('Add a Book'),
        content: TextField(
          onChanged: (val) {
            setState(() {
              book.setName(val);
            });
          },
        ),
        actions: <Widget>[
          AddBook(book: book)
        ]);
  }
}
