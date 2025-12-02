import 'package:flutter/material.dart';
import 'package:flutter_application_1/home.dart';
import 'package:flutter_application_1/library_screen.dart';
import 'package:flutter_application_1/widget/drawer.dart';

class BottomNavbar extends StatefulWidget {
  const BottomNavbar({super.key});

  @override
  State<BottomNavbar> createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbar> {
  var mCurrentIndex = 0;
  @override
  Widget build(BuildContext context) {
    List<Widget> pages = [HomeScreen(), LibraryScreen(), BasketScreen()];
    return Scaffold(
       appBar: AppBar(
       backgroundColor: const Color.fromARGB(255, 33, 107, 235),
       title: const Text(
         "Store INSAT",
         style: TextStyle(
           color: Colors.white,
           fontSize: 30,
           fontWeight: FontWeight.bold,
         ),
       ),
      ),
      drawer: CustomDrawer("use tap bar navigation", Icon(Icons.menu), () {Navigator.pushNamed(context, '/tapbar');}),
      body: pages[mCurrentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: mCurrentIndex,
        onTap: (value) {
          setState(() {
            mCurrentIndex = value;
          });
        },
        items: [
          //1
          BottomNavigationBarItem(
            icon: const Icon(Icons.home_outlined),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.bookmark_outline),
            label: "Library",
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.shopping_basket),
            label: "Basket",
          ),
        ],
      ),
    );
  }
}

class BasketScreen extends StatelessWidget {
  const BasketScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("Basket Screen"),
    );
  }
}
