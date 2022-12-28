import 'package:flutter/material.dart';

void openSnackBar(context, snackMessage, color) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: color,
      action: SnackBarAction(
        textColor: Colors.white,
        label: 'ok',
        onPressed: () {},
      ),
      content: Text(
        snackMessage,
        style: const TextStyle(
          fontSize: 14,
        ),
      ),
    ),
  );
}
