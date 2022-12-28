import 'package:flutter/material.dart';

Expanded specialMenusChildren(
  VoidCallback onTap,
  double height,
  double width,
  IconData iconData,
  Color containerColor,
  String foodName,
) {
  return Expanded(
    child: GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
              color: containerColor, borderRadius: BorderRadius.circular(5)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                iconData,
                color: Colors.white,
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Text(
                  foodName,
                  style: const TextStyle(
                      textBaseline: TextBaseline.alphabetic,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                ),
              )
            ],
          ),
          height: height * 0.09,
          width: width * 0.07,
        ),
      ),
    ),
  );
}

// for all of the textButtons
TextButton buildTextButton(
  VoidCallback function,
  Color backgrounColor,
  String label,
) {
  return TextButton(
    style: TextButton.styleFrom(
      backgroundColor: backgrounColor,
    ),
    onPressed: function,
    child: Text(
      label,
      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
    ),
  );
}

// for all of the textboxes
Padding buildTextField(double width, double height, String hintText,
    double heightMultiplier, TextEditingController controller) {
  return Padding(
    padding: const EdgeInsets.all(0.0),
    child: SizedBox(
      width: width * 0.95,
      height: height * heightMultiplier,
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintTextDirection: TextDirection.ltr,
          border: const OutlineInputBorder(
              borderSide: BorderSide(
            color: Colors.grey,
          )),
          hintText: hintText,
        ),
      ),
    ),
  );
}
