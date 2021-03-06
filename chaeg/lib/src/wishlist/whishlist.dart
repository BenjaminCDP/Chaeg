import 'package:chaeg/src/ui/add_book_dialog.dart';
import 'package:flutter/material.dart';

class Whishlist extends StatelessWidget {
  const Whishlist({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GridView.count(
            // Create a grid with 2 columns. If you change the scrollDirection to
            // horizontal, this produces 2 rows.
            crossAxisCount: 2,
            // Generate 100 widgets that display their index in the List.
            children: List.generate(100, (index) {
              return Center(
                  child: Text(
                "hihi",
                style: Theme.of(context).textTheme.headline5,
              ));
            })),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog<String>(
                context: context,
                builder: (context) => AddBookDialog(onConfirm: (String value) {
                      print(value);
                    }));
          },
          backgroundColor: Colors.blue,
          child: const Icon(Icons.add),
        ));
  }
}
