import 'package:chaeg/src/services/add_book.dart';
import 'package:chaeg/src/services/get_books.dart';
import 'package:flutter/material.dart';


class BookPile extends StatelessWidget {
  const BookPile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body : GetBooks());
  }
}
