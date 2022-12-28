import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../generated/l10n.dart';

class PenOrders extends StatelessWidget {
  _generateWidgets(List myList, var doc) {
    var myMap = Map();
    for (int i = 0; i < myList.length; i++) {
      myMap.addAll(myList[i]);
    }

    // return Column(
    //   children: myList
    //       .map((i) => new Card(
    //             shape: RoundedRectangleBorder(
    //               borderRadius: BorderRadius.circular(5),
    //             ),
    //             elevation: 5,
    //             color: Colors.white,
    //             margin: const EdgeInsets.all(10),
    //             child: Row(
    //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //               children: [
    //                 Padding(
    //                   padding: const EdgeInsets.all(8.0),
    //                   child: Text(
    //                     doc['ingredient'][int.parse(i)],
    //                     style: TextStyle(
    //                       color: Colors.red,
    //                       decoration: Provider.of<MyAppBar>(
    //                         context,
    //                       ).isChecked
    //                           ? TextDecoration.none
    //                           : TextDecoration.lineThrough,
    //                       fontWeight: FontWeight.w700,
    //                     ),
    //                   ),
    //                 ),
    //                 Checkbox(
    //                   value: Provider.of<MyAppBar>(
    //                     context,
    //                   ).isChecked,
    //                   onChanged: (value) {
    //                     Provider.of<MyAppBar>(context, listen: false)
    //                         .change(value);
    //                   },
    //                 ),
    //               ],
    //             ),
    //           ))
    //       .toList(),
    // );
    return Column(
      children: [
        for (int i = 0; i < myMap.length; i++)
          // Card(
          //   shape: RoundedRectangleBorder(
          //     borderRadius: BorderRadius.circular(5),
          //   ),
          //   elevation: 5,
          //   color: Colors.white,
          //   margin: const EdgeInsets.all(10),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     children: [
          //       Padding(
          //         padding: const EdgeInsets.all(8.0),
          //         child: Text(
          //           doc['ingredient'][i],
          //           style: TextStyle(
          //             color: Colors.red,
          //             decoration: Provider.of<MyAppBar>(
          //               context,
          //             ).isCheckedList[i]
          //                 ? TextDecoration.none
          //                 : TextDecoration.lineThrough,
          //             fontWeight: FontWeight.w700,
          //           ),
          //         ),
          //       ),
          //       Checkbox(
          //         value: Provider.of<MyAppBar>(
          //           context,
          //         ).isCheckedList[i],
          //         onChanged: (value) {
          //           Provider.of<MyAppBar>(context, listen: false)
          //               .change(value, i);
          //           print('the ingredient at location ${i + 1} = ' +
          //               Provider.of<MyAppBar>(context, listen: false)
          //                   .isCheckedList[i]
          //                   .toString());
          //         },
          //       ),
          //     ],
          //   ),
          // )

          ListTile(
              leading: Text(myMap.entries.elementAt(i).key),
              trailing: myMap.entries.elementAt(i).value == true
                  ? const Icon(Icons.done)
                  : const Icon(Icons.cancel)
              // Image.network(
              //     document['image link']),
              ),
      ],
    );
  }

  final _usersStream = FirebaseFirestore.instance
      .collection('Restaurants')
      .doc(FirebaseAuth.instance.currentUser?.uid)
      .collection('Pending Orders');

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  PenOrders({
    Key? key,
  }) : super(key: key);
  buildCard(
      Icon icon, String title, StreamBuilder subtitle, StreamBuilder trailing,
      {required VoidCallback whenYouTapp}) {
    return Card(
      child: TextButton(
        onLongPress: () async {
          var myMap = Map();

          await firestore
              .collection('Customers')
              .doc('SCixi4fOkAOLghXEdNlTNyxKT0D3')
              .collection('Orders')
              .doc('order2087')
              .collection('Order')
              .doc('3')
              .get()
              .then((value) => {
                    print(value['ingredients'][0]),
                    // print(value['ingredients'][1]),

                    for (int i = 0; i < value['ingredients'].length; i++)
                      {
                        myMap.addAll(value['ingredients'][i]),
                      }

                    // print(value[0]["name"]),

                    // validMap =
                    //     json.decode(json.encode(list)) as Map<String, dynamic>,
                    // print(validMap),
                    // print(list)

                    // myCollection.values,
                    // list = value['ingredients'],
                    // myCollection.map((key, value) => key * 2),
                    // print(list.asMap().keys.toList()),

                    // map = Map<int, dynamic>.from(list.asMap()),
                    // myCollection.addAll(value['ingredients']),

                    // print(map.entries),
                    // print(myCollection.keys),
                  });
          if (kDebugMode) {
            print('${myMap.keys}  ${myMap.values}');
          }
        },
        onPressed: whenYouTapp,
        child: ListTile(
          leading: icon,
          title: Text(title),
          subtitle: subtitle,
          //   Text('$subtitle'),
          trailing: trailing,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _usersStream
          .where('rejected by restaurant', isEqualTo: false)
          .where('delivered', isEqualTo: false)
          .where('digit', isEqualTo: false)
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: Text('You don\'t have any orders yet'),
          );
        } else if (snapshot.data!.docs.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.099,
                  width: MediaQuery.of(context).size.width * 0.761,
                  child: Image.asset(
                    'images/9beceb082a92006c310a72aa8e2fdfaa.png.webp',
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(S.of(context).noOrdersAvailableString),
              ],
            ),
          );
        } else {
          return GridView(
            primary: false,
            padding: const EdgeInsets.all(20),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                childAspectRatio: 3,
                mainAxisSpacing: 10,
                crossAxisSpacing: 5),
            children: List.generate(
              snapshot.data!.docs.length,
              (i) => buildCard(
                const Icon(FontAwesomeIcons.hamburger, color: Colors.redAccent),
                snapshot.data!.docs[i].id,
                StreamBuilder<DocumentSnapshot>(
                  stream: snapshot.data!.docs[i].reference
                      .collection('Orders')
                      .doc('total price and location')
                      .snapshots(),
                  builder:
                      (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    if (snapshot.hasData) {
                      return Text(snapshot.data['Total Price']);
                    }
                    return const CircularProgressIndicator();
                  },
                ),
                StreamBuilder(
                  stream: snapshot.data!.docs[i].reference
                      .collection('Orders')
                      .doc('total price and location')
                      .snapshots(),
                  builder:
                      (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    if (snapshot.hasData) {
                      DateTime dt =
                          (snapshot.data['Order Date'] as Timestamp).toDate();
                      return Text('${dt.day} / ' +
                          dt.month.toString() +
                          ' / ' +
                          dt.year.toString());
                    } else if (!snapshot.hasData) {
                      return SizedBox(
                        height: 50,
                        width: 50,
                        child: const CircularProgressIndicator(),
                      );
                    } else {
                      return const Text(''
                          'Error from the database Please try Again later');
                    }
                  },
                ),
                whenYouTapp: () {
                  showModalBottomSheet<void>(
                    shape: const RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(25.0)),
                    ),
                    context: context,
                    builder: (BuildContext context) {
                      return Container(
                        decoration: BoxDecoration(
                          color: Colors.white10,
                          // border: Border.all(width: 2, color: Colors.grey),
                          borderRadius: BorderRadius.circular(40),
                        ),
                        height: MediaQuery.of(context).size.height * 0.60,
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              const SizedBox(
                                height: 15,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Expanded(
                                    child: StreamBuilder<DocumentSnapshot>(
                                        stream: snapshot.data!.docs[i].reference
                                            .snapshots(),
                                        builder: (context, snapshot1) {
                                          if (!snapshot1.hasData) {
                                            return const Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            );
                                          }
                                          return Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: TextButton(
                                                style: TextButton.styleFrom(
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15.0),
                                                    ),
                                                    elevation: 4,
                                                    backgroundColor:
                                                        Colors.green.shade500),
                                                onPressed: () async {
                                                  if (snapshot1.data![
                                                          'bike called'] ==
                                                      '1') {
                                                    await Fluttertoast.showToast(
                                                            gravity:
                                                                ToastGravity
                                                                    .CENTER,
                                                            backgroundColor:
                                                                Colors.green,
                                                            msg:
                                                                'the bike is already on its way')
                                                        .then((value) => {
                                                              // Navigator.pop(
                                                              //     context)
                                                            });
                                                  } else {
                                                    snapshot
                                                        .data!.docs[i].reference
                                                        .update({
                                                      'call bike': false,
                                                      'bike called': '1',
                                                    }).then((value) async => {
                                                              await Fluttertoast.showToast(
                                                                      gravity:
                                                                          ToastGravity
                                                                              .CENTER,
                                                                      backgroundColor:
                                                                          Colors
                                                                              .green,
                                                                      msg:
                                                                          'the bike is on its way')
                                                                  .then(
                                                                      (value) =>
                                                                          {
                                                                            Navigator.pop(context)
                                                                          })
                                                            });
                                                  }
                                                },
                                                child: snapshot1.data![
                                                            'call bike'] ==
                                                        false
                                                    ? Text(
                                                        S
                                                            .of(context)
                                                            .bikeIsOnItsWayString,
                                                        style: const TextStyle(
                                                            color:
                                                                Colors.white),
                                                      )
                                                    : Text(
                                                        S
                                                            .of(context)
                                                            .callBikeForDeliveryString,
                                                        style: const TextStyle(
                                                            color:
                                                                Colors.white),
                                                      )),
                                          );
                                        }),
                                  ),
                                  const SizedBox(
                                    width: 15,
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: TextButton(
                                        style: TextButton.styleFrom(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15.0),
                                            ),
                                            elevation: 4,
                                            backgroundColor: Colors.red),
                                        onPressed: () async {
                                          if (snapshot.data!.docs[i]
                                                  ['bike called'] ==
                                              '1') {
                                            Fluttertoast.showToast(
                                                toastLength: Toast.LENGTH_LONG,
                                                gravity: ToastGravity.SNACKBAR,
                                                backgroundColor: Colors.red,
                                                msg:
                                                    'You can\'t rejected an order after you have called a bike');
                                          } else {
                                            snapshot.data!.docs[i].reference
                                                .update({
                                              'rejected by restaurant': true,
                                            }).then((value) => {
                                                      Navigator.pop(context),
                                                    });
                                          }
                                        },
                                        child: Text(
                                          S.of(context).declineOrderString,
                                          style: const TextStyle(
                                              color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              StreamBuilder<QuerySnapshot>(
                                stream: FirebaseFirestore.instance
                                    .collection('Restaurants')
                                    .doc(FirebaseAuth.instance.currentUser!.uid)
                                    .collection('Pending Orders')
                                    .doc(snapshot.data!.docs[i].reference.id)
                                    .collection('Order')
                                    .snapshots(),
                                builder: (BuildContext context,
                                    AsyncSnapshot<dynamic> lastSnapshot) {
                                  if (!lastSnapshot.hasData) {
                                    return const CircularProgressIndicator();
                                  }
                                  return ListView.builder(
                                    itemCount: lastSnapshot.data.docs.length,
                                    scrollDirection: Axis.vertical,
                                    shrinkWrap: true,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      var document =
                                          lastSnapshot.data.docs[index];
                                      return Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          children: [
                                            Card(
                                              color: Colors.white54,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                              ),
                                              elevation: 10,
                                              child: Column(
                                                children: [
                                                  ListTile(
                                                      leading: const Text(
                                                          'Menu Name: '),
                                                      trailing: Text(
                                                          document['food name'])
                                                      // Image.network(
                                                      //     document['image link']),
                                                      ),
                                                  ListTile(
                                                      leading: const Text(
                                                          'amount of items: '),
                                                      trailing: Text(document[
                                                              'amount of items']
                                                          .toString())
                                                      // Image.network(
                                                      //     document['image link']),
                                                      ),
                                                  ListTile(
                                                      leading: const Text(
                                                          'Total Price: '),
                                                      trailing: Text((int.parse(
                                                                      document[
                                                                          'food price']) *
                                                                  document[
                                                                      'amount of items'])
                                                              .toString() +
                                                          ' GNF')
                                                      // Image.network(
                                                      //     document['image link']),
                                                      ),
                                                  _generateWidgets(
                                                      document['ingredients'],
                                                      document),
                                                  // ListTile(
                                                  //     leading:
                                                  //         const Text('Ketchup: '),
                                                  //     trailing: document[
                                                  //                 'ketchup'] ==
                                                  //             true
                                                  //         ? const Icon(Icons.done)
                                                  //         : const Icon(
                                                  //             Icons.cancel)
                                                  //     // Image.network(
                                                  //     //     document['image link']),
                                                  //     ),
                                                  // ListTile(
                                                  //     leading: const Text(
                                                  //         'Mayonnaise: '),
                                                  //     trailing: document[
                                                  //                 'mayonnaise'] ==
                                                  //             true
                                                  //         ? const Icon(Icons.done)
                                                  //         : const Icon(
                                                  //             Icons.cancel)
                                                  //     // Image.network(
                                                  //     //     document['image link']),
                                                  //     ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                    // children: lastSnapshot.data!.docs
                                    //     .map<Widget>(
                                    //         (DocumentSnapshot document) {
                                    //   Map<String, dynamic> data = document
                                    //       .data()! as Map<String, dynamic>;
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          );
        }
      },
    );
    //   GridView(
    //   primary: false,
    //   padding: const EdgeInsets.all(20),
    //   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
    //       crossAxisCount: 1,
    //       childAspectRatio: 3,
    //       mainAxisSpacing: 10,
    //       crossAxisSpacing: 5),
    //   children: [
    //     // StreamBuilder<QuerySnapshot>(
    //     //   stream: _usersStream,
    //     //   builder:
    //     //       (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
    //     //     if (snapshot.hasError) {
    //     //       return const Text('Something went wrong');
    //     //     }
    //     //
    //     //     if (snapshot.connectionState == ConnectionState.waiting) {
    //     //       return Center(child: const CircularProgressIndicator());
    //     //     }
    //     //     if (!snapshot.hasData) {
    //     //       return const Center(
    //     //           child: SizedBox(
    //     //               height: 50,
    //     //               width: 50,
    //     //               child: CircularProgressIndicator()));
    //     //     }
    //     //     return GridView(
    //     //       primary: false,
    //     //       padding: const EdgeInsets.all(20),
    //     //       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
    //     //           crossAxisCount: 1,
    //     //           childAspectRatio: 3,
    //     //           mainAxisSpacing: 10,
    //     //           crossAxisSpacing: 5),
    //     //       children: snapshot.data!.docs.map((DocumentSnapshot document) {
    //     //         Map<String, dynamic> data =
    //     //             document.data()! as Map<String, dynamic>;
    //     //         return Card(
    //     //           child: GestureDetector(
    //     //             onLongPress: () {
    //     //               print('card was long pressed');
    //     //             },
    //     //             child: Row(
    //     //               children: [
    //     //                 Expanded(
    //     //                   flex: 6,
    //     //                   child: ListTile(
    //     //                       leading: Image(
    //     //                           image: NetworkImage(data['image link'])),
    //     //                       title: Text(data['food name']),
    //     //                       subtitle: Text(data['description']),
    //     //                       trailing: Text(' ${data['food price']} GNF')),
    //     //                 ),
    //     //                 Expanded(
    //     //                     flex: 1,
    //     //                     child: GestureDetector(
    //     //                       onTap: () {
    //     //                         print('the edit button was pressed');
    //     //                       },
    //     //                       child: const Icon(
    //     //                         Icons.edit,
    //     //                         size: 15,
    //     //                       ),
    //     //                     ))
    //     //               ],
    //     //             ),
    //     //           ),
    //     //         );
    //     //       }).toList(),
    //     //     );
    //     //     return ListView(
    //     //       children: snapshot.data!.docs.map((DocumentSnapshot document) {
    //     //         Map<String, dynamic> data =
    //     //             document.data()! as Map<String, dynamic>;
    //     //         return ListTile(
    //     //           title: Text(data['full_name']),
    //     //           subtitle: Text(data['company']),
    //     //         );
    //     //       }).toList(),
    //     //     );
    //     //   },
    //     // ),
    //     buildCard(Icon(Icons.person, size: 40, color: Colors.pink), 'Order',
    //         '200', '03/29/2022'),
    //     buildCard(Icon(Icons.person, size: 40, color: Colors.pink), 'Order',
    //         '2400', '03/28/2022'),
    //     // buildCard(Icon(Icons.person, size: 40, color: Colors.pink), 'Order',
    //     //     '2500', '03/27/2022'),
    //     // buildCard(Icon(Icons.person, size: 40, color: Colors.pink), 'Order',
    //     //     '2200', '03/26/2022'),
    //     // buildCard(Icon(Icons.person, size: 40, color: Colors.pink), 'Order',
    //     //     '2100', '03/25/2022'),
    //     // buildCard(Icon(Icons.person, size: 40, color: Colors.pink), 'Order',
    //     //     '2400', '03/25/2022'),
    //     // buildCard(Icon(Icons.person, size: 40, color: Colors.pink), 'Order',
    //     //     '1200', '03/24/2022'),
    //     // buildCard(Icon(Icons.person, size: 40, color: Colors.pink), 'Order',
    //     //     '3200', '03/23/2022'),
    //     // buildCard(Icon(Icons.person, size: 40, color: Colors.pink), 'Order',
    //     //     '3400', '03/22/2022'),
    //     // buildCard(Icon(Icons.person, size: 40, color: Colors.pink), 'Order',
    //     //     '5600', '03/21/2022'),
    //     // buildCard(Icon(Icons.person, size: 40, color: Colors.pink), 'Order',
    //     //     '1000', '03/20/2022'),
    //     StreamBuilder<QuerySnapshot>(
    //         stream: FirebaseFirestore.instance
    //             .collection('Restaurants')
    //             .doc(FirebaseAuth.instance.currentUser!.uid)
    //             .collection('Pending Orders')
    //             .snapshots(),
    //         builder: (context, snapshot) {
    //           if (snapshot.hasError) {
    //             return Text('Something went wrong');
    //           }
    //
    //           if (snapshot.connectionState == ConnectionState.waiting) {
    //             return Text("Loading");
    //           }
    //
    //           return
    //         })
    //   ],
    // );
  }
}
//hashim MainAxisAlignment
//another one
//dsfjsf
//final test
