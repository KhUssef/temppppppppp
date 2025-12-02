import 'package:flutter/material.dart';
import 'package:flutter_application_1/home.dart';
import 'package:flutter_application_1/library_screen.dart';
import 'package:flutter_application_1/widget/drawer.dart';
import 'package:flutter_application_1/widget/theme_controller.dart';
import 'package:flutter_application_1/basket_screen.dart';

class MyTabBar extends StatefulWidget {
  const MyTabBar({super.key});

  @override
  State<MyTabBar> createState() => _MyTabBarState();
}

class _MyTabBarState extends State<MyTabBar> with TickerProviderStateMixin {
  late TabController tabController; 
  
  List<Widget> pages = [
    HomeScreen(),
    LibraryScreen(),
    BasketScreen(),
  ];

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this); 
    tabController.addListener(() {
      setState(() {}); 
    });
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
  return Scaffold(
    drawer: CustomDrawer("use bottom bar navigation", Icon(Icons.menu), () {Navigator.pushNamed(context, '/bottombar');}),
    appBar: AppBar(
    title: const Text('Store INSAT'),
      actions: [
        ValueListenableBuilder<ThemeMode>(
          valueListenable: themeNotifier,
          builder: (context, mode, _) {
            return IconButton(
              tooltip: mode == ThemeMode.light ? 'Passer en sombre' : 'Passer en clair',
              icon: Icon(mode == ThemeMode.light ? Icons.dark_mode : Icons.light_mode),
              onPressed: () {
                themeNotifier.value = mode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
              },
            );
          },
        ),
      ],
      bottom: TabBar(
        controller: tabController,
        labelColor: Colors.white,
        tabs: [
          Tab(icon: Icon(Icons.home_outlined), text: "Home"),
          Tab(icon: Icon(Icons.bookmark_outline), text: "Library"),
          Tab(icon: Icon(Icons.shopping_bag), text: "Basket"),
        ],
      ),
    ),
    body: pages[tabController.index],
  );
  }

}
// Uses real BasketScreen from lib/basket_screen.dart