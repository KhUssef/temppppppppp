import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  final String buttonTitle;
  final Icon icon;
  final VoidCallback callback;
  const CustomDrawer(this.buttonTitle, this.icon, this.callback, {super.key});
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Scaffold(
        appBar: AppBar(),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset("assets/images.png", width: 100),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                leading: icon,
                title: Text(buttonTitle),
                onTap: callback,
              ),
            ),
          ],
        ),
      ),
    );
    
  }
}
