import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/book.dart';
import 'package:flutter_application_1/widget/library_cell.dart';

class LibraryScreen extends StatelessWidget {
  const LibraryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var books = [
      for (var book in Data.books) LibraryCell(book)
    ];
    return Scaffold(
      body: Expanded(
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
          ),
          itemCount: books.length,
          itemBuilder: (context, index) {
            return (books[index]);
          },
        ),
      ),
    );
  }
}
