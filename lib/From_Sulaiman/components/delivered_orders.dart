import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../generated/l10n.dart';

class DelOrders extends StatefulWidget {
  const DelOrders({
    Key? key,
  }) : super(key: key);

  @override
  State<DelOrders> createState() => _DelOrdersState();
}

class _DelOrdersState extends State<DelOrders> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('Restaurants')
            .doc(FirebaseAuth.instance.currentUser?.uid)
            .collection('Pending Orders')
            .where('delivered', isEqualTo: true)
            .snapshots(),
        builder: (context, snapshot) {
          int? size = snapshot.data?.docs.length;
          if (size! <= 0) {
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
                  Text(S.of(context).noPastDeliveriesAvailableString,
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w300,
                          backgroundColor: Colors.white10,
                          fontFamily: GoogleFonts.abel().toString())),
                ],
              ),
            );
          }
          if (!snapshot.hasData) {
            return Center(
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.099,
                width: MediaQuery.of(context).size.width * 0.761,
                child: Image.asset(
                  'images/9beceb082a92006c310a72aa8e2fdfaa.png.webp',
                ),
              ),
            );
          } else {
            return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: TextButton(
                      onPressed: () {},
                      child: ListTile(
                          leading: const Icon(
                            Icons.person,
                            size: 40,
                            color: Colors.pink,
                          ),
                          title: Text(snapshot.data!.docs[index].id),
                          subtitle: const Text('Delivered'),
                          trailing: const Icon(
                            Icons.check,
                            size: 30,
                            color: Colors.green,
                          )),
                    ),
                  );
                });
          }
        });

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
    //   stream: FirebaseFirestore.instance
    //       .collection('Restaurants')
    //       .doc(FirebaseAuth.instance.currentUser!.uid)
    //       .collection('Pending Orders')
    //       .snapshots(),
    //     //   builder:
    //     //       (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
    //     //     if (snapshot.hasError) {
    //     //       return const Text('Something went wrong');
    //     //     }
    //     //
    //     //     if (snapshot.connectionState == ConnectionState.waiting) {
    //     //       return const Text("Loading");
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
    //     Card(
    //       child: TextButton(
    //         onPressed: () {},
    //         child: const ListTile(
    //             leading: Icon(
    //               Icons.person,
    //               size: 40,
    //               color: Colors.pink,
    //             ),
    //             title: Text('Orders'),
    //             subtitle: Text('1000'),
    //             trailing: Icon(
    //               Icons.check,
    //               size: 30,
    //               color: Colors.green,
    //             )),
    //       ),
    //     ),
    // Card(
    //   child: TextButton(
    //     onPressed: () {},
    //     child: const ListTile(
    //         leading: Icon(
    //           Icons.person,
    //           size: 40,
    //           color: Colors.pink,
    //         ),
    //         title: Text('Orders'),
    //         subtitle: Text('1000'),
    //         trailing: Icon(
    //           Icons.check,
    //           size: 30,
    //           color: Colors.green,
    //         )),
    //   ),
    // ),
    //     // Card(
    //     //   child: TextButton(
    //     //     onPressed: () {},
    //     //     child: const ListTile(
    //     //         leading: Icon(
    //     //           Icons.person,
    //     //           size: 40,
    //     //           color: Colors.pink,
    //     //         ),
    //     //         title: Text('Orders'),
    //     //         subtitle: Text('1000'),
    //     //         trailing: Icon(
    //     //           Icons.check,
    //     //           size: 30,
    //     //           color: Colors.green,
    //     //         )),
    //     //   ),
    //     // ),
    //     // Card(
    //     //   child: TextButton(
    //     //     onPressed: () {},
    //     //     child: const ListTile(
    //     //         leading: Icon(
    //     //           Icons.person,
    //     //           size: 40,
    //     //           color: Colors.pink,
    //     //         ),
    //     //         title: Text('Orders'),
    //     //         subtitle: Text('1000'),
    //     //         trailing: Icon(
    //     //           Icons.check,
    //     //           size: 30,
    //     //           color: Colors.green,
    //     //         )),
    //     //   ),
    //     // ),
    //     // Card(
    //     //   child: TextButton(
    //     //     onPressed: () {},
    //     //     child: const ListTile(
    //     //         leading: Icon(
    //     //           Icons.person,
    //     //           size: 40,
    //     //           color: Colors.pink,
    //     //         ),
    //     //         title: Text('Orders'),
    //     //         subtitle: Text('1000'),
    //     //         trailing: Icon(
    //     //           Icons.check,
    //     //           size: 30,
    //     //           color: Colors.green,
    //     //         )),
    //     //   ),
    //     // ),
    //     // Card(
    //     //   child: TextButton(
    //     //     onPressed: () {},
    //     //     child: const ListTile(
    //     //         leading: Icon(
    //     //           Icons.person,
    //     //           size: 40,
    //     //           color: Colors.pink,
    //     //         ),
    //     //         title: Text('Orders'),
    //     //         subtitle: Text('1000'),
    //     //         trailing: Icon(
    //     //           Icons.check,
    //     //           size: 30,
    //     //           color: Colors.green,
    //     //         )),
    //     //   ),
    //     // ),
    //     // Card(
    //     //   child: TextButton(
    //     //     onPressed: () {},
    //     //     child: const ListTile(
    //     //         leading: Icon(
    //     //           Icons.person,
    //     //           size: 40,
    //     //           color: Colors.pink,
    //     //         ),
    //     //         title: Text('Orders'),
    //     //         subtitle: Text('1000'),
    //     //         trailing: Icon(
    //     //           Icons.check,
    //     //           size: 30,
    //     //           color: Colors.green,
    //     //         )),
    //     //   ),
    //     // ),
    //     // Card(
    //     //   child: TextButton(
    //     //     onPressed: () {},
    //     //     child: const ListTile(
    //     //         leading: Icon(
    //     //           Icons.person,
    //     //           size: 40,
    //     //           color: Colors.pink,
    //     //         ),
    //     //         title: Text('Sulaiman A.Barry'),
    //     //         subtitle: Text('1000'),
    //     //         trailing: Icon(
    //     //           Icons.check,
    //     //           size: 30,
    //     //           color: Colors.green,
    //     //         )),
    //     //   ),
    //     // ),
    //   ],
    // );
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2));
  }
}
