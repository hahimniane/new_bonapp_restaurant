import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ChatPages extends StatefulWidget {
  String? id;
  ChatPages({Key? key, this.id}) : super(key: key);

  @override
  State<ChatPages> createState() => _ChatPagesState();
}

class _ChatPagesState extends State<ChatPages> {
  late String message;
  FirebaseAuth auth = FirebaseAuth.instance;
  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BonApp'),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('Restaurants')
                  .doc(auth.currentUser!.uid)
                  .collection('Chats')
                  .orderBy('timestamp', descending: true)
                  .snapshots(),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if (!snapshot.hasData) {
                  return const CircularProgressIndicator();
                } else {
                  return Expanded(
                    child: ListView(
                      reverse: true,
                      children: snapshot.data!.docs
                          .map<Widget>((DocumentSnapshot document) {
                        Map<String, dynamic> data =
                            document.data()! as Map<String, dynamic>;
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment:
                                FirebaseAuth.instance.currentUser!.uid ==
                                        data['sender']
                                    ? CrossAxisAlignment.end
                                    : CrossAxisAlignment.start,
                            children: [
                              Material(
                                borderRadius:
                                    FirebaseAuth.instance.currentUser!.uid ==
                                            data['sender']
                                        ? const BorderRadius.only(
                                            topLeft: Radius.circular(30),
                                            bottomLeft: Radius.circular(30),
                                            topRight: Radius.circular(30),
                                          )
                                        : const BorderRadius.only(
                                            bottomRight: Radius.circular(30),
                                            bottomLeft: Radius.circular(30),
                                            topRight: Radius.circular(30),
                                          ),
                                color: FirebaseAuth.instance.currentUser!.uid ==
                                        data['sender']
                                    ? Colors.pink
                                    : Colors.white,
                                elevation: 5,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    data['message'],
                                    style: TextStyle(
                                        color: FirebaseAuth.instance
                                                    .currentUser!.uid ==
                                                data['sender']
                                            ? Colors.white
                                            : Colors.black54,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ),
                              FirebaseAuth.instance.currentUser!.uid ==
                                      data['sender']
                                  ? SizedBox(
                                      height: 28,
                                      width: 28,
                                      child: FutureBuilder<DocumentSnapshot>(
                                          future: FirebaseFirestore.instance
                                              .collection('Restaurants')
                                              .doc(auth.currentUser!.uid)
                                              .get(),
                                          builder: (context, snapshot) {
                                            if (snapshot.hasData) {
                                              return Image.network(snapshot
                                                  .data!['profile image url']);
                                            }
                                            return Container();
                                          }))
                                  //   Image.asset(
                                  //       'images/logo-modified.png'),
                                  // )
                                  : Container(
                                      height: 28,
                                      width: 28,
                                      child: Image.asset(
                                          'images/logo-modified.png'))
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  );
                }
              },
            ),
            Container(
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: TextField(
                        controller: _controller,
                        onChanged: (value) {
                          message = value;
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            gapPadding: 2,
                            borderRadius: BorderRadius.circular(18),
                          ),
                          iconColor: Colors.green,
                          hintStyle: const TextStyle(
                            color: Colors.grey,
                          ),
                          hintText: 'Aa',
                          suffixIcon: GestureDetector(
                            onTap: () {
                              if (kDebugMode) {
                                print(message);
                              }
                              if (message.isNotEmpty) {
                                FirebaseFirestore.instance
                                    .collection('Restaurants')
                                    .doc(auth.currentUser!.uid)
                                    .collection('Chats')
                                    .add({
                                  'message': message,
                                  'timestamp': DateTime.now(),
                                  'sender':
                                      FirebaseAuth.instance.currentUser!.uid,
                                }).then((value) => {_controller.clear()});
                              } else {
                                print('the field is empty');
                              }
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: CircleAvatar(
                                backgroundColor: Colors.deepOrangeAccent,
                                child: Transform.rotate(
                                  angle: 32.2,
                                  child: const Icon(
                                    FontAwesomeIcons.solidPaperPlane,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
