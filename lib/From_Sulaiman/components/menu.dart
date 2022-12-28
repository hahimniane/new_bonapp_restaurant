import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../Utils/sanckbar.dart';
import '../../generated/l10n.dart';
import '../../services/firbase.dart';

import '../upoading_new_menu.dart';

enum Action { delete, deactivate }

class Menu extends StatefulWidget {
  Menu({
    Key? key,
    // required this.myKey,
  }) : super(key: key);

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  final _formKey = GlobalKey<FormState>();

  var currentUser = FirebaseAuth.instance.currentUser;

  final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance
      .collection('Restaurants')
      .doc(FirebaseAuth.instance.currentUser?.uid)
      .collection('Menus')
      .snapshots();

  final TextEditingController photo = TextEditingController();
  final TextEditingController name = TextEditingController();
  final TextEditingController price = TextEditingController();
  final TextEditingController desc = TextEditingController();
  final TextEditingController ingredientOne = TextEditingController();
  final TextEditingController ingredientTwo = TextEditingController();
  final TextEditingController ingredientThree = TextEditingController();

  late int imageType;

  bool loader = false;
  // bool controller = true;

  FirebaseAthentications firebaseAthentications = FirebaseAthentications();

  late File imageFile1;

  late UploadTask? task;

  late String avatarImage =
      'https://image.shutterstock.com/image-vector/add-image-vector-icon-260nw-1042853482.jpg';

  late String iconLink =
      'https://image.shutterstock.com/image-vector/add-image-vector-icon-260nw-1042853482.jpg';

  MaterialColor iconColor = Colors.green;

  buildCard(String img, String title, String subtitle, String price) {
    return Card(
      child: TextButton(
        onPressed: () {},
        child: ListTile(
            leading: Image(image: AssetImage(img)),
            title: Text(title),
            subtitle: Text(subtitle),
            trailing: Text(price)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _formKey,
      body: SafeArea(
          child: Column(
        children: [
          Expanded(
            flex: 5,
            child: StreamBuilder<QuerySnapshot>(
              stream: _usersStream,
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                      child: SizedBox(
                          width: 100,
                          height: 100,
                          child: CircularProgressIndicator()));
                } else if (snapshot.data!.docs.isEmpty) {
                  // WidgetsBinding.instance.addPostFrameCallback((_) {
                  //   setState(() {
                  //     snapshot.data!.docs.isEmpty ? controller = false : true;
                  //   });
                  // });

                  return Center(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.091,
                          width: MediaQuery.of(context).size.width * 0.561,
                          child: Image.asset(
                            'images/4125705.png',
                          )),
                      Text(
                        "You don't have any menus yet",
                        style: TextStyle(
                          fontWeight: FontWeight.w300,
                          fontSize: MediaQuery.of(context).size.width * 0.061,
                        ),
                      ),
                    ],
                  ));
                } else if (!snapshot.hasData) {
                  return const Center(
                      child: SizedBox(
                          height: 50,
                          width: 50,
                          child: CircularProgressIndicator()));
                } else {
                  return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, int index) {
                        DocumentSnapshot data = snapshot.data!.docs[index];
                        final item = snapshot.data!.docs[index];
                        return Slidable(
                          endActionPane: ActionPane(
                            motion: const StretchMotion(),
                            dismissible: DismissiblePane(
                                confirmDismiss: ovveride,
                                onDismissed: () {
                                  Slidable.of(context)?.openEndActionPane();
                                }),
                            children: [
                              SlidableAction(
                                onPressed: (
                                  BuildContext context,
                                ) async {
                                  await showDialog(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        _buildPopupDialogForDeletingMenu(
                                            context, data.id),
                                  );
                                },
                                backgroundColor: Colors.red,
                                foregroundColor: Colors.white,
                                icon: Icons.delete,
                                label: S.of(context).deleteString,
                              ),
                              SlidableAction(
                                flex: 1,
                                onPressed: (
                                  BuildContext context,
                                ) {
                                  if (data['active']) {
                                    data.reference.set({
                                      'active': false,
                                    }, SetOptions(merge: true)).then(
                                        (value) => {
                                              openSnackBar(
                                                  _formKey.currentContext!,
                                                  '${data['food name']} ,${S.of(_formKey.currentContext!).menuHasBeenDeactivatedString}',
                                                  Colors.red)
                                            });
                                  } else {
                                    data.reference.set({
                                      'active': true,
                                    }, SetOptions(merge: true)).then(
                                        (value) => {
                                              openSnackBar(
                                                  _formKey.currentContext!,
                                                  '${data['food name']} ,${S.of(_formKey.currentContext!).menuHasBeenActivatedString}',
                                                  Colors.green)
                                            });
                                  }
                                },
                                backgroundColor: const Color(0xFF7BC043),
                                foregroundColor: Colors.white,
                                icon: FontAwesomeIcons.eye,
                                label: data['active']
                                    ? S
                                        .of(_formKey.currentContext!)
                                        .DeactivateString
                                    : S
                                        .of(_formKey.currentContext!)
                                        .activateString,
                              ),
                            ],
                          ),
                          key: Key(item.toString()),
                          child: SizedBox(
                            height: 150,
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              elevation: 3,
                              child: GestureDetector(
                                onLongPress: () {
                                  if (kDebugMode) {
                                    print(data.id);
                                  }
                                },
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 6,
                                      child: ListTile(
                                          leading: Image(
                                              image: NetworkImage(
                                                  data['image link'])),
                                          title: Text(data['food name']),
                                          subtitle: Text(data['description']),
                                          trailing: Text(
                                              ' ${data['food price']} GNF')),
                                    ),
                                    Expanded(
                                        flex: 1,
                                        child: GestureDetector(
                                          onTap: () {
                                            if (kDebugMode) {}
                                          },
                                          child: Icon(
                                            FontAwesomeIcons.eye,
                                            color: data['active'] == true
                                                ? Colors.green
                                                : Colors.red,
                                            size: 15,
                                          ),
                                        ))
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      });
                  //   GridView(
                  //   primary: false,
                  //   padding: const EdgeInsets.all(20),
                  //   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  //       crossAxisCount: 1,
                  //       childAspectRatio: 3,
                  //       mainAxisSpacing: 10,
                  //       crossAxisSpacing: 5),
                  //   children:
                  //       snapshot.data!.docs.map((DocumentSnapshot document) {
                  //     Map<String, dynamic> data =
                  //         document.data()! as Map<String, dynamic>;
                  //     return Card(
                  //       child: GestureDetector(
                  //         onLongPress: () {
                  //           if (kDebugMode) {
                  //             print(data.keys);
                  //           }
                  //         },
                  //         child: Row(
                  //           children: [
                  //             Expanded(
                  //               flex: 6,
                  //               child: ListTile(
                  //                   leading: Image(
                  //                       image: NetworkImage(data['image link'])),
                  //                   title: Text(data['food name']),
                  //                   subtitle: Text(data['description']),
                  //                   trailing: Text(' ${data['food price']} GNF')),
                  //             ),
                  //             Expanded(
                  //                 flex: 1,
                  //                 child: GestureDetector(
                  //                   onTap: () {
                  //                     if (kDebugMode) {
                  //                       print('the edit button was pressed');
                  //                     }
                  //                   },
                  //                   child: const Icon(
                  //                     FontAwesomeIcons.eye,
                  //                     color: Colors.greenAccent,
                  //                     size: 15,
                  //                   ),
                  //                 ))
                  //           ],
                  //         ),
                  //       ),
                  //     );
                  //   }).toList(),
                  // );
                }
              },
            ),
          ),
          Expanded(
            flex: 0,
            child: Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: FloatingActionButton(
                  splashColor: Colors.deepOrange,
                  child: const Center(
                      child: Icon(
                    Icons.add,
                    size: 20,
                  )),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const AddNewMenuPage()));
                  },
                ),
              ),
            ),
          )
        ],
      )),
    );
  }

  doNoting(BuildContext context, int index, var id) {
    print('the index  $index is called which has an action of $id');
  }

  Future<bool> ovveride() {
    return Future.value(false);
  }

  @override
  void initState() {
    super.initState();
    Slidable.of(context)?.openEndActionPane();
  }

  Widget _buildPopupDialogForDeletingMenu(BuildContext context, var data) {
    FirebaseAthentications firebaseAuthentications = FirebaseAthentications();
    FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      backgroundColor: Colors.white,
      // shape: ShapeBorder
      title: Row(
        children: [
          Expanded(
            flex: 2,
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                S
                    .of(_formKey.currentContext!)
                    .areYouSureYouWantToDeleteMenuString,
                // 'Test',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
            ),
          ),
          Icon(
            Icons.delete,
            color: Colors.deepOrange,
          )
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            S.of(_formKey.currentContext!).menuDeleteWarningString,
            style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Colors.black54),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                // border: Border.all(
                //   width: 2,
                //   color: Colors.deepOrangeAccent,
                // ),
              ),
              width: MediaQuery.of(context).size.width,
              child: TextButton(
                style: TextButton.styleFrom(
                    backgroundColor: Colors.deepOrangeAccent),
                onPressed: () async {
                  await EasyLoading.show(
                    indicator: const CircularProgressIndicator(),
                  );
                  try {
                    firestore
                        .collection('Restaurants')
                        .doc(FirebaseAuth.instance.currentUser?.uid)
                        .collection('Menus')
                        .doc(data)
                        .delete()
                        .then((value) => {
                              openSnackBar(
                                  _formKey.currentContext!,
                                  'Menu ${S.of(context).menuHasBeenDeletedString}',
                                  Colors.green),

                              //TODO add functionality to delete the image from firebase storage whenever a menu is deleted.
                            })
                        .then((value) => Navigator.pop(context));
                  } on FirebaseException catch (e) {
                    Fluttertoast.showToast(msg: e.message.toString());
                    await EasyLoading.dismiss();
                  }
                  await EasyLoading.dismiss();
                },
                child: Text(S.of(_formKey.currentContext!).yestImSureString,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white)),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0, top: 10),
            child: Container(
              height: 40,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(width: 2, color: Colors.deepOrangeAccent)),
              width: MediaQuery.of(context).size.width,
              child: TextButton(
                style: TextButton.styleFrom(backgroundColor: Colors.white),
                onPressed: () {
                  EasyLoading.show(indicator: CircularProgressIndicator());
                  Navigator.pop(context);
                  EasyLoading.dismiss();
                },
                child: Text(S.of(_formKey.currentContext!).noDontDelete,
                    style: const TextStyle(fontWeight: FontWeight.bold)),
              ),
            ),
          )
        ],
      ),
    );
  }
}
