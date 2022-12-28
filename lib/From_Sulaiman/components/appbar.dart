import 'package:flutter/material.dart';

AppBar buildAppBar(BuildContext context) {
  return AppBar(
    actions: [IconButton(onPressed: () async {}, icon: const Icon(Icons.lock))],
    backgroundColor: Colors.pink,
    title: const Text(
      'Restaurant App',
      style: TextStyle(
          color: Colors.white, fontSize: 24.00, fontWeight: FontWeight.bold),
    ),
    centerTitle: true,
    // leading: const Icon(Icons.notifications),
  );
}
