//                   onPressed: () async {
//                     CallBike callBike = CallBike();
//                     var numberOfEmptyControllers = 0;
//                     if (firstController.text.isNotEmpty) {
//                       String? restaurantName;
//                       bool canRequestANewBikee;
//                       String lastOrderNumber;
//                       int newOrderNumber;
//                       int lastNumber = 0;
//                       int currentIndexInInt;
//                       FirebaseFirestore.instance
//                           .collection('Restaurants')
//                           .doc(FirebaseAuth.instance.currentUser!.uid)
//                           .collection('Pending Orders')
//                           .get()
//                           .then((theRestaurant) async => {
//                                 if (theRestaurant.docs.isEmpty)
//                                   {
//                                     // callBike.setADocument(
//                                     //     pendingOrderDocument: '1',
//                                     //     controller: firstController,
//                                     //     numberOfDestination: 1,
//                                     //     doesItStartWithADigit: true,
//                                     //     rejectByTheRestaurant: false,
//                                     //     isDelivered: false,
//                                     //     canTheRestaurantRequestNewBike: false,
//                                     //     bikeIsCalled: '1',
//                                     //     hasBikeCome: false,
//                                     //     isBikeAssigned: false),
//                                     FirebaseFirestore.instance
//                                         .collection('Restaurants')
//                                         .doc(FirebaseAuth
//                                             .instance.currentUser!.uid)
//                                         .collection('Pending Orders')
//                                         .doc('1')
//                                         .set({
//                                       'number of destinations': 1,
//                                       'destination': firstController.text,
//                                       'digit': true,
//                                       'rejected by restaurant': false,
//                                       'delivered': false,
//                                       'bike assigned': false,
//                                       'bike called': '1',
//                                       'bike came': false,
//                                       'can request a new bike': false,
//                                     }, SetOptions(merge: true)).then(
//                                             (value) => {
//                                                   FirebaseFirestore.instance
//                                                       .collection('Restaurants')
//                                                       .doc(FirebaseAuth.instance
//                                                           .currentUser!.uid)
//                                                       .get()
//                                                       .then((value) => {
//                                                             restaurantName = value[
//                                                                 'Restaurant Name'],
//                                                           }),
//                                                   print(restaurantName),
//                                                   sendMessageClass
//                                                       .sendMessage(
// // complete this after you have handled the bug from the restaurant app.
//
//                                                         restaurantName:
//                                                             restaurantName,
//                                                         bike1Email:
//                                                             'motard1bonappgn@gmail.com',
//                                                         bike2Email:
//                                                             'motard2bonappgn@gmail.com',
//                                                         bike3Email:
//                                                             'motard3bonappgn@gmail.com',
//                                                       )
//                                                       .then((value) => {
//                                                             Fluttertoast.showToast(
//                                                                 backgroundColor:
//                                                                     Colors.blue,
//                                                                 gravity:
//                                                                     ToastGravity
//                                                                         .TOP_RIGHT,
//                                                                 toastLength: Toast
//                                                                     .LENGTH_LONG,
//                                                                 msg: S
//                                                                     .of(context)
//                                                                     .aBikeIsOnTheWayString),
//                                                             call_bike_button_controller
//                                                                 .reset()
//                                                           })
//                                                 })
//                                   }
//                                 else
//                                   {
//                                     for (int i = 0;
//                                         i < theRestaurant.docs.length;
//                                         i++)
//                                       {
//                                         if (theRestaurant.docs[i].id
//                                             .startsWith('o'))
//                                           {
// // print(
// //     'the order at place ${(i + 1)} starts with O ======>${value.docs[i].id}'),
//                                           }
//                                         else
//                                           {
//                                             lastNumber = int.parse(
//                                                 theRestaurant.docs[i].id),
//                                             currentIndexInInt = int.parse(
//                                                 theRestaurant.docs[i].id),
//                                             if (lastNumber < currentIndexInInt)
//                                               {
//                                                 lastNumber = currentIndexInInt,
//                                               }
//                                           },
//                                       },
//                                     print(
//                                         'the last number digit is $lastNumber'),
//                                     // this below line checks if there is no document inside of the collection that starts with a number instead of a letter;
//                                     if (lastNumber == 0)
//                                       {
//                                         // meaning the is not document that starts with a number;
//                                         FirebaseFirestore.instance
//                                             .collection('Restaurants')
//                                             .doc(FirebaseAuth
//                                                 .instance.currentUser!.uid)
//                                             .collection('Pending Orders')
//                                             .doc('1')
//                                             .set({
//                                           'number of destinations': 1,
//                                           'destination': firstController.text,
//                                           'digit': true,
//                                           'rejected by restaurant': false,
//                                           'delivered': false,
//                                           'bike assigned': false,
//                                           'bike called': '1',
//                                           'bike came': false,
//                                           'can request a new bike': false,
//                                         }, SetOptions(merge: true)).then(
//                                                 (value) => {
//                                                       FirebaseFirestore.instance
//                                                           .collection(
//                                                               'Restaurants')
//                                                           .doc(FirebaseAuth
//                                                               .instance
//                                                               .currentUser!
//                                                               .uid)
//                                                           .get()
//                                                           .then((value) => {
//                                                                 restaurantName =
//                                                                     value[
//                                                                         'Restaurant Name'],
//                                                               }),
//                                                       print(restaurantName),
//                                                       sendMessageClass
//                                                           .sendMessage(
// // complete this after you have handled the bug from the restaurant app.
//
//                                                             restaurantName:
//                                                                 restaurantName,
//                                                             bike1Email:
//                                                                 'motard1bonappgn@gmail.com',
//                                                             bike2Email:
//                                                                 'motard2bonappgn@gmail.com',
//                                                             bike3Email:
//                                                                 'motard3bonappgn@gmail.com',
//                                                           )
//                                                           .then((value) => {
//                                                                 call_bike_button_controller
//                                                                     .reset(),
//                                                                 Fluttertoast.showToast(
//                                                                     backgroundColor:
//                                                                         Colors
//                                                                             .blue,
//                                                                     gravity:
//                                                                         ToastGravity
//                                                                             .TOP_RIGHT,
//                                                                     toastLength:
//                                                                         Toast
//                                                                             .LENGTH_LONG,
//                                                                     msg: S
//                                                                         .of(context)
//                                                                         .aBikeIsOnTheWayString),
//                                                               })
//                                                     })
//                                       }
//                                     else
//                                       {
//                                         // this one here it is that there is a document with a number. the last document of the collection that is a number is saved inside the value called lastNumber;
//                                         FirebaseFirestore.instance
//                                             .collection('Restaurants')
//                                             .doc(FirebaseAuth
//                                                 .instance.currentUser!.uid)
//                                             .collection('Pending Orders')
//                                             .doc(lastNumber.toString())
//                                             .get()
//                                             .then((value) async => {
//                                                   canRequestANewBikee = value[
//                                                       'can request a new bike'],
//                                                   // here checking if this order has been delivered
//                                                   if (canRequestANewBikee)
//                                                     {
//                                                       FirebaseFirestore.instance
//                                                           .collection(
//                                                               'Restaurants')
//                                                           .doc(FirebaseAuth
//                                                               .instance
//                                                               .currentUser!
//                                                               .uid)
//                                                           .collection(
//                                                               'Pending Orders')
//                                                           .doc((lastNumber + 1)
//                                                               .toString())
//                                                           .set(
//                                                               {
//                                                                 'number of destinations':
//                                                                     1,
//                                                                 'destination':
//                                                                     firstController
//                                                                         .text,
//                                                                 'digit': true,
//                                                                 'rejected by restaurant':
//                                                                     false,
//                                                                 'delivered':
//                                                                     false,
//                                                                 'bike assigned':
//                                                                     false,
//                                                                 'bike called':
//                                                                     '1',
//                                                                 'bike came':
//                                                                     false,
//                                                                 'can request a new bike':
//                                                                     false,
//                                                               },
//                                                               SetOptions(
//                                                                   merge: true))
//                                                           .then(
//                                                               (value) async => {
//                                                                     await FirebaseFirestore
//                                                                         .instance
//                                                                         .collection(
//                                                                             'Restaurants')
//                                                                         .doc(FirebaseAuth
//                                                                             .instance
//                                                                             .currentUser!
//                                                                             .uid)
//                                                                         .get()
//                                                                         .then((value) =>
//                                                                             {
//                                                                               restaurantName = value['Restaurant Name'],
//                                                                             })
//                                                                         .then((value) =>
//                                                                             {
//                                                                               print('the restaurant name is ' + restaurantName!),
//                                                                               sendMessageClass.sendMessage(restaurantName: restaurantName, bike1Email: 'motard1bonappgn@gmail.com', bike2Email: 'motard2bonappgn@gmail.com', bike3Email: 'motard3bonappgn@gmail.com'
// // 'motard3bonappgn@gmail.com',
//                                                                                   )
//                                                                             }),
//                                                                   })
//                                                           .then((value) => {
//                                                                 Fluttertoast.showToast(
//                                                                     backgroundColor:
//                                                                         Colors
//                                                                             .blue,
//                                                                     gravity:
//                                                                         ToastGravity
//                                                                             .TOP_RIGHT,
//                                                                     toastLength:
//                                                                         Toast
//                                                                             .LENGTH_LONG,
//                                                                     msg: S
//                                                                         .of(context)
//                                                                         .aBikeIsOnTheWayString),
//                                                                 call_bike_button_controller
//                                                                     .reset(),
//                                                               })
//                                                     }
//                                                   // this one means the last made order hasn't been delivered. as such the bike is not going to be called;
//                                                   else
//                                                     {
//                                                       call_bike_button_controller
//                                                           .reset(),
//                                                       await Fluttertoast.showToast(
//                                                               gravity:
//                                                                   ToastGravity
//                                                                       .CENTER,
//                                                               backgroundColor:
//                                                                   Colors.red,
//                                                               msg: S
//                                                                   .of(context)
//                                                                   .aBikeIsOnTheWayString)
//                                                           .then((value) => {})
//                                                     }
//                                                 }),
//                                       },
//                                   }
//                               });
//                     }
//
//                     // this else statement is if the firstController is empty. meaning it involves many destinations.
//                     else {
//                       //checks if the controllers list is not empty first
//                       if (_controllers.isNotEmpty) {
//                         for (var controller in _controllers) {
//                           if (controller.text.isEmpty) {
//                             numberOfEmptyControllers++;
//                           }
//                         }
// // checks if
//                         if (numberOfEmptyControllers > 0) {
//                           // if there is one or more controllers spaces that is empty;
//                           Fluttertoast.showToast(
//                               backgroundColor: Colors.red,
//                               msg: S
//                                   .of(context)
//                                   .pleaseFillIntheDestinationString);
//                           call_bike_button_controller.error();
//                           // call_bike_button_controller.reset();
//                           await Future.delayed(
//                             const Duration(seconds: 1),
//                           );
//                           call_bike_button_controller.reset();
//                         }
//                         // if there is no empty controllers meaning things are fine!!!!
//                         else {
//                           String? restaurantName;
//                           bool canRequestANewBikee;
//                           String lastOrderNumber;
//                           int newOrderNumber;
//                           int lastNumber = 0;
//                           int currentIndexInInt;
//                           FirebaseFirestore.instance
//                               .collection('Restaurants')
//                               .doc(FirebaseAuth.instance.currentUser!.uid)
//                               .collection('Pending Orders')
//                               .get()
//                               .then(
//                                 (theRestaurant) async => {
//                                   if (theRestaurant.docs.isEmpty)
//                                     {
//                                       for (int i = 0;
//                                           i < _controllers.length;
//                                           ++i)
//                                         {
//                                           FirebaseFirestore.instance
//                                               .collection('Restaurants')
//                                               .doc(FirebaseAuth
//                                                   .instance.currentUser!.uid)
//                                               .collection('Pending Orders')
//                                               .doc('1')
//                                               .set({
//                                             'destination ${(i + 1)}':
//                                                 _controllers[i].text,
//                                           }, SetOptions(merge: true)),
//                                         },
//                                       FirebaseFirestore.instance
//                                           .collection('Restaurants')
//                                           .doc(FirebaseAuth
//                                               .instance.currentUser!.uid)
//                                           .collection('Pending Orders')
//                                           .doc('1')
//                                           .set({
//                                         'number of destinations':
//                                             _controllers.length,
//                                         'digit': true,
//                                         'rejected by restaurant': false,
//                                         'delivered': false,
//                                         'bike assigned': false,
//                                         'bike called': '1',
//                                         'bike came': false,
//                                         'can request a new bike': false,
//                                       }, SetOptions(merge: true)).then(
//                                               (value) => {
//                                                     FirebaseFirestore.instance
//                                                         .collection(
//                                                             'Restaurants')
//                                                         .doc(FirebaseAuth
//                                                             .instance
//                                                             .currentUser!
//                                                             .uid)
//                                                         .get()
//                                                         .then((value) => {
//                                                               restaurantName =
//                                                                   value[
//                                                                       'Restaurant Name'],
//                                                             }),
//                                                     print(restaurantName),
//                                                     sendMessageClass
//                                                         .sendMessage(
// // complete this after you have handled the bug from the restaurant app.
//
//                                                           restaurantName:
//                                                               restaurantName,
//                                                           bike1Email:
//                                                               'motard1bonappgn@gmail.com',
//                                                           bike2Email:
//                                                               'motard2bonappgn@gmail.com',
//                                                           bike3Email:
//                                                               'motard3bonappgn@gmail.com',
//                                                         )
//                                                         .then((value) => {
//                                                               Fluttertoast.showToast(
//                                                                   backgroundColor:
//                                                                       Colors
//                                                                           .blue,
//                                                                   gravity:
//                                                                       ToastGravity
//                                                                           .TOP_RIGHT,
//                                                                   toastLength: Toast
//                                                                       .LENGTH_LONG,
//                                                                   msg: S
//                                                                       .of(context)
//                                                                       .aBikeIsOnTheWayString),
//                                                             })
//                                                   })
//                                     }
//                                   else
//                                     {
//                                       for (int i = 0;
//                                           i < theRestaurant.docs.length;
//                                           i++)
//                                         {
//                                           if (theRestaurant.docs[i].id
//                                               .startsWith('o'))
//                                             {
// // print(
// //     'the order at place ${(i + 1)} starts with O ======>${value.docs[i].id}'),
//                                             }
//                                           else
//                                             {
//                                               lastNumber = int.parse(
//                                                   theRestaurant.docs[i].id),
//                                               currentIndexInInt = int.parse(
//                                                   theRestaurant.docs[i].id),
//                                               if (lastNumber <
//                                                   currentIndexInInt)
//                                                 {
//                                                   lastNumber =
//                                                       currentIndexInInt,
//                                                 }
//                                             },
//                                         },
//                                       print(
//                                           'the last number digit is $lastNumber'),
//                                       if (lastNumber == 0)
//                                         {
//                                           for (int i = 0;
//                                               i < _controllers.length;
//                                               ++i)
//                                             {
//                                               FirebaseFirestore.instance
//                                                   .collection('Restaurants')
//                                                   .doc(FirebaseAuth.instance
//                                                       .currentUser!.uid)
//                                                   .collection('Pending Orders')
//                                                   .doc('1')
//                                                   .set({
//                                                 'destination ${i + 1}':
//                                                     _controllers[i].text,
//                                               }, SetOptions(merge: true)),
//                                             },
//                                           FirebaseFirestore.instance
//                                               .collection('Restaurants')
//                                               .doc(FirebaseAuth
//                                                   .instance.currentUser!.uid)
//                                               .collection('Pending Orders')
//                                               .doc('1')
//                                               .set({
//                                             'number of destinations':
//                                                 _controllers.length,
//                                             'digit': true,
//                                             'rejected by restaurant': false,
//                                             'delivered': false,
//                                             'bike assigned': false,
//                                             'bike called': '1',
//                                             'bike came': false,
//                                             'can request a new bike': false,
//                                           }, SetOptions(merge: true)).then(
//                                                   (value) => {
//                                                         FirebaseFirestore
//                                                             .instance
//                                                             .collection(
//                                                                 'Restaurants')
//                                                             .doc(FirebaseAuth
//                                                                 .instance
//                                                                 .currentUser!
//                                                                 .uid)
//                                                             .get()
//                                                             .then((value) => {
//                                                                   restaurantName =
//                                                                       value[
//                                                                           'Restaurant Name'],
//                                                                 }),
//                                                         print(restaurantName),
//                                                         sendMessageClass
//                                                             .sendMessage(
// // complete this after you have handled the bug from the restaurant app.
//
//                                                               restaurantName:
//                                                                   restaurantName,
//                                                               bike1Email:
//                                                                   'motard1bonappgn@gmail.com',
//                                                               bike2Email:
//                                                                   'motard2bonappgn@gmail.com',
//                                                               bike3Email:
//                                                                   'motard3bonappgn@gmail.com',
//                                                             )
//                                                             .then((value) => {
//                                                                   Fluttertoast.showToast(
//                                                                       backgroundColor:
//                                                                           Colors
//                                                                               .blue,
//                                                                       gravity:
//                                                                           ToastGravity
//                                                                               .TOP_RIGHT,
//                                                                       toastLength:
//                                                                           Toast
//                                                                               .LENGTH_LONG,
//                                                                       msg: S
//                                                                           .of(context)
//                                                                           .aBikeIsOnTheWayString),
//                                                                 })
//                                                       })
//                                         }
//                                       else
//                                         {
// // print('the bike came'),
//                                           FirebaseFirestore.instance
//                                               .collection('Restaurants')
//                                               .doc(FirebaseAuth
//                                                   .instance.currentUser!.uid)
//                                               .collection('Pending Orders')
//                                               .doc(lastNumber.toString())
//                                               .get()
//                                               .then((value) async => {
// // print(
// //     'if the bike has been called  ${value['bike called']}'),
//                                                     canRequestANewBikee = value[
//                                                         'can request a new bike'],
//
//                                                     if (canRequestANewBikee)
//                                                       {
//                                                         for (int i = 0;
//                                                             i <
//                                                                 _controllers
//                                                                     .length;
//                                                             ++i)
//                                                           {
//                                                             FirebaseFirestore
//                                                                 .instance
//                                                                 .collection(
//                                                                     'Restaurants')
//                                                                 .doc(FirebaseAuth
//                                                                     .instance
//                                                                     .currentUser!
//                                                                     .uid)
//                                                                 .collection(
//                                                                     'Pending Orders')
//                                                                 .doc('1')
//                                                                 .set(
//                                                                     {
//                                                                   'destination ${i + 1}':
//                                                                       _controllers[
//                                                                               i]
//                                                                           .text,
//                                                                 },
//                                                                     SetOptions(
//                                                                         merge:
//                                                                             true)),
//                                                           },
//                                                         FirebaseFirestore
//                                                             .instance
//                                                             .collection(
//                                                                 'Restaurants')
//                                                             .doc(FirebaseAuth
//                                                                 .instance
//                                                                 .currentUser!
//                                                                 .uid)
//                                                             .collection(
//                                                                 'Pending Orders')
//                                                             .doc(
//                                                                 (lastNumber + 1)
//                                                                     .toString())
//                                                             .set(
//                                                                 {
//                                                                   'number of destinations':
//                                                                       _controllers
//                                                                           .length,
//                                                                   'digit': true,
//                                                                   'rejected by restaurant':
//                                                                       false,
//                                                                   'delivered':
//                                                                       false,
//                                                                   'bike assigned':
//                                                                       false,
//                                                                   'bike called':
//                                                                       '1',
//                                                                   'bike came':
//                                                                       false,
//                                                                   'can request a new bike':
//                                                                       false,
//                                                                 },
//                                                                 SetOptions(
//                                                                     merge:
//                                                                         true))
//                                                             .then(
//                                                                 (value) async =>
//                                                                     {
//                                                                       print(
//                                                                           'before the call bike reset'),
//                                                                       call_bike_button_controller
//                                                                           .reset(),
// //copy from the below code
//                                                                       await FirebaseFirestore
//                                                                           .instance
//                                                                           .collection(
//                                                                               'Restaurants')
//                                                                           .doc(FirebaseAuth
//                                                                               .instance
//                                                                               .currentUser!
//                                                                               .uid)
//                                                                           .get()
//                                                                           .then((value) =>
//                                                                               {
//                                                                                 restaurantName = value['Restaurant Name'],
//                                                                               })
//                                                                           .then((value) =>
//                                                                               {
//                                                                                 print('the restaurant name is ' + restaurantName!),
//                                                                                 sendMessageClass.sendMessage(
// // complete this after you have handled the bug from the restaurant app.
//
//                                                                                     restaurantName: restaurantName,
//                                                                                     bike1Email: 'motard1bonappgn@gmail.com',
//                                                                                     bike2Email: 'motard2bonappgn@gmail.com',
//                                                                                     bike3Email: 'motard3bonappgn@gmail.com'
// // 'motard3bonappgn@gmail.com',
//                                                                                     )
//                                                                               }),
//                                                                     })
//                                                             .then((value) => {
//                                                                   Fluttertoast.showToast(
//                                                                       backgroundColor:
//                                                                           Colors
//                                                                               .blue,
//                                                                       gravity:
//                                                                           ToastGravity
//                                                                               .TOP_RIGHT,
//                                                                       toastLength:
//                                                                           Toast
//                                                                               .LENGTH_LONG,
//                                                                       msg: S
//                                                                           .of(context)
//                                                                           .aBikeIsOnTheWayString),
//                                                                   call_bike_button_controller
//                                                                       .success(),
//                                                                   call_bike_button_controller
//                                                                       .reset()
//                                                                 })
//                                                       }
//                                                     else
//                                                       {
//                                                         await Fluttertoast.showToast(
//                                                                 gravity:
//                                                                     ToastGravity
//                                                                         .CENTER,
//                                                                 backgroundColor:
//                                                                     Colors.red,
//                                                                 msg: S
//                                                                     .of(context)
//                                                                     .aBikeIsOnTheWayString)
//                                                             .then((value) => {})
//                                                       }
//                                                   }),
//                                         },
//                                     }
//                                 },
//                               );
//                         }
//                       } else {
//                         openErrorToast(
//                           context: context,
//                           errorMessage:
//                               S.of(context).pleaseFillIntheDestinationString,
//                         );
//                         call_bike_button_controller.error();
//                         await Future.delayed(
//                           const Duration(seconds: 1),
//                         );
//                         call_bike_button_controller.reset();
//                       }
//                     }
//                   },

// diferent code

// copy from here

// try {
//   await firestore
//       .collection(restaurantCollection)
//       .doc(auth)
//       .collection(pendingOrderCollection)
//       .doc(pendingOrderDocument)
//       .set({
//     'number of destinations': numberOfDestination,
//     'destination': controller.text,
//     'digit': doesItStartWithADigit,
//     'rejected by restaurant': rejectByTheRestaurant,
//     'delivered': isDelivered,
//     'bike assigned': isBikeAssigned,
//     'bike called': bikeIsCalled,
//     'bike came': hasBikeCome,
//     'can request a new bike': canTheRestaurantRequestNewBike,
//   }, SetOptions(merge: true));
//   bool isSuucessful = await sendEmailToTheBikes();
//   if (isSuucessful) {
//     buttonController.success();
//     openFlutterToast(
//         backGroundColor: Colors.green,
//         context: context,
//         errorMessage: S.of(context).bikeIsOnItsWayString);
//     await Future.delayed(
//       Duration(milliseconds: 500),
//     );
//     buttonController.reset();
//   }
// } on FirebaseException catch (e) {
//   openFlutterToast(
//       context: context,
//       errorMessage: e.code,
//       backGroundColor: Colors.red);
//   buttonController.error();
//   buttonController.reset();
// }
// all the way here
