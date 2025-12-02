import 'package:flutter/material.dart';

class HomeCell extends StatelessWidget {
  const HomeCell({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        print("Tapped");
      },
      child:
    Row(
      children: [
        Image.asset(
          "assets/image1.png", // A modifier
          width: 50,
        ),
        const Column(
          children: [
            Text("name 2"), //a modifier
            Text("name 3 "), //A modifier
          ],
        ),
      ],
      
    )
    );
  }
}
