import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/book.dart';
class CardWidget extends StatelessWidget {
  const CardWidget(this.book, {super.key});

  final Book book;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: const EdgeInsets.all(8),
        child: Row(
          //SpaceAround or SpaceBetween
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          //sizeBoxed
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.asset(
                book.image,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                //book name
                Text(
                  book.name,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                //book price
                Text(
                  book.price.toString(),
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
