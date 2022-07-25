import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class GetBooks extends StatefulWidget {
  @override
  _GetBooksState createState() => _GetBooksState();
}

class _GetBooksState extends State<GetBooks> {
  final Stream<QuerySnapshot> _booksStream =
      FirebaseFirestore.instance.collection('books').snapshots();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: booksStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading");
        }

        return ListView(
          children: snapshot.data!.docs.map((DocumentSnapshot document) {
            Map<String, dynamic> data =
                document.data()! as Map<String, dynamic>;
            return ListTile(
              title: Text(data['title']),
              subtitle: Text(data['author']),
            );
          }).toList(),
        );
      },
    );
  }

  get booksStream => _booksStream;
}
