import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/book.dart';

class LibraryCell extends StatelessWidget {
  const LibraryCell(this.book, {super.key});

  final Book book;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, '/details', arguments: book);
        },
        child: Container(
          padding: const EdgeInsets.all(8),
          child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              //1
              child: Image.asset(book.image, width: 100),
            ),
            Text(
              book.name,
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    ));

  }
}
