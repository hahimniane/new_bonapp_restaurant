import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

openFlutterToast(
    {required BuildContext context,
    required String errorMessage,
    ToastGravity gravity = ToastGravity.CENTER,
    Color backGroundColor = Colors.red}) {
  print('from the error message');
  Fluttertoast.showToast(
    gravity: gravity,
    toastLength: Toast.LENGTH_LONG,
    backgroundColor: backGroundColor,
    msg: errorMessage,
  );
}
