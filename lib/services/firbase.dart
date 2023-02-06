import 'dart:async';
import 'dart:convert';


import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:email_validator/email_validator.dart';
import 'package:geolocator/geolocator.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../From_Sulaiman/screens/home_screen.dart';
import '../From_Sulaiman/screens/login_screen.dart';
import '../From_Sulaiman/screens/step2.dart';
import '../Utils/sanckbar.dart';
import '../average_time_page.dart';
import '../averege_price_page.dart';
import 'package:http/http.dart' as http;

import '../generated/l10n.dart';

class FirebaseAuthentications {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  String restaurantsCollection = 'Restaurants';
  String menusCollection = 'Menus';
  String restaurantsDatabaseCollection = 'Restaurants Database';
  static String exceptionalRestaurantsCollection = 'Exceptional Restaurants';

  var pendingOrdersDatabaseCollection = 'Pending Orders';
  FirebaseMessaging messaging = FirebaseMessaging.instance;

//   deleteRestaurantFilesFromStorage(BuildContext context) async {
//
//
//     await EasyLoading.show(
//       indicator: const CircularProgressIndicator(),
//     );
//     try {
//       FirebaseAuth auth=FirebaseAuth.instance;
//       final storage = FirebaseStorage.instance;
//       // delete the folder the menus of the patricidal restaurants if exists.
//       var menuRef=await  storage.ref().child("menus");
//       final listResult = await menuRef.listAll();
//       for (var prefix in listResult.prefixes) {
//         if(prefix.name==auth.currentUser!.uid){
//           prefix.delete();
//         }
//
//       }
// // get the name of the profile image in here. then delete with the cover photo
//       var result= await firestore.collection('Restaurants').doc(auth.currentUser!.uid).get();
//       if(result.exists){
//         var  profileImage=   result['profile image url'];
//         var coverImage=result['cover image url'];
//         final profileRef = await storage.refFromURL(profileImage);
//         final coverRef=await storage.refFromURL(coverImage);
//         //checks if its a default photo before deleting.
//         if(profileRef.toString().split("/")[1] != "default_photos"){
//           profileRef.delete();
//         }
//         if(coverRef.toString().split("/")[1] != "default_photos"){
//           coverRef.delete();
//         }
//
//
//       }
//
//       var currentUser = FirebaseAuth.instance.currentUser;
//       if (currentUser != null) {
//         firestore
//             .collection('Restaurants')
//             .doc(auth.currentUser?.uid)
//             .delete();
//         firestore
//             .collection('All restaurant profile Pictures')
//             .doc(auth.currentUser?.uid)
//             .delete();
//         firestore
//             .collection(' MenuPhotos')
//             .doc(auth.currentUser?.uid)
//             .delete()
//             .then((value) =>
//         {logoutUser(context)})
//             .then((value) async => {
//            await    Future.delayed(Duration(
//                 seconds: 2,
//               )),
//           currentUser.delete(),
//           Fluttertoast.showToast(
//               msg: 'your account was deleted successfully',
//               gravity: ToastGravity.TOP),
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) => LoginScreen(),
//             ),
//           ),
//         });
//       } else {
//         Fluttertoast.showToast(
//             msg: 'Please Sign again to complete the action');
//       }
//     } on FirebaseException catch (e) {
//       Fluttertoast.showToast(msg: e.message.toString());
//       await EasyLoading.dismiss();
//     }
//     await EasyLoading.dismiss();
//
//
//   }
  Timer? _timer;
  void reloadUser(context) {

    _timer = Timer.periodic(Duration(seconds: 3), (timer) async {
      User? user = await FirebaseAuth.instance.currentUser;
      await user?.reload();
      print('cheking');
      if (user!.emailVerified) {
        print('the email verification has been verified');
        _timer?.cancel();
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomeScreen()));
      }
    });
  }

  deleteRestaurantFilesFromStorage(BuildContext context) async {
    await EasyLoading.show(
      indicator: const CircularProgressIndicator(),
    );
    try {
      FirebaseAuth auth = FirebaseAuth.instance;
      // final storage = FirebaseStorage.instance;
      // // delete the folder the menus of the particular restaurants if exists.
      // var menuRef = await storage.ref().child("menus");
      // final listResult = await menuRef.listAll();
      // for (var prefix in listResult.prefixes) {
      //   if (prefix.name == auth.currentUser!.uid) {
      //     prefix.delete();
      //   }
      // }
      // // get the name of the profile image in here. then delete with the cover photo
      // var result = await firestore.collection('Restaurants').doc(auth.currentUser!.uid).get();
      //  if (result.exists) {
      //   var profileImage = result['profile image url'];
      //   var coverImage = result['cover image url'];
      //   final profileRef = await storage.refFromURL(profileImage);
      //   final coverRef = await storage.refFromURL(coverImage);
      //   //checks if its a default photo before deleting.
      //   if (profileRef.toString().split("/")[1] != "default_photos") {
      //     profileRef.delete();
      //   }
      //   if (coverRef.toString().split("/")[1] != "default_photos") {
      //     coverRef.delete();
      //   }
      // }
      //
      // // Delete the data from the collections in Firestore
      // await firestore.collection('Restaurants').doc(auth.currentUser!.uid).delete();
      // await firestore.collection('All restaurant profile Pictures').doc(auth.currentUser!.uid).delete();
      // await firestore.collection(' MenuPhotos').doc(auth.currentUser!.uid).delete();
      //
      // // Delete the data from the Firebase Realtime Database
      // // var rootRef = _database.reference();
      // // await rootRef.child("users/${auth.currentUser?.uid}").remove();
      //
      // // Logout the user and delete the account

      await firestore.collection('Restaurants').doc(auth.currentUser!.uid).set({
        'isActive': false,
      }, SetOptions(merge: true));
      await logoutUser(context);

      await Fluttertoast.showToast(
          msg: 'your account was deleted successfully',
          gravity: ToastGravity.TOP);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => LoginScreen(),
        ),
      );
    } on FirebaseException catch (e) {
      Fluttertoast.showToast(msg: e.message.toString());
      await EasyLoading.dismiss();
    }
    await EasyLoading.dismiss();
  }

  saveUserKeyToSharedPrefrence() async {
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

  addRestaurantLocationToFirebase(String latitude, String longitude) {
    FirebaseFirestore.instance
        .collection('Restaurants')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .set({
      'latitude': latitude,
      'longitude': longitude,
    }, SetOptions(merge: true));
  }

  Future<bool> SignUpUser(
      {required BuildContext context,
      required String email,
      required String password,
      required String userName,
      required String fullAddress,
      required String phoneNumber,
      required String community,
      restaurantFoundationDate = null,
      Position? position,
      required averageTime,
      required averagePrice,
      RoundedLoadingButtonController? controller}) async {
    try {
      // var platform;
      var token;
      token = await messaging.getToken();
      // if (Platform.isIOS) {
      //   platform = 'Ios Token';
      // } else {
      //   platform = 'android token';
      // }
      // String? currentUser;
      var newUser = await auth.createUserWithEmailAndPassword(
          email: email, password: password);

      // currentUser = auth.currentUser?.uid;

      User? user = newUser.user;
      user?.updateDisplayName(userName);
      user?.updatePhotoURL('');

      firestore
          .collection(restaurantsCollection.trim())
          .doc(auth.currentUser?.uid)
          .set({
            'average time': averageTime,
            'average price': averagePrice,
            'restaurant foundation date': restaurantFoundationDate,
            'isActive': true,
            'Email': email,
            'latitude': position!.latitude.toString(),
            'longitude': position.longitude.toString(),
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
                auth.currentUser!.sendEmailVerification()
                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //         builder: (context) => const AveragePricePage()))
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
                    'https://firebasestorage.googleapis.com/v0/b/yemeksepeti-f4347.appspot.com/o/default_photos%2FdefaultRestaurantProfilePicture.PNG?alt=media&token=f113400b-3366-4a04-9d77-7729ac1de287'),
              })
          .then((value) => {
                defaultRestaurantCoverFunction(
                    'https://firebasestorage.googleapis.com/v0/b/yemeksepeti-f4347.appspot.com/o/default_photos%2FdefaultRestaurantCoverPicture.JPG?alt=media&token=b38605dc-dae4-445d-8b82-b52919b850dc'),
              })
          .then((value) => {
                firestore.collection('Statistics').doc('Data').set({
                  'Total restaurants': FieldValue.increment(1),
                }, SetOptions(merge: true)),
                saveUserKeyToSharedPrefrence(),
              })
          .then(
            (value) => {},
          );
      return true;
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
      return false;
    }
  }

  // signInUser(String email, String password, BuildContext context,
  //     [RoundedLoadingButtonController? controller]) async {
  //   try {
  //     if (EmailValidator.validate(email)) {
  //       print(EmailValidator.validate(email));
  //       try {
  //         UserCredential result = await auth.signInWithEmailAndPassword(
  //             email: email, password: password);
  //         print('the result is a success');
  //         if (result.user != null) {
  //           bool exist;
  //
  //           firestore
  //               .collection(restaurantsCollection.trim())
  //               .doc(auth.currentUser!.uid)
  //               .get()
  //               .then((value) async => {
  //                     value.exists ? exist = true : exist = false,
  //                     if (exist)
  //                       {
  //               print('hashim was just here'),
  //                         controller!.reset(),
  //                         //check if user has been verified
  //                         if(auth.currentUser!.emailVerified){
  //   print('the email has been verified'),
  //
  //
  //   FirebaseAuth.instance
  //       .authStateChanges()
  //       .listen((User? user) async {
  // if(user!=null && user.emailVerified){
  //
  //   print('the user is from the restaurant app');
  //   controller.success();
  //   await Future.delayed(Duration(seconds: 1));
  //   Navigator.push(
  //       context,
  //       MaterialPageRoute(
  //           builder: (context) => const HomeScreen()));
  //                               }
  //   })
  //                         }
  //                         else{
  //                         auth.currentUser!.sendEmailVerification(),
  //                         print('the email verification has been sent')
  //                         }
  //
  //                       }
  //                     else
  //                       {
  //                         auth.signOut(),
  //
  //                         print('the user is not a restaurant')}
  //                   });
  //         }
  //       } on FirebaseAuthException catch (e) {
  //         openSnackBar(context, e.message, Colors.red);
  //         controller?.reset();
  //       }
  //     } else {
  //       var displayNme = auth.currentUser?.displayName;
  //       if (displayNme == email) {
  //         bool exist;
  //         auth
  //             .signInWithEmailAndPassword(
  //                 email: auth.currentUser!.email.toString(), password: password)
  //             .then((value) => {
  //                   firestore
  //                       .collection(restaurantsDatabaseCollection.trim())
  //                       .doc(auth.currentUser!.uid)
  //                       .get()
  //                       .then((value) => {
  //                             value.exists ? exist = true : exist = false,
  //                             if (exist)
  //                               {
  //                                 EasyLoading.dismiss(),
  //                                 print('the user is from the restaurant app'),
  //                                 // Navigator.push(
  //                                 //     context,
  //                                 //     MaterialPageRoute(
  //                                 //         builder: (context) => FirstPage())),
  //                               }
  //                             else
  //                               {
  //                                 auth.signOut(),
  //                                 print('the user is not a restaurant'),
  //                                 EasyLoading.dismiss(),
  //                               }
  //                           })
  //                 });
  //       }
  //     }
  //   } on FirebaseAuthException catch (e) {
  //     controller?.error();
  //     Fluttertoast.showToast(
  //         msg: e.message.toString(),
  //         toastLength: Toast.LENGTH_LONG,
  //         gravity: ToastGravity.CENTER,
  //         timeInSecForIosWeb: 1,
  //         backgroundColor: Colors.red,
  //         textColor: Colors.white,
  //         fontSize: 20.0);
  //   }
  //   // controller?.reset();
  // }
  Future<bool> checkIfRestaurantIsActive() async {
    var result = await firestore
        .collection('Restaurants')
        .doc(auth.currentUser!.uid)
        .get();

    if (result['isActive']) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> signInUser(String email, String password, BuildContext context,
      [RoundedLoadingButtonController? controller]) async {
    try {
      bool _isVisible = false;
      TextEditingController newEmailController = new TextEditingController();

      if (EmailValidator.validate(email)) {
        UserCredential result = await auth.signInWithEmailAndPassword(
            email: email, password: password);
        if (result.user != null) {
          bool isRestaurant = await checkIfUserIsRestaurant();
          if (isRestaurant) {
            if (await checkIfRestaurantIsActive()) {
              if (auth.currentUser!.emailVerified) {
                controller?.success();
                await Future.delayed(const Duration(seconds: 1));
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (_) => HomeScreen()));
              } else {
                print('the email is not verified');
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => Step2(email: email,fromSignInPage: true,)));
                //     print(auth.currentUser!.email);
            //     showDialog(
            //       barrierDismissible: true,
            //       context: context,
            //       builder: (BuildContext context) {
            //         return StatefulBuilder(builder: (context, setState) {
            //           // TextEditingController newEmailController=TextEditingController();
            //
            //           return AlertDialog(
            //
            //             shape: RoundedRectangleBorder(
            //                 borderRadius: BorderRadius.circular(10)),
            //             // shape: ,
            //             title: Text("Email Verification"),
            //             content: Column(
            //               mainAxisSize: MainAxisSize.min,
            //               children: [
            //                 Text(
            //                   S.of(context).emailNotVerifiedWarningString,
            //                   style: TextStyle(
            //                     color: Colors.grey.shade500,
            //                   ),
            //                 ),
            //                 SizedBox(
            //                   height: 10,
            //                 ),
            //                 Visibility(
            //                     visible: _isVisible,
            //                     child: SizedBox(
            //                       height: 90,
            //                       child: Column(
            //                         mainAxisSize: MainAxisSize.min,
            //                         crossAxisAlignment: CrossAxisAlignment.end,
            //                         children: [
            //                           Expanded(
            //                             child: TextField(
            //                               controller: newEmailController,
            //                               decoration: InputDecoration(
            //                                   labelText: 'Enter email',
            //                                   border: OutlineInputBorder(
            //                                       borderRadius:
            //                                           BorderRadius.circular(
            //                                               5))),
            //                             ),
            //                           ),
            //                           TextButton(
            //                             onPressed: () async {
            //                               bool isEmailValid =
            //                                   EmailValidator.validate(
            //                                       newEmailController.text
            //                                           .trim());
            //
            //                               if (isEmailValid) {
            //                                 try {
            //                                   await auth.currentUser!.updateEmail(newEmailController.text.trim());
            //                                   await auth.currentUser!.sendEmailVerification();
            //                                   await FirebaseFirestore.instance.collection('Restaurants').doc(auth.currentUser?.uid).set({
            //                                     'Email':newEmailController.text
            //                                   },SetOptions(merge: true));
            //                                   SharedPreferences prefrence= await SharedPreferences.getInstance();
            //                                   prefrence.setString('email', newEmailController.text);
            //
            //                                   Fluttertoast.showToast(msg: 'Please check your email to verify');
            //                                   reloadUser(context);
            //                                   // logoutUser(context);
            //                                   // Navigator.pop(context);
            //
            //                                 } on FirebaseAuthException catch (e) {
            //                                   if (e.code == 'email-already-in-use') {
            //                                     Fluttertoast.showToast(textColor: Colors.white,
            //                                         gravity: ToastGravity.SNACKBAR,
            //                                         backgroundColor: Colors.deepOrangeAccent,
            //                                         msg: 'The email is already in use by another account');
            //                                   } else {
            //                                     Fluttertoast.showToast(textColor: Colors.white,
            //                                         gravity: ToastGravity.SNACKBAR,
            //                                         backgroundColor: Colors.deepOrangeAccent,
            //                                         msg: e.code.toString());
            //                                   }
            //                                 }
            //
            //
            //
            //
            //
            //
            //
            //
            //
            //                                 // print('im here in the valdate');
            //                                 // try {
            //                                 //
            //                                 //   auth.currentUser!.updateEmail(
            //                                 //         newEmailController.text
            //                                 //             .trim()).then((value) => {
            //                                 //
            //                                 //   }).catchError((e){
            //                                 //     print(e.toString());
            //                                 //   });
            //                                 //
            //                                 //
            //                                 //
            //                                 //   auth.currentUser!
            //                                 //       .sendEmailVerification()
            //                                 //       .then((value) => {
            //                                 //             Fluttertoast.showToast(
            //                                 //                     msg:
            //                                 //                         'Please check your email to verify')
            //                                 //                 .then((value) => {
            //                                 //                       Navigator.pop(
            //                                 //                           context),
            //                                 //                     }),
            //                                 //             logoutUser(context)
            //                                 //           });
            //                                 //
            //                                 //   // reloadUser(context),
            //                                 // } on FirebaseException catch (e) {
            //                                 //   Fluttertoast.showToast(
            //                                 //       textColor: Colors.white,
            //                                 //       gravity:
            //                                 //           ToastGravity.SNACKBAR,
            //                                 //       backgroundColor:
            //                                 //           Colors.deepOrangeAccent,
            //                                 //       msg: e.code.toString());
            //                                 // }
            //                               } else {
            //                                 Fluttertoast.showToast(
            //                                     textColor: Colors.white,
            //                                     gravity: ToastGravity.SNACKBAR,
            //                                     backgroundColor:
            //                                         Colors.deepOrangeAccent,
            //                                     msg:
            //                                         'email is badly formatted');
            //                               }
            //                             },
            //                             child: Text('confirm'),
            //                           )
            //                         ],
            //                       ),
            //                     ))
            //               ],
            //             ),
            //             actions: <Widget>[
            //               Visibility(
            //                 visible: !_isVisible,
            //                 child: TextButton(
            //                   child: Text(S.of(context).changeEmailString),
            //                   onPressed: () {
            //                     setState(() {
            //                       _isVisible = true;
            //                       print(_isVisible);
            //                     });
            //                   },
            //                 ),
            //               ),
            //               Visibility(
            //                 visible:true,
            //                 child: TextButton(
            //                   child: Text(S.of(context).resendString),
            //                   onPressed: () {
            //                     auth.currentUser
            //                         ?.sendEmailVerification()
            //                         .then((value) {
            //                           reloadUser(context);
            //                       Fluttertoast.showToast(
            //                               msg:
            //                                   'Please check your email to verify')
            //                           .then((value) => {
            //                             logoutUser(context),
            //                                 Navigator.pop(context),
            //                               });
            //                     });
            //                   },
            //                 ),
            //               ),
            //             ],
            //           );
            //         });
            //       },
            //     ).then((value) => {
            //     if (value==null) {
            //        _timer?.cancel(),
            //       logoutUser(context),
            //
            //
            //     print('the user has been logged out')
            //   } else {
            //   print("Dialog dismissed with result: $result"),
            // }
            //     });
            //     // showDialog(
            //     //   context: context,
            //     //   builder: (BuildContext context) {
            //     //     return AlertDialog(
            //     //       shape: RoundedRectangleBorder(
            //     //         borderRadius: BorderRadius.circular(10)
            //     //       ),
            //     //       // shape: ,
            //     //       title: Text("Email Verification"),
            //     //       content: Text("Your email has not been verified yet."),
            //     //       actions: <Widget>[
            //     //         TextButton(
            //     //           child: Text("resend email"),
            //     //           onPressed: () {
            //     //             auth.currentUser?.sendEmailVerification().then((value) {
            //     //               Fluttertoast.showToast(msg: 'Please check your email to verify').then((value) => {
            //     //                 Navigator.pop(context),
            //     //               });
            //     //             });
            //     //           },
            //     //         ),
            //     //       ],
            //     //     );
            //     //   },
            //     // );
            //     // logoutUser(context);
            //     // auth.currentUser!.sendEmailVerification();
            //     // openSnackBar(context, 'An email verification has been sent', Colors.blue);
            //     controller?.reset();
              }
            } else {
              openSnackBar(
                  context, 'sorry Your account was deleted! ', Colors.red);
              auth.signOut();
            }
          } else {
            auth.signOut();
            openSnackBar(context, 'You are not a restaurant', Colors.red);
            controller?.reset();
          }
        }
      } else {
        var displayName = auth.currentUser?.displayName;
        if (displayName == email) {
          bool isRestaurant = await checkIfUserIsRestaurant();
          if (isRestaurant) {
            // Navigator.push(context, MaterialPageRoute(builder: (_) => FirstPage()));
          } else {
            auth.signOut();
            openSnackBar(context, 'You are not a restaurant', Colors.red);
          }
        }
      }
    } on FirebaseAuthException catch (e) {
      controller?.error();
      openSnackBar(context, e.message, Colors.red);
    }
    controller?.reset();
  }

  Future<bool> checkIfUserIsRestaurant() async {
    final DocumentSnapshot documentSnapshot = await firestore
        .collection(restaurantsCollection.trim())
        .doc(auth.currentUser!.uid)
        .get();
    return documentSnapshot.exists;
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

    // var lastMenu;
    try {
      var getDoc = await firestore
          .collection(restaurantsCollection.trim())
          .doc(auth.currentUser!.uid)
          .collection(menusCollection.trim())
          .get();

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
        }).then((value) => {
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
                      }),
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
                    }
                });
        return true;
      }
    } on FirebaseException catch (e) {
      print(e);
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
    // DocumentReference copyFrom;
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
//     and then it will take the document id  at the kith place and save it to copyFrom variable.
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
