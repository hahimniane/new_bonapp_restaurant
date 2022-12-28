import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class CalculatePrice {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  FirebaseAuth _auth = FirebaseAuth.instance;
  // TextEditingController destination;

  Future<String?> fetchUserLocation() async {
    DocumentSnapshot result = await _firestore
        .collection('Restaurants')
        .doc(_auth.currentUser!.uid)
        .get();
    if (result.exists) {
      return result['Community'];
    } else
      return null;
  }

  Future<num> calculatePrice([destination, List? destinations]) async {
    //TODO first call the function that returns  the restaurant location;
    String? restaurantLocation = await fetchUserLocation();
    if (restaurantLocation != null) {
      // print('the restaurant location from database $restaurantLocation');
      //TODO: call the function that actually calculates the price;
      int result = await calculatePriceForASingleLocation(
          destination, restaurantLocation);
      return result;
    }
    return 0;
  }

  Future<int> calculatePriceForASingleLocation(
      destination, restaurantLocation) async {
    int totalPrices = 0;

    String textFormOfThedestination =
        destination == TextEditingController ? destination.text : destination;
    //takes the string form of the destination controller;
    DocumentSnapshot valueToReturn = await FirebaseFirestore.instance
        .collection('Country')
        .doc('Guinea')
        .get();

    if (valueToReturn.exists) {
      var restaurantFirstLetterCapitalized = convertString(restaurantLocation);

      var price = await valueToReturn['Destinations']
              [restaurantFirstLetterCapitalized][
          '${restaurantLocation.toLowerCase()}_${textFormOfThedestination.toLowerCase()}'];
      // print('the price is $price');
      if (price != null) {
        totalPrices = totalPrices + int.parse(price);
      }
    }
    return totalPrices;
  }

  calculatePriceForMultipleLocations(List listOfDestinations) {}

  String convertString(String destination) {
    String capitalizedString = destination[0].toUpperCase().trim() +
        destination.substring(1).trim().toLowerCase();
    return capitalizedString;
  }
}
