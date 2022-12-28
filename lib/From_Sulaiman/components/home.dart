import 'package:bonapp_restaurant/services/twilio_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../generated/l10n.dart';
import 'delivered_orders.dart';

class Home extends StatefulWidget {
  const Home({
    Key? key,
  }) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Twilio hashim = Twilio();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  int deliveredOrders = 0;
  getAllDeliveryOrders() async {
    await firestore.collection('Restaurants').get().then((restaurant) => {
          restaurant.docs.forEach((element1) {
            element1.reference
                .collection('Pending Orders')
                .get()
                .then((pendingOrder) => {
                      pendingOrder.docs.forEach((element2) {
                        element2.reference
                            .collection('Orders')
                            .get()
                            .then((Order) => {
                                  Order.docs.forEach((element3) {
                                    if (kDebugMode) {
                                      print(element3.id);
                                    }
                                    if (element2['bike order is assigned to'] ==
                                        _auth.currentUser!.uid) {
                                      if (element2['delivered'] == true) {
                                        setState(() {
                                          deliveredOrders++;
                                        });
                                      }
                                    }
                                  })
                                });
                      })
                    });
          })
        });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                height: 100,
                width: 350,
                child: Card(
                  color: Colors.white,
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(
                      color: Colors.deepOrangeAccent,
                    ),
                    borderRadius: BorderRadius.circular(20.0), //<-- SEE HERE
                  ),
                  child: Column(
                    children: [
                      ListTile(
                        onTap: () {
                          // hashim.sendMessage();
                          hashim.sendPhoneVerificationCode();
                        },
                        leading: const Icon(Icons.notifications,
                            size: 30, color: Colors.deepOrangeAccent),
                        title: Text(
                          S.of(context).incomingOrdersString,
                          style: const TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      Container(
                        decoration: const BoxDecoration(
                          color: Colors.deepOrangeAccent,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: StreamBuilder<QuerySnapshot>(
                              stream: FirebaseFirestore.instance
                                  .collection('Restaurants')
                                  .doc(FirebaseAuth.instance.currentUser?.uid)
                                  .collection('Pending Orders')
                                  .where('rejected by restaurant',
                                      isEqualTo: false)
                                  .where('call bike', isEqualTo: true)
                                  .where('delivered', isEqualTo: false)
                                  .where('bike assigned', isEqualTo: false)
                                  .where('bike called', isEqualTo: '0')
                                  .where('digit', isEqualTo: false)
                                  .snapshots(),
                              builder: (context, snapshot) {
                                if (!snapshot.hasData) {
                                  return const CircularProgressIndicator();
                                }
                                int? number = snapshot.data?.docs.length;
                                // for (int i = 0;
                                //     i < snapshot.data!.docs.length;
                                //     ++i) {
                                //   print(snapshot.data?.docs[i].id);
                                // }
                                return Text(
                                  number.toString(),
                                  // incomingOrders.toString(),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: 20,
                                  ),
                                );
                              }),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 100,
                width: 350,
                child: Card(
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(
                      color: Colors.amber,
                    ),
                    borderRadius: BorderRadius.circular(20.0), //<-- SEE HERE
                  ),
                  child: Column(
                    children: [
                      ListTile(
                        leading: const Icon(Icons.timelapse,
                            size: 30, color: Colors.amber),
                        title: Text(
                          S.of(context).pendingOrderString,
                          style: const TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      Container(
                        decoration: const BoxDecoration(
                          color: Colors.amber,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: StreamBuilder<QuerySnapshot>(
                              stream: FirebaseFirestore.instance
                                  .collection('Restaurants')
                                  .doc(FirebaseAuth.instance.currentUser?.uid)
                                  .collection('Pending Orders')
                                  .where('rejected by restaurant',
                                      isEqualTo: false)
                                  // .where('call bike', isEqualTo: true)
                                  .where('delivered', isEqualTo: false)
                                  .where('bike assigned', isEqualTo: true)
                                  .where('bike called', isEqualTo: '1')
                                  // .where('digit', isEqualTo: false)
                                  .snapshots(),
                              builder: (context, snapshot) {
                                if (!snapshot.hasData) {
                                  return const CircularProgressIndicator();
                                }
                                int? number = snapshot.data?.docs.length;
                                for (int i = 0;
                                    i < snapshot.data!.docs.length;
                                    ++i) {
                                  if (kDebugMode) {
                                    print(snapshot.data?.docs[i].id);
                                  }
                                }
                                return Text(
                                  number.toString(),
                                  // incomingOrders.toString(),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: 20,
                                  ),
                                );
                              }),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 100,
                width: 350,
                // decoration: BoxDecoration(
                //     color: Colors.green,
                //     borderRadius: BorderRadius.circular(100)
                //     //more than 50% of width makes circle
                //     ),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => DelOrders()));
                  },
                  child: Card(
                    elevation: 7,
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(
                        color: Colors.greenAccent,
                      ),
                      borderRadius: BorderRadius.circular(20.0), //<-- SEE HERE
                    ),
                    child: Column(
                      children: [
                        ListTile(
                          leading: const Icon(Icons.download_done_sharp,
                              size: 30, color: Colors.greenAccent),
                          title: Text(
                            S.of(context).deliveredOrderString,
                            style: const TextStyle(
                              fontSize: 19,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        Container(
                            decoration: const BoxDecoration(
                              color: Colors.greenAccent,
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: StreamBuilder<QuerySnapshot>(
                                  stream: FirebaseFirestore.instance
                                      .collection('Restaurants')
                                      .doc(FirebaseAuth
                                          .instance.currentUser?.uid)
                                      .collection('Pending Orders')
                                      .where('rejected by restaurant',
                                          isEqualTo: false)
                                      // .where('call bike', isEqualTo: true)
                                      .where('delivered', isEqualTo: true)
                                      // .where('bike assigned', isEqualTo: true)
                                      // // .where('bike called', isEqualTo: '1')
                                      // .where('digit', isEqualTo: false)
                                      .snapshots(),
                                  builder: (context, snapshot) {
                                    if (!snapshot.hasData) {
                                      return const CircularProgressIndicator();
                                    }
                                    int? number = snapshot.data?.docs.length;
                                    for (int i = 0;
                                        i < snapshot.data!.docs.length;
                                        ++i) {
                                      if (kDebugMode) {
                                        print(snapshot.data?.docs[i].id);
                                      }
                                    }
                                    return Text(
                                      number.toString(),
                                      // incomingOrders.toString(),
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        fontSize: 20,
                                      ),
                                    );
                                  }),
                            ))
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
    // SafeArea(
    //   child: StreamBuilder<QuerySnapshot>(
    //       stream: FirebaseFirestore.instance
    //           .collection('Restaurants')
    //           .doc(FirebaseAuth.instance.currentUser!.uid)
    //           .collection('Pending Orders')
    //           .snapshots(),
    //       builder: (context, snapshot) {
    //         if (!snapshot.hasData) {
    //           return const Center(
    //             child: SizedBox(
    //               height: 100,
    //               width: 100,
    //               child: CircularProgressIndicator(),
    //             ),
    //           );
    //         }
    //         return GridView(
    //           primary: false,
    //           padding: const EdgeInsets.all(20),
    //           gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
    //               crossAxisCount: 1,
    //               childAspectRatio: 2.5,
    //               mainAxisSpacing: 10,
    //               crossAxisSpacing: 5),
    //           children: [
    //             Card(
    //               child: Column(
    //                 children: [
    //                   const Padding(
    //                     padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
    //                     child: Text('Orders'),
    //                   ),
    //                   Row(
    //                     children: [
    //                       Expanded(
    //                         child: ListTile(
    //                           leading: const Icon(
    //                             Icons.timelapse,
    //                             size: 30,
    //                             color: Colors.deepOrangeAccent,
    //                           ),
    //                           title: Text(S.of(context).pendingString),
    //                           subtitle: Text('Loading'),
    //                         ),
    //                       ),
    //                       Expanded(
    //                         child: ListTile(
    //                           leading: const Icon(
    //                             Icons.car_rental_outlined,
    //                             size: 30,
    //                             color: Colors.deepOrangeAccent,
    //                           ),
    //                           title: Text(S.of(context).deliveredString),
    //                           // subtitle: Text('1000'),
    //                         ),
    //                       ),
    //                     ],
    //                   ),
    //                 ],
    //               ),
    //             ),
    //           ],
    //         );
    //       }));
  }
}
