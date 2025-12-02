import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/book.dart';
import 'package:flutter_application_1/widget/card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var books = [
      for (var book in Data.books) CardWidget(book)
    ];
    return Scaffold(
        body: ListView.builder(
        itemCount: books.length,
        itemBuilder: (context, index) => books[index],
      ),
    );
  }
}
