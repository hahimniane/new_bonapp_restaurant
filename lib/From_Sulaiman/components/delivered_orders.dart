import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


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
          int size = snapshot.data?.docs.length ?? 0;

          if (size <= 0) {
            print('size is less than zero $size');
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
                          // fontFamily: GoogleFonts.abel().toString(),
                      ),
                  ),
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
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2));
  }
}
