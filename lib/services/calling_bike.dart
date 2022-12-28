import 'dart:async';
import 'dart:ui';

import 'package:bonapp_restaurant/From_Sulaiman/screens/home_screen.dart';
import 'package:bonapp_restaurant/Utils/sanckbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../Utils/fluttertoast.dart';
import '../generated/l10n.dart';
import 'firbase.dart';
import 'dart:developer' as dev;

class CallBike {
  static StreamSubscription? newDocumentStreamForSingleDocumentRegistration;
  static StreamSubscription? newDocumentStreamForMultipleDocumentRegistration;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance.currentUser!.uid;
  String restaurantCollection = 'Restaurants';
  String pendingOrderCollection = 'Pending Orders';

  callABike({
    required String pendingOrderDocument,
    TextEditingController? controller,
    required int numberOfDestination,
    required bool doesItStartWithADigit,
    required BuildContext context,
    required RoundedLoadingButtonController buttonController,
    bool? rejectByTheRestaurant,
    bool? isDelivered,
    bool? isBikeAssigned,
    String? bikeIsCalled,
    bool? hasBikeCome,
    bool? canTheRestaurantRequestNewBike,
    List<TextEditingController>? destinationControllerList,
  }) async {
    // dev.debugger(when: true);
    bool isPendingOrderCollectionEmpty =
        await checkIfACollectionIsEmpty(collectionName: 'Pending Orders');
    if (isPendingOrderCollectionEmpty) {
      print('the pending orders collection is empty');
      if (controller!.text.isEmpty) {
        // because the one controller is empty I have to check if the list of the remaining destination is not empty
        if (destinationControllerList!.isEmpty) {
          // this plaace means there is an error. both the one controller and the list of controllers are null;

          openFlutterToast(
              context: context,
              errorMessage: S.of(context).pleaseFillIntheDestinationString);
          buttonController.error();
          buttonController.reset();
        } else {
          //  in the list of conotrollers is not empty;
          //  TODO: check if there is any empty controller inside of the list of controllers
          bool result = isThereAnEmptyController(destinationControllerList);
          print(' resutl from if there is an empth controller');

          // TODO  if there is any empty controller in the list  throw an error so that the user will fill everything before proceeding.
          if (result) {
            int numberOfEmptyControllers =
                getNumberOfEmptyControllers(destinationControllerList);
            print(
                'there number of empty controllers are/is $numberOfDestination');
            // TODO check how many of the controllers are empty.and show and error message .
            openFlutterToast(
                context: context,
                errorMessage: S.of(context).pleaseFillIntheDestinationString);
            buttonController.error();
            buttonController.reset();
          } else {
            // TODO every thing is normal continue with the code
            saveMultipleDestinationToTheDatabase(
                pendingOrderDocument: '1',
                // controller: controller,
                numberOfDestination: numberOfDestination,
                doesItStartWithADigit: doesItStartWithADigit,
                context: context,
                buttonController: buttonController,
                rejectByTheRestaurant: rejectByTheRestaurant!,
                isDelivered: isDelivered!,
                isBikeAssigned: isBikeAssigned!,
                bikeIsCalled: bikeIsCalled!,
                hasBikeCome: hasBikeCome!,
                canTheRestaurantRequestNewBike: canTheRestaurantRequestNewBike!,
                destinationControllerList: destinationControllerList);
          }
        }
      } else {
        // if it is here it means the following conditions are true;
        // the TextEditingController is not empty
        // the Pending Orders collection is empty. there is no  element what soever

        saveToTheDatabaseForASingleDestination(
            pendingOrderDocument: pendingOrderDocument,
            controller: controller,
            numberOfDestination: numberOfDestination,
            doesItStartWithADigit: doesItStartWithADigit,
            context: context,
            buttonController: buttonController,
            rejectByTheRestaurant: rejectByTheRestaurant!,
            isDelivered: isDelivered!,
            isBikeAssigned: isBikeAssigned!,
            bikeIsCalled: bikeIsCalled!,
            hasBikeCome: hasBikeCome!,
            canTheRestaurantRequestNewBike: canTheRestaurantRequestNewBike!);
      }
    } else {
      // the folling are true for the below code;
      // the collection is not empty
      // the collection may contain normal order and orders that starts with a digit.
      //  I will check if the collection contains any number digit returning true or false;
      // if it contains  i will then request the highest number of the document with digit;
      // check if that previous number has been delivered or not;
      // if the previous number has been delivered then I will add a number to the digit for a new document.

      //TODO cheking if the pending order collection has any previous digit orders:
      bool containsDigit =
          await checkIfCollectionContainsDigitOrders('Pending Orders');

      if (containsDigit) {
        int highestDigit = await getHighestDocDigit();
        bool previousOrderHasCompleted = await getAVariableInsedADocument(
            documentId: highestDigit.toString(),
            fieldName: 'can request a new bike');
        var result = await isThereAnEmptyController(destinationControllerList!);
        if (result) {
          openFlutterToast(
              context: context,
              errorMessage: S.of(context).pleaseFillIntheDestinationString);
          buttonController.error();
          buttonController.reset();
        } else {
          if (previousOrderHasCompleted) {
            if (controller!.text.isEmpty &&
                destinationControllerList!.isNotEmpty) {
              // if the code is here it means the collection Pending orders is not empty .
              // the restaurant is allowed to request for a new bike.
              saveMultipleDestinationToTheDatabase(
                  pendingOrderDocument: (highestDigit + 1).toString(),
                  numberOfDestination: numberOfDestination,
                  doesItStartWithADigit: doesItStartWithADigit,
                  context: context,
                  buttonController: buttonController,
                  rejectByTheRestaurant: rejectByTheRestaurant!,
                  isDelivered: isDelivered!,
                  isBikeAssigned: isBikeAssigned!,
                  bikeIsCalled: bikeIsCalled!,
                  hasBikeCome: hasBikeCome!,
                  canTheRestaurantRequestNewBike:
                      canTheRestaurantRequestNewBike!,
                  destinationControllerList: destinationControllerList);

              // TODO:  implement for many destinations when the  Pending Orders destination is not empty
            } else {
              bool result =
                  await isThereAnEmptyController(destinationControllerList!);
              if (result) {
                print('the result is $result');
                openFlutterToast(
                  context: context,
                  errorMessage: S.of(context).pleaseFillIntheDestinationString,
                );
                buttonController.error();
                buttonController.reset();
              }

              saveToTheDatabaseForASingleDestination(
                  pendingOrderDocument: (highestDigit + 1).toString(),
                  controller: controller,
                  numberOfDestination: numberOfDestination,
                  doesItStartWithADigit: doesItStartWithADigit,
                  context: context,
                  buttonController: buttonController,
                  rejectByTheRestaurant: rejectByTheRestaurant!,
                  isDelivered: isDelivered!,
                  isBikeAssigned: isBikeAssigned!,
                  bikeIsCalled: bikeIsCalled!,
                  hasBikeCome: hasBikeCome!,
                  canTheRestaurantRequestNewBike:
                      canTheRestaurantRequestNewBike!);
            }
          } else {
            // the previous order hasn't been completed as such they wont be able to call a bike.
            //
            openFlutterToast(
                context: context,
                errorMessage: S.of(context).aBikeIsAlreadyOnTheWayString);
            buttonController.error();
            buttonController.reset();
          }
        }
      }
    }
  }

  checkIfACollectionIsEmpty({required String collectionName, required}) async {
    QuerySnapshot doc = await firestore
        .collection(restaurantCollection)
        .doc(auth)
        .collection(collectionName)
        .get();
    if (doc.docs.isEmpty) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> sendEmailToTheBikes() async {
    try {
      String restaurantName = await getRestaurantName();
      sendMessageClass.sendMessage(
          bike1Email: 'motard1bonappgn@gmail.com',
          bike2Email: 'motard2bonappgn@gmail.com',
          bike3Email: 'motard3bonappgn@gmail.com',
          restaurantName: restaurantName);
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  getRestaurantName() async {
    DocumentSnapshot result =
        await firestore.collection(restaurantCollection).doc(auth).get();
    return result['Restaurant Name'];
  }

  Future<bool> checkIfCollectionContainsDigitOrders(collection) async {
    bool contains = false;
    QuerySnapshot result = await firestore
        .collection(restaurantCollection)
        .doc(auth)
        .collection(collection)
        .get();

    for (QueryDocumentSnapshot orderId in result.docs) {
      if (!orderId.id.startsWith('o')) {
        contains = true;
        break;
      }
      contains = false;
    }

    return contains;
  }

  Future<int> getHighestDocDigit() async {
    int digit = 0;

    QuerySnapshot result = await firestore
        .collection(restaurantCollection)
        .doc(auth)
        .collection('Pending Orders')
        .get();

    for (QueryDocumentSnapshot orderNumber in result.docs) {
      if (!orderNumber.id.startsWith('o')) {
        if (int.parse(orderNumber.id.toString()) > digit) {
          // if this particular number is bigger than the variable digit then this this new order becomes the highest
          digit = int.parse(orderNumber.id.toString());
        } else {}
      }
    }
    return digit;
  }

  Future<bool> getAVariableInsedADocument(
      {required String documentId, required String fieldName}) async {
    DocumentSnapshot result = await firestore
        .collection(restaurantCollection)
        .doc(auth)
        .collection('Pending Orders')
        .doc(documentId)
        .get();
    if (result[fieldName] == true) {
      return true;
    } else {
      return false;
    }
  }

  saveMultipleDestinationToTheDatabase({
    required String pendingOrderDocument,
    // required TextEditingController controller,
    required int numberOfDestination,
    required bool doesItStartWithADigit,
    required BuildContext context,
    required RoundedLoadingButtonController buttonController,
    required bool rejectByTheRestaurant,
    required bool isDelivered,
    required bool isBikeAssigned,
    required String bikeIsCalled,
    required bool hasBikeCome,
    required bool canTheRestaurantRequestNewBike,
    required List<TextEditingController> destinationControllerList,
  }) async {
    try {
      for (int i = 0; i < destinationControllerList.length; ++i) {
        firestore
            .collection(restaurantCollection)
            .doc(auth)
            .collection('Pending Orders')
            .doc(pendingOrderDocument)
            .set({
          'destination ${i + 1}': destinationControllerList[i].text,
        }, SetOptions(merge: true));
      }

      await firestore
          .collection(restaurantCollection)
          .doc(auth)
          .collection(pendingOrderCollection)
          .doc(pendingOrderDocument)
          .set({
        'number of destinations': destinationControllerList.length,
        'digit': doesItStartWithADigit,
        'rejected by restaurant': rejectByTheRestaurant,
        'delivered': isDelivered,
        'bike assigned': isBikeAssigned,
        'bike called': bikeIsCalled,
        'bike came': hasBikeCome,
        'can request a new bike': canTheRestaurantRequestNewBike,
      }, SetOptions(merge: true));
      bool isSuucessful = await sendEmailToTheBikes();
      if (isSuucessful) {
        newDocumentStreamForMultipleDocumentRegistration = firestore
            .collection(restaurantCollection)
            .doc(auth)
            .collection('Pending Orders')
            .doc(pendingOrderDocument)
            .snapshots()
            .listen((event) async {
          print(
              'something happened inside of the stream in call a bike function and the current event is ${event['can request a new bike']}');

          if (event['can request a new bike'] == false) {
            await Future.delayed(Duration(seconds: 2));
            buttonController.error();
          } else {
            await Future.delayed(Duration(seconds: 2));
            buttonController.reset();
          }
        });

        buttonController.success();
        openFlutterToast(
            backGroundColor: Colors.green,
            context: context,
            errorMessage: S.of(context).bikeIsOnItsWayString);
        await Future.delayed(
          Duration(milliseconds: 500),
        );
        buttonController.reset();
      }
    } on FirebaseException catch (e) {
      openFlutterToast(
          context: context, errorMessage: e.code, backGroundColor: Colors.red);
      buttonController.error();
      buttonController.reset();
    }
  }

  saveToTheDatabaseForASingleDestination({
    required String pendingOrderDocument,
    required TextEditingController controller,
    required int numberOfDestination,
    required bool doesItStartWithADigit,
    required BuildContext context,
    required RoundedLoadingButtonController buttonController,
    required bool rejectByTheRestaurant,
    required bool isDelivered,
    required bool isBikeAssigned,
    required String bikeIsCalled,
    required bool hasBikeCome,
    required bool canTheRestaurantRequestNewBike,
    List<TextEditingController>? destinationControllerList,
  }) async {
    try {
      await firestore
          .collection(restaurantCollection)
          .doc(auth)
          .collection(pendingOrderCollection)
          .doc(pendingOrderDocument)
          .set({
        'number of destinations': numberOfDestination,
        'destination': controller.text,
        'digit': doesItStartWithADigit,
        'rejected by restaurant': rejectByTheRestaurant,
        'delivered': isDelivered,
        'bike assigned': isBikeAssigned,
        'bike called': bikeIsCalled,
        'bike came': hasBikeCome,
        'can request a new bike': canTheRestaurantRequestNewBike,
      }, SetOptions(merge: true));
      bool isSuucessful = await sendEmailToTheBikes();
      if (isSuucessful) {
        newDocumentStreamForSingleDocumentRegistration = firestore
            .collection(restaurantCollection)
            .doc(auth)
            .collection('Pending Orders')
            .doc(pendingOrderDocument)
            .snapshots()
            .listen((event) async {
          print(
              'something happened inside of the stream in call a bike function and the current event is ${event['can request a new bike']}');

          if (event['can request a new bike'] == false) {
            await Future.delayed(Duration(seconds: 2));
            buttonController.error();
          } else {
            await Future.delayed(Duration(seconds: 2));
            buttonController.reset();
          }
        });

        buttonController.success();
        openFlutterToast(
            backGroundColor: Colors.green,
            context: context,
            errorMessage: S.of(context).bikeIsOnItsWayString);
        await Future.delayed(
          Duration(milliseconds: 500),
        );
        buttonController.reset();
      }
    } on FirebaseException catch (e) {
      openFlutterToast(
          context: context, errorMessage: e.code, backGroundColor: Colors.red);
      buttonController.error();
      buttonController.reset();
    }
  }

  bool isThereAnEmptyController(List<TextEditingController> controllersList) {
    bool isThereAnEmptyController = false;
    for (TextEditingController controller in controllersList) {
      if (controller.text.isEmpty) {
        isThereAnEmptyController = true;
      }
    }
    return isThereAnEmptyController;
  }

  int getNumberOfEmptyControllers(List<TextEditingController> controllersList) {
    int numberOfEmptyControllers = 0;
    for (TextEditingController controller in controllersList) {
      if (controller.text.isEmpty) {
        numberOfEmptyControllers++;
      }
    }

    return numberOfEmptyControllers;
  }
}
