import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../generated/l10n.dart';

class CallPage extends StatelessWidget {
  CallPage({Key? key}) : super(key: key);

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('BonApp')),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(S.of(context).numberToCallString),
            SizedBox(
              height: 8,
            ),
            StreamBuilder<DocumentSnapshot>(
                stream: firestore
                    .collection('Admins')
                    .doc('ServiceReference')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: SizedBox(
                        height: 100,
                        width: 100,
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                  return Center(
                    child: Text(
                      snapshot.data!['phoneNumber'],
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                        fontSize: 35,
                      ),
                    ),
                  );
                }),
          ],
        ),
      ),
    );
  }
}
