import 'dart:convert';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:email_validator/email_validator.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../From_Sulaiman/screens/home_screen.dart';
import '../From_Sulaiman/screens/login_screen.dart';
import '../Utils/sanckbar.dart';
import '../average_time_page.dart';
import '../averege_price_page.dart';
import 'package:http/http.dart' as http;

class FirebaseAthentications {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  String restaurantsCollection = 'Restaurants';
  String menusCollection = 'Menus';
  String restaurantsDatabaseCollection = 'Restaurants Database';
  static String exceptionalRestaurantsCollection = 'Exceptional Restaurants';

  var pendingOrdersDatabaseCollection = 'Pending Orders';
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  saveUserKeyToSharedPrefrences() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('documentId', auth.currentUser!.uid.toString());
    print(prefs.get('documentId'));
  }

  getVerification() {
    auth.verifyPhoneNumber(
        phoneNumber: '+905541524403',
        verificationCompleted: (PhoneAuthCredential) {},
        verificationFailed: (FirebaseAuthException error) {},
        codeSent: (String verificationId, int? forceResendingToken) {
          print('It is sent');
        },
        codeAutoRetrievalTimeout: (String verificationId) {});
  }

  SignUpUser(BuildContext context, String email, String password,
      String userName, String fullAddress, String phoneNumber, String community,
      [restaurantFoundationDate,
      RoundedLoadingButtonController? controller]) async {
    try {
      // var platform;
      var token;
      token = await messaging.getToken();
      // if (Platform.isIOS) {
      //   platform = 'Ios Token';
      // } else {
      //   platform = 'android token';
      // }
      String? currentUser;
      var newUser = await auth.createUserWithEmailAndPassword(
          email: email, password: password);

      currentUser = auth.currentUser?.uid;

      User? user = newUser.user;
      user?.updateDisplayName(userName);
      user?.updatePhotoURL('');
      // user?.updatePhoneNumber(PhoneAuthCredential.parse(phoneNumber));
      firestore
          .collection(restaurantsCollection.trim())
          .doc(auth.currentUser?.uid)
          .set({
            'restaurant foundation date': restaurantFoundationDate,
            'Email': email,
            'Restaurant Name': userName,
            'Restaurant Full Address': fullAddress,
            'Phone Number': phoneNumber,
            'Community': community,
            'active Locale': 'English',
            'Token': token
          })
          .then((value) => {
                firestore
                    .collection(restaurantsCollection.trim())
                    .doc(auth.currentUser!.uid)
                    .update({'user id': auth.currentUser!.uid})
              })
          .then((value) => {
                firestore
                    .collection(restaurantsCollection.trim())
                    .doc(auth.currentUser!.uid)
                    .update(
                  {
                    'active': false,
                    'rating': '10',
                    'speed': '10',
                    'service': '10',
                    'taste': '10',
                    // 'array': FieldValue.arrayUnion(elements)
                  },
                ),
              })
          .then((value) => {
                controller?.success(),
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AveragePricePage()))
              })
          .then((value) => {
                firestore
                    .collection('All restaurant profile Pictures')
                    .doc(auth.currentUser!.uid)
                    .set({'location': community, 'restaurant name': userName})
              })
          .then((value) => {
                // ref = FirebaseStorage.instance
                //     .ref('menus/${auth.currentUser!.uid}'),
              })
          .then((value) => {
                defaultRestaurantProfilePicFunction(
                    'https://firebasestorage.googleapis.com/v0/b/yemeksepeti-f4347.appspot.com/o/default_photos%2FdefaultRestaurantProfilePicture.png?alt=media&token=a273874d-7b6b-41d3-b228-d9a5e27f7bcf'),
              })
          .then((value) => {
                defaultRestaurantCoverFunction(
                    'https://firebasestorage.googleapis.com/v0/b/yemeksepeti-f4347.appspot.com/o/default_photos%2FdefaultRestaurantCoverPicture.jpg?alt=media&token=02967120-1807-42d6-9e78-1913fc1f99ac'),
              })
          .then((value) => {
                firestore.collection('Statistics').doc('Data').set({
                  'Total restaurants': FieldValue.increment(1),
                }, SetOptions(merge: true)),
                saveUserKeyToSharedPrefrences(),
              })
          .then(
            (value) => {},
          );
    } on FirebaseAuthException catch (e) {
      controller?.error();
      controller?.reset();

      Fluttertoast.showToast(
          msg: e.message.toString(),
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.grey,
          textColor: Colors.white,
          fontSize: 20.0);
    }
  }

  signInUser(String email, String password, BuildContext context,
      [RoundedLoadingButtonController? controller]) async {
    try {
      if (EmailValidator.validate(email)) {
        print(EmailValidator.validate(email));
        try {
          UserCredential result = await auth.signInWithEmailAndPassword(
              email: email, password: password);
          print('the result is a success');
          if (result.user != null) {
            bool exist;

            firestore
                .collection(restaurantsCollection.trim())
                .doc(auth.currentUser!.uid)
                .get()
                .then((value) async => {
                      value.exists ? exist = true : exist = false,
                      if (exist)
                        {
                          print('the user is from the restaurant app'),
                          controller?.success(),
                          await Future.delayed(Duration(seconds: 1)),
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const HomeScreen()))
                        }
                      else
                        {print('the user is not a restaurant')}
                    });
          }
        } on FirebaseAuthException catch (e) {
          openSnackBar(context, e.message, Colors.red);
          controller?.reset();
        }
      } else {
        var displayNme = auth.currentUser?.displayName;
        if (displayNme == email) {
          bool exist;
          auth
              .signInWithEmailAndPassword(
                  email: auth.currentUser!.email.toString(), password: password)
              .then((value) => {
                    firestore
                        .collection(restaurantsDatabaseCollection.trim())
                        .doc(auth.currentUser!.uid)
                        .get()
                        .then((value) => {
                              value.exists ? exist = true : exist = false,
                              if (exist)
                                {
                                  EasyLoading.dismiss(),
                                  print('the user is from the restaurant app'),
                                  // Navigator.push(
                                  //     context,
                                  //     MaterialPageRoute(
                                  //         builder: (context) => FirstPage())),
                                }
                              else
                                {
                                  print('the user is not a restaurant'),
                                  EasyLoading.dismiss(),
                                }
                            })
                  });
        }
      }
    } on FirebaseAuthException catch (e) {
      controller?.error();
      Fluttertoast.showToast(
          msg: e.message.toString(),
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 20.0);
    }
    // controller?.reset();
  }

  logoutUser(context) {
    try {
      auth.signOut().then((value) => {
            // Navigator.pop(context)
            // Navigator.push(
            //     context, MaterialPageRoute(builder: (context) => WelcomePage()))
          });
    } on FirebaseException catch (e) {
      print(e.message);
    }
  }

  resetPassword(String email) async {
    try {
      await auth.sendPasswordResetEmail(email: email).then((value) => {
            Fluttertoast.showToast(
                msg: 'the  reset code was sent to your email',
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.green,
                textColor: Colors.white,
                fontSize: 20.0)
          });
    } on FirebaseException catch (e) {
      Fluttertoast.showToast(
          msg: e.message.toString(),
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.pink,
          textColor: Colors.white,
          fontSize: 20.0);
    }
  }

// this function checks if there is already a menu in the past then add
  Future<bool> getLastMenNumber(
      name,
      description,
      price,
      imageLink,
      String compulsoryIngredient,
      List<dynamic> ingredientsList,
      String foodType) async {
    print(auth.currentUser!.uid);

    var lastMenu;
    try {
      var getDoc = await firestore
          .collection(restaurantsCollection.trim())
          .doc(auth.currentUser!.uid)
          .collection(menusCollection.trim())
          .get();
      // .then((QuerySnapshot querySnapshot) {
      // print(int.parse(querySnapshot.docs.last.id) + 1);
      if (getDoc.docs.isNotEmpty) {
        firestore
            .collection(restaurantsCollection.trim())
            .doc(auth.currentUser!.uid)
            .collection(menusCollection.trim())
            .doc((int.parse(getDoc.docs.last.id) + 1).toString())
            .set({
          'foodType': foodType,
          'food name': name,
          'description': description,
          'food price': price,
          'image link': imageLink,
          'ingredient': FieldValue.arrayUnion(
            [compulsoryIngredient],
          ),
          'active': true,
          // 'first ingredient': ingredient1,
          // 'second ingredient': ingredient2,
          // 'third ingredient': ingredient3,
        }).then((value) => {
                  // firestore
                  //     .collection('MenuPhotos')
                  //     .doc(auth.currentUser!.uid)
                  //     .set({
                  //   'image url': imageLink,
                  // })
                  for (int i = 0; i < ingredientsList.length; ++i)
                    {
                      firestore
                          .collection(restaurantsCollection.trim())
                          .doc(auth.currentUser!.uid)
                          .collection(menusCollection.trim())
                          .doc((int.parse(getDoc.docs.last.id) + 1).toString())
                          .update({
                        'ingredient':
                            FieldValue.arrayUnion([ingredientsList[i].text]),

                        // 'food name': name,
                        // 'description': description,
                        // 'food price': price,
                        // 'image link': imageLink,
                        // 'first ingredient': ingredient1,
                        // 'second ingredient': ingredient2,
                        // 'third ingredient': ingredient3,
                      }),
                      // SetOptions(merge: true)
                    }
                });
        return true;
      } else {
        firestore
            .collection(restaurantsCollection.trim())
            .doc(auth.currentUser!.uid)
            .collection(menusCollection.trim())
            .doc(('1').toString())
            .set({
          'active': true,
          'food name': name,
          'description': description,
          'food price': price,
          'image link': imageLink,
          'ingredient': FieldValue.arrayUnion(
            [compulsoryIngredient],
          ),
          // 'first ingredient': ingredient1,
          // 'second ingredient': ingredient2,
          // 'third ingredient': ingredient3,
        }).then((value) => {
                  for (int i = 0; i < ingredientsList.length; i++)
                    {
                      firestore
                          .collection(restaurantsCollection.trim())
                          .doc(auth.currentUser!.uid)
                          .collection(menusCollection.trim())
                          .doc(('1').toString())
                          .update({
                        'ingredient':
                            FieldValue.arrayUnion([ingredientsList[i].text]),
                      }),
                      // SetOptions(merge: true),

                      // firestore
                      //     .collection('MenuPhotos')
                      //     .doc(auth.currentUser!.uid)
                      //     .set({
                      //   'image url': imageLink,
                      //  })
                    }
                });
        return true;
      }
    } on FirebaseException catch (e) {
      return false;
    }
  }

  // Future<String?> getMenuLinks() async {
  //   CollectionReference documentReference = firestore.collection('MenuPhotos');
  //   String? url;
  //   List list = [];
  //   await documentReference.get().then((snapshot) {
  //     for (int i = 0; i < snapshot.size; ++i) {
  //       url = snapshot.docs[i]['image url'];
  //       list.add(url);
  //       print('came from firebase  ' + list[i]);
  //     }
  //   });
  //
  //   return url;
  // }

  uploadRestaurantCoverPhoto(imageUrl) {
    firestore.collection('MenuPhotos').doc(auth.currentUser!.uid).update({
      'cover image url': imageUrl,
    }).then((value) => {
          firestore
              .collection(restaurantsCollection.trim())
              .doc(auth.currentUser!.uid)
              .update(
            {'cover image url': imageUrl},
            // SetOptions(merge: true),
          ),
        });
  }

  uploadRestaurantProfilePhoto(imageUrl, [context]) {
    firestore
        .collection('All restaurant profile Pictures')
        .doc(auth.currentUser!.uid)
        .update({
      'image url': imageUrl,
    }).then((value) => {
              firestore
                  .collection(restaurantsCollection.trim())
                  .doc(auth.currentUser!.uid)
                  .update(
                {
                  'profile image url': imageUrl,
                },
              ),
              // Navigator.push(context,
              //     MaterialPageRoute(builder: (context) => const FirstPage())),
            });
  }

  defaultRestaurantProfilePicFunction(
    imageUrl,
  ) {
    firestore
        .collection('All restaurant profile Pictures')
        .doc(auth.currentUser!.uid)
        .set({
      'image url': imageUrl,
    }, SetOptions(merge: true)).then((value) => {
              firestore
                  .collection(restaurantsCollection.trim())
                  .doc(auth.currentUser!.uid)
                  .update(
                {
                  'profile image url': imageUrl,
                },
              ),
              // Navigator.push(context,
              //     MaterialPageRoute(builder: (context) => const FirstPage()),
              // ),
            });
  }

  defaultRestaurantCoverFunction(
    imageUrl,
  ) {
    firestore.collection('MenuPhotos').doc(auth.currentUser!.uid).set({
      'cover image url': imageUrl,
    }).then((value) => {
          firestore
              .collection(restaurantsCollection.trim())
              .doc(auth.currentUser!.uid)
              .update(
            {
              'cover image url': imageUrl,
            },
          ),
          // Navigator.push(context,
          //     MaterialPageRoute(builder: (context) => const FirstPage()),
          // ),
        });
  }

  void updateAverageRestaurantPrice(averagePrice, context) {
    firestore
        .collection(restaurantsCollection.trim())
        .doc(auth.currentUser!.uid)
        .update(
      {
        'average price': averagePrice,
      },
    ).then((value) => {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const AverageTimePage()))
            });
  }

  void updateAverageRestaurantTime(averageTime, context) {
    firestore
        .collection(restaurantsCollection.trim())
        .doc(auth.currentUser!.uid)
        .update(
      {
        'average time': averageTime,
      },
    ).then((value) => {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const HomeScreen()))
            });
  }

  declineOrder(orderId) async {
    DocumentReference copyFrom;
    // await firestore.collection(restaurantsDatabaseCollection.trim()).doc(auth.currentUser!.uid).collection(pendingOrdersDatabaseCollection.trim()).doc(orderId).
  }

  // confirmOrder(totalPrice, String paymentMethodType, context,
  //     [double? latitude, double? longitude, locationId]) async {
  //   var sellerRestaurantName;
  //   var restaurantName;
  //   var documents = await firestore
  //       .collection(FirebaseAuthentications.customersCollection.trim())
  //       .doc(auth.currentUser!.uid)
  //       .collection(FirebaseAuthentications.basketCollection.trim())
  //       .get();
  //   //this below line goes through the first element in the customer's basket and collect the restaurant id to which they have chosen to order from.
  //   var copyResId = documents.docs.first['restaurant'];
  //   var restaurantId = documents.docs.first['restaurant'];
  //
  //   DocumentReference copyFrom;
  //   for (int i = 0; i < documents.docs.length; ++i) {
  //     /* the below code goes to the customer's collection then in the  current user document  and then the basket collection.
  //     and then it will take the document id  at the i'th place and save it to copyFrom variable.
  //
  //     */
  //     copyFrom = firestore
  //         .collection(FirebaseAuthentications.customersCollection.trim())
  //         .doc(auth.currentUser!.uid)
  //         .collection(FirebaseAuthentications.basketCollection.trim())
  //         .doc(documents.docs[i].id);
  //
  //     DocumentReference copyTo = firestore
  //         .collection(FirebaseAuthentications.customersCollection.trim())
  //         .doc(auth.currentUser!.uid)
  //         .collection('Orders')
  //         .doc(
  //         'order${DateTime.now().year + DateTime.now().month + DateTime.now().day + DateTime.now().hour + DateTime.now().minute}')
  //         .collection('Order')
  //         .doc(documents.docs[i].id);
  //
  //     DocumentReference copyToRestaurant = firestore
  //         .collection(FirebaseAuthentications.restaurantsCollection.trim())
  //         .doc(copyResId)
  //         .collection(FirebaseAuthentications.pendingOrdersCollection.trim())
  //         .doc(
  //         'order${DateTime.now().year + DateTime.now().month + DateTime.now().day + DateTime.now().hour + DateTime.now().minute}')
  //         .collection('Order')
  //         .doc(documents.docs[i].id);
  //
  //     copyFrom
  //         .get()
  //         .then((value1) => {
  //       copyTo.set(
  //         value1.data(),
  //       ),
  //       copyToRestaurant.set(value1.data()),
  //       copyTo.update({})
  //     })
  //         .then((value) => {
  //       firestore
  //           .collection(
  //           FirebaseAuthentications.customersCollection.trim())
  //           .doc(auth.currentUser!.uid)
  //           .collection('Orders')
  //           .doc(
  //           'order${DateTime.now().year + DateTime.now().month + DateTime.now().day + DateTime.now().hour + DateTime.now().minute}')
  //           .set({'dummy data': 'x'}, SetOptions(merge: true)),
  //       firestore
  //           .collection(
  //           FirebaseAuthentications.restaurantsCollection.trim())
  //           .doc(copyResId)
  //           .collection(
  //           FirebaseAuthentications.pendingOrdersCollection.trim())
  //           .doc(
  //           'order${DateTime.now().year + DateTime.now().month + DateTime.now().day + DateTime.now().hour + DateTime.now().minute}')
  //           .set({'bike called': '0', 'call bike': true},
  //           SetOptions(merge: true)),
  //     });
  //   }
  //
  //   FirebaseFirestore.instance
  //       .collection(FirebaseAuthentications.customersCollection.trim())
  //       .doc(auth.currentUser!.uid)
  //       .collection(FirebaseAuthentications.ordersCollection.trim())
  //       .doc(
  //       'order${DateTime.now().year + DateTime.now().month + DateTime.now().day + DateTime.now().hour + DateTime.now().minute}')
  //       .collection('Order')
  //       .doc('total price and location')
  //       .set(
  //     {
  //       'latitude': latitude,
  //       'longitude': longitude,
  //       'Total Price': totalPrice,
  //       'location': locationId,
  //       'Payment Type': paymentMethodType,
  //       'Order Date': DateTime.now()
  //     },
  //   )
  //       .then((value) => {
  //     FirebaseFirestore.instance
  //         .collection(
  //         FirebaseAuthentications.restaurantsCollection.trim())
  //         .doc(copyResId)
  //         .collection(
  //         FirebaseAuthentications.pendingOrdersCollection.trim())
  //         .doc(
  //         'order${DateTime.now().year + DateTime.now().month + DateTime.now().day + DateTime.now().hour + DateTime.now().minute}')
  //         .collection(FirebaseAuthentications.ordersCollection.trim())
  //         .doc('total price and location')
  //         .set({
  //       'latitude': latitude,
  //       'longitude': longitude,
  //       'Total Price': totalPrice,
  //       'location': locationId,
  //       'Order Date': DateTime.now()
  //     }),
  //     firestore
  //         .collection(
  //         FirebaseAuthentications.statisticsCollection.trim())
  //         .doc('Data')
  //         .update({
  //       'Total number of Pending Orders': FieldValue.increment(1),
  //       'revenue': FieldValue.increment(
  //           double.parse(totalPrice.toString().replaceAll(',', '')))
  //     })
  //   })
  //       .then((containsInfo) => {
  //     Fluttertoast.showToast(
  //         msg: "Congratulations, your order was taken successfully",
  //         toastLength: Toast.LENGTH_LONG,
  //         gravity: ToastGravity.CENTER,
  //         timeInSecForIosWeb: 3,
  //         backgroundColor: Colors.black,
  //         textColor: Colors.white,
  //         fontSize: 20.0),
  //     firestore
  //         .collection(
  //         FirebaseAuthentications.customersCollection.trim())
  //         .doc(auth.currentUser!.uid)
  //         .collection(FirebaseAuthentications.basketCollection.trim())
  //         .get()
  //         .then((value) => {
  //       for (DocumentSnapshot ds in value.docs)
  //         {ds.reference.delete()}
  //     })
  //   })
  //       .then((value) => {
  //     Navigator.push(
  //       context,
  //       MaterialPageRoute(
  //         fullscreenDialog: true,
  //         builder: (context) => FirstPage(),
  //       ),
  //     )
  //   })
  //       .then((value) async => {
  //     // get the seller restaurant name in order to include it in the email
  //
  //     sellerRestaurantName = await firestore
  //         .collection(FirebaseAuthentications.restaurantsCollection)
  //         .doc(restaurantId)
  //         .get(),
  //     restaurantName = await sellerRestaurantName['Restaurant Name'],
  //
  //     firestore
  //         .collection('Users')
  //         .doc(auth.currentUser!.uid)
  //         .get()
  //         .then((value) => {
  //       sendMessageClass.sendMessage(
  //           toEmail: auth.currentUser!.email.toString(),
  //           name: value['First Name'],
  //           email: 'hassimiouniane@gmail.com',
  //           subject: 'Thank you for your order',
  //           // complete this after you have handled the bug from the restaurant app.
  //           message: 'Order details: \n '
  //               'Seller: ${restaurantName} \n\n'
  //               'Welcome\nto\nMyWorld\nHello\nWorld\n')
  //     }),
  //   });
  // }
}

class sendMessageClass {
  static Future sendMessage(
      {required String bike1Email,
      required String bike2Email,
      required String bike3Email,
      required restaurantName}) async {
    const serviceId = 'service_lfmfzxu';
    const templateId = 'template_dnzp7ue';
    const userId = 'JMOlRuPWeYp-J1d1J';
    final url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');
    final response = await http.post(
      url,
      headers: {
        'origin': 'http://localhost',
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'service_id': serviceId,
        'template_id': templateId,
        'user_id': userId,
        'template_params': {
          'restaurant_name': restaurantName,
          'bike1': bike1Email,
          'bike2': bike2Email,
          'bike3': bike3Email,
        }
      }),
    );
    // print('it has been put in plasce');
    print(response.body);
  }
}

enum ascendingIngredientList {
  firstIngredient,
  secondIngredient,
  thirdIngredient,
  fourthIngredient,
  fifthIngredient,
}
