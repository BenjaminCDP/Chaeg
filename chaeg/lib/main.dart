import 'package:chaeg/src/bookpile/bookpile.dart';
import 'package:chaeg/src/wishlist/wishlist.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const Chaeg());
}

class Chaeg extends StatelessWidget {
  const Chaeg({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
        appBar: AppBar(
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.book_rounded)),
              Tab(icon: Icon(Icons.menu_book_rounded))
            ],
          ),
          title: const Text('Chaeg'),
        ),
        body: TabBarView(
          children: [const Wishlist(), BookPile()],
        ),
      ),
      ),
    );
  }
}
