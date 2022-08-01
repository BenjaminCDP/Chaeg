import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../ui/add_book_dialog.dart';

class BookPile extends StatefulWidget {
  @override
  _BookPileState createState() => _BookPileState();
}

class _BookPileState extends State<BookPile> {
  final Stream<QuerySnapshot> _booksStream =
      FirebaseFirestore.instance.collection('books').where('inBookPile',isEqualTo: true).snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<QuerySnapshot>(
          stream: booksStream,
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return const Text('Something went wrong');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Text("Loading");
            }

            return GridView.count(
              crossAxisCount: 2,
              children: snapshot.data!.docs.map((DocumentSnapshot document) {
                Map<String, dynamic> data =
                    document.data()! as Map<String, dynamic>;
                return Image.network(data['thumbnail']);
              }).toList(),
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              showDialog<String>(
                  context: context,
                  builder: (context) =>
                      AddBookDialog(onConfirm: (String value) {
                        print(value);
                      }, inBookPile: true,));
            },
            backgroundColor: Colors.blue,
            child: const Icon(Icons.add)));
  }

  get booksStream => _booksStream;
}
