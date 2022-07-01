import 'package:chaeg/src/wishlist/whishlist.dart';
import 'package:flutter/material.dart';

void main() {
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
          body: const TabBarView(
            children: [
              Whishlist(),
              Whishlist()
            ],
          ),
        ),
      ),
    );
  }
}
