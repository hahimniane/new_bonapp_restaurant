import 'package:flutter/material.dart';

import '../screens/home_screen.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      unselectedItemColor: Colors.white,
      items: [
        BottomNavigationBarItem(
            backgroundColor: Colors.pink,
            icon: IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const HomeScreen()));
              },
              icon: const Icon(Icons.home),
            ),
            label: 'Home'),
        BottomNavigationBarItem(
            backgroundColor: Colors.pink,
            icon: IconButton(
              onPressed: () {
                // Navigator.push(context,
                //     MaterialPageRoute(builder: (context) => OrderScreen()));
              },
              icon: const Icon(Icons.shopping_cart),
            ),
            label: 'Orders'),
        const BottomNavigationBarItem(
            backgroundColor: Colors.pink,
            icon: Icon(Icons.menu_book),
            label: 'Order'),
        const BottomNavigationBarItem(
            backgroundColor: Colors.pink,
            icon: Icon(Icons.settings),
            label: 'Setting'),
      ],
    );
  }
}
