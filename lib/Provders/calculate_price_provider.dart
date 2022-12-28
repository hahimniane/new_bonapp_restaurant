import 'package:flutter/material.dart';

class CalculatePriceProvider extends ChangeNotifier {
  List locationsToDeliver = ['', '', '', '', '', ''];

  updatePrice(index, locattion) {
    locationsToDeliver[index] = locattion;
    // print('the provider function was called');
    notifyListeners();
  }
}
