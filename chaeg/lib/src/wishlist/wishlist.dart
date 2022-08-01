import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../ui/add_book_dialog.dart';

class Wishlist extends StatefulWidget {
  const Wishlist({super.key});

  @override
  WishlistState createState() => WishlistState();

  
}

class WishlistState extends State<Wishlist> {
  final Stream<QuerySnapshot> _booksStream =
      FirebaseFirestore.instance.collection('books').where('inBookPile',isEqualTo: false).snapshots();

  Future<void> addToBookPile(String documentId){
    return FirebaseFirestore.instance.collection('books').doc(documentId).update({'inBookPile' : true}).then((value) => null)..catchError((error) => print("Failed to delete book's property: $error"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<QuerySnapshot>(
          stream: _booksStream,
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
                  leading: Image.network(data['thumbnail']),
                  title: Text(data['title']),
                  subtitle: Text(data['author']),
                  trailing:  InkWell(
                    onTap: () => addToBookPile(document.id),
                    child: const Icon(
                    Icons.arrow_right_alt,
                    color: Colors.blue,
                    
                  ),
                )
                );
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
                      }, inBookPile: false,));
            },
            backgroundColor: Colors.blue,
            child: const Icon(Icons.add)));
  }
}
