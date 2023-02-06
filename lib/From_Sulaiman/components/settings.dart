import 'package:bonapp_restaurant/From_Sulaiman/components/save_coverPhoto.dart';
import 'package:bonapp_restaurant/From_Sulaiman/components/save_profilePhoto.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:fluttertoast/fluttertoast.dart';

import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'dart:io';

import '../../Utils/sanckbar.dart';
import '../../generated/l10n.dart';

class Setting extends StatefulWidget {
  Setting({
    Key? key,
  }) : super(key: key);

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  var changeSettingButtonController = RoundedLoadingButtonController();

  saveUpdateToDatabase(
      TextEditingController update, String fieldNameInFirestore,
      [RoundedLoadingButtonController? controller]) async {
    var forSnackBar = update.text;
    User? user = FirebaseAuth.instance.currentUser;
    if (update.text.isNotEmpty) {
      _firestore.collection('Restaurants').doc(_auth.currentUser!.uid).set({
        fieldNameInFirestore: update.text
      }, SetOptions(merge: true)).then((value) => {
            if (fieldNameInFirestore == 'Restaurant Name')
              {
                _firestore
                    .collection('All restaurant profile Pictures')
                    .doc(_auth.currentUser!.uid)
                    .set({'restaurant name': update.text},
                        SetOptions(merge: true))
                    .then((value) => {
                          controller?.success(),
                          Future.delayed(
                            const Duration(
                              seconds: 1,
                            ),
                          ),
                          openSnackBar(
                              context,
                              '$forSnackBar was Successfully updated',
                              Colors.green),
                          controller?.reset(),
                        })
                    .then((value) => update.clear())
              },
            if (fieldNameInFirestore == 'Email')
              {

                user
                    ?.updateEmail(update.text)
                    .then((value) async => {
                          await Fluttertoast.showToast(
                            msg: '${update.text} was Successfully updated',
                            backgroundColor: Colors.lightGreen,
                            fontSize: 18,
                            gravity: ToastGravity.CENTER,
                          )
                        })
                    .then((value) => update.clear())
                // print('email was updated successfully'),
              },
            if (fieldNameInFirestore == 'Phone Number')
              {
                _firestore
                    .collection('Restaurants')
                    .doc(_auth.currentUser!.uid)
                    .set({
                      'Phone Number': update.text,
                    }, SetOptions(merge: true))
                    .then((value) => {
                          controller?.success(),
                          Future.delayed(
                            const Duration(
                              seconds: 1,
                            ),
                          ),
                          openSnackBar(
                              context,
                              '$forSnackBar was Successfully updated',
                              Colors.green),
                          controller?.reset(),
                        })
                    .then((value) => update.clear())
                // print('email was updated successfully'),
              },
            if (fieldNameInFirestore == 'Restaurant Full Address')
              {
                _firestore
                    .collection('Restaurants')
                    .doc(_auth.currentUser!.uid)
                    .set({
                      'Restaurant Full Address': update.text,
                    }, SetOptions(merge: true))
                    .then((value) => {
                          controller?.success(),
                          Future.delayed(
                            const Duration(
                              seconds: 1,
                            ),
                          ),
                          openSnackBar(
                              context,
                              '$forSnackBar was Successfully updated',
                              Colors.green),
                          controller?.reset(),
                        })
                    .then((value) => update.clear())
                // print('email was updated successfully'),
              }
          });
    }
  }

  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  FirebaseAuth _auth = FirebaseAuth.instance;
  Future resetEmail(String newEmail) async {
    var message;
    User firebaseUser = await FirebaseAuth.instance.currentUser!;
    firebaseUser
        .updateEmail(newEmail)
        .then(
          (value) => message = 'Success',
        )
        .then((value) => {print('updated')})
        .catchError((onError) => message = 'error');
    return message;
  }

  // var hintName = getEmailName();
  late var restaurantNameFromFirebase = '';

  File? imageFileForTheCoverPhoto;
  File? imageFileForTheProfilePhoto;

  // Future<String?> getEmailName() async {
  //   var restName;
  //   var result = await FirebaseFirestore.instance
  //       .collection('Restaurants Database')
  //       .doc(FirebaseAuth.instance.currentUser!.uid)
  //       .get()
  //       .then((value) => {
  //             restaurantNameFromFirebase = value['Restaurant Name'],
  //             restName = value['Restaurant Name'],
  //           });
  //   return restName;
  // }

  final TextEditingController email = TextEditingController();

  final TextEditingController restaurantName = TextEditingController();

  final TextEditingController restaurantFullAddress = TextEditingController();

  final TextEditingController restaurantPhoneNumber = TextEditingController();

  // final TextEditingController community = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final emailField = StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('Restaurants')
            .doc(FirebaseAuth.instance.currentUser?.uid)
            .snapshots(),
        builder: (context, snapshot) {
          return TextFormField(
            autofocus: false,
            controller: email,
            keyboardType: TextInputType.emailAddress,
            //validator: () {},
            onSaved: (value) {
              email.text = value!;
            },
            textInputAction: TextInputAction.done,
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.email),
              contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
              hintText: FirebaseAuth.instance.currentUser?.email,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          );
        });

    //=====================restaurant name input filed ==============================//
    final restaurantNameField = StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('Restaurants')
            .doc(FirebaseAuth.instance.currentUser?.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return CircularProgressIndicator();
          }
          return TextFormField(
            autofocus: false,
            controller: restaurantName,
            keyboardType: TextInputType.text,
            validator: (value) {
              RegExp regexp = RegExp(r'^.{3,}$');
              if (value!.isEmpty) {
                return ('Restaurant name is required');
              }
              if (!regexp.hasMatch(value)) {
                return ("Restaurant name can't be less than 3 char");
              }
            },
            onSaved: (value) {
              restaurantName.text = value!;
            },
            textInputAction: TextInputAction.done,
            decoration: InputDecoration(
                prefixIcon: const Icon(Icons.house),
                contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                hintText: snapshot.data!['Restaurant Name'],
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10))),
          );
        });

    //=====================restaurant address input filed ==============================//
    // final restaurantAddressField = StreamBuilder<DocumentSnapshot>(
    //     stream: FirebaseFirestore.instance
    //         .collection('Restaurants')
    //         .doc(FirebaseAuth.instance.currentUser!.uid)
    //         .snapshots(),
    //     builder: (context, snapshot) {
    //       if (!snapshot.hasData) {
    //         return CircularProgressIndicator();
    //       }
    //       return TextFormField(
    //         autofocus: false,
    //         controller: restaurantFullAddress,
    //         keyboardType: TextInputType.text,
    //         validator: (value) {
    //           RegExp regexp = RegExp(r'^.{3,}$');
    //           if (value!.isEmpty) {
    //             return ('Restaurant address is required');
    //           }
    //           if (!regexp.hasMatch(value)) {
    //             return ("Restaurant address can't be less than 3 char");
    //           }
    //         },
    //         onSaved: (value) {
    //           restaurantFullAddress.text = value!;
    //         },
    //         textInputAction: TextInputAction.done,
    //         decoration: InputDecoration(
    //             prefixIcon: const Icon(Icons.place),
    //             contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
    //             hintText: snapshot.data!['Community'],
    //             border: OutlineInputBorder(
    //                 borderRadius: BorderRadius.circular(10))),
    //       );
    //     });

    //=====================restaurant address input filed ==============================//
    final restaurantPhoneNumberField = StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('Restaurants')
            .doc(FirebaseAuth.instance.currentUser?.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return TextFormField(
              autofocus: false,
              controller: restaurantPhoneNumber,
              keyboardType: TextInputType.number,
              validator: (value) {
                RegExp regexp = RegExp(r'^.{3,}$');
                if (value!.isEmpty) {
                  return ('Contact is required');
                }
                if (!regexp.hasMatch(value)) {
                  return ("Please enter a valid number");
                }
              },
              onSaved: (value) {
                restaurantPhoneNumber.text = value!;
              },
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.phone),
                  contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                  hintText: snapshot.data!['Phone Number'],
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10))),
            );
          } else {
            return CircularProgressIndicator();
          }
        });

    //=====================community input filed ==============================//
    final communityField = StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('Restaurants')
            .doc(FirebaseAuth.instance.currentUser?.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return TextFormField(
              autofocus: false,
              controller: restaurantFullAddress,
              keyboardType: TextInputType.text,
              validator: (value) {
                RegExp regexp = RegExp(r'^.{3,}$');
                if (value!.isEmpty) {
                  return ('Community name is required');
                }
                if (!regexp.hasMatch(value)) {
                  return ("Community name can't be less than 3 char");
                }
              },
              onSaved: (value) {
                restaurantFullAddress.text = value!;
              },
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.location_city),
                  contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                  hintText: snapshot.data!['Restaurant Full Address'],
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10))),
            );
          } else {
            return const CircularProgressIndicator();
          }
        });

    final updateButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: const Color(0xffFF3F02),
      child: RoundedLoadingButton(
        width: MediaQuery.of(context).size.width,
        onPressed: () async {
          if(email.text.isEmpty&&restaurantName.text.isEmpty&&restaurantPhoneNumber.text.isEmpty&&restaurantFullAddress.text.isEmpty){
            print('all is emyty');
            changeSettingButtonController.reset();
          }else{
            saveUpdateToDatabase(email, 'Email', changeSettingButtonController);
            saveUpdateToDatabase(
                restaurantName, 'Restaurant Name', changeSettingButtonController);
            // saveUpdateToDatabase(
            //     community, 'Community', changeSettingButtonController);

            saveUpdateToDatabase(restaurantPhoneNumber, 'Phone Number',
                changeSettingButtonController);
            saveUpdateToDatabase(restaurantFullAddress, 'Restaurant Full Address',
                changeSettingButtonController);
          }


          // await EasyLoading.show(
          //     status: '',
          //     indicator: const CircleAvatar(
          //         backgroundImage: AssetImage('images/appLogo.png')));
        },
        controller: changeSettingButtonController,
        color: Colors.deepOrange,
        child: Text(
          S.of(context).updateSettingsString,
          textAlign: TextAlign.center,
          style: const TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
    );

    return SafeArea(
        child: SingleChildScrollView(
      child: Column(
        // primary: false,
        // padding: const EdgeInsets.all(20),
        // gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        //     crossAxisCount: 1,
        //     childAspectRatio: 5,
        //     mainAxisSpacing: 10,
        //     crossAxisSpacing: 5),
        children: [
          Container(
            child: Stack(
              alignment: Alignment.bottomCenter,
              clipBehavior: Clip.none,
              children: <Widget>[
                Stack(
                  clipBehavior: Clip.none,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () async {
                        var isComplete = await selectFileForCoverPhoto();
                        if (isComplete != null) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SaveCoverPhotoPage(
                                imageUrl: imageFileForTheCoverPhoto,
                              ),
                            ),
                          );
                        }
                      },
                      child: StreamBuilder<DocumentSnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection('MenuPhotos')
                              .doc(FirebaseAuth.instance.currentUser?.uid)
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (snapshot.hasError) {
                              return const Text(
                                  'Error with the databaase. try again later');
                            } else if (!snapshot.hasData) {
                              return const CircularProgressIndicator();
                            }
                            return Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * 0.20,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  fit: BoxFit.none,
                                  image: NetworkImage(
                                    snapshot.data!['cover image url'],
                                  ),
                                ),
                              ),
                            );
                          }),
                    ),
                    Positioned(
                      top: MediaQuery.of(context).size.height * 0.15,
                      left: MediaQuery.of(context).size.width * 0.90,
                      child: Container(
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          // color: Colors.grey.shade300,
                        ),
                        height: 30,
                        width: 30,
                        child: const Center(
                          child: Visibility(
                            visible: false,
                            child: Icon(
                              Icons.camera_alt_rounded,
                              size: 18,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                Positioned(
                  top: 100.0,
                  child: GestureDetector(
                    onTap: () async {
                      if (kDebugMode) {
                        print('Hello world');
                      }
                      var isComplete = await selectFileForProfilePhoto();
                      if (isComplete != null) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SaveProfilePhoto(
                              imageUrl: imageFileForTheProfilePhoto,
                            ),
                          ),
                        );
                      }
                    },
                    child: StreamBuilder<DocumentSnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('All restaurant profile Pictures')
                            .doc(FirebaseAuth.instance.currentUser?.uid)
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.hasError) {
                            return const Text(
                                'Error with the databaase. try again later');
                          } else if (!snapshot.hasData) {
                            return const CircularProgressIndicator();
                          }
                          return Stack(clipBehavior: Clip.none, children: [
                            Container(
                              height: MediaQuery.of(context).size.height * 0.18,
                              width: MediaQuery.of(context).size.width * 0.30,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    fit: BoxFit.contain,
                                    image: NetworkImage(
                                      snapshot.data!['image url'],
                                    ),
                                  ),
                                  border: Border.all(
                                      color: Colors.white, width: 5.0)),
                            ),
                            Positioned(
                              top: MediaQuery.of(context).size.height * 0.10,
                              left: MediaQuery.of(context).size.width * 0.24,
                              child: Container(
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                ),
                                height: 30,
                                width: 30,
                                child: const Center(
                                  child: Visibility(
                                    visible: false,
                                    child: Icon(
                                      Icons.camera_alt_rounded,
                                      size: 18,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ]);
                        }),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 100,
          ),
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
          //   child: emailField,
          // ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
            child: restaurantNameField,
          ),
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
          //   child: restaurantAddressField,
          // ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
            child: restaurantPhoneNumberField,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
            child: communityField,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
            child: updateButton,
          ),
        ],
      ),
    ));
  }

  @override
  void initState() {
    // getEmailName();
    super.initState();
  }

  selectFileForCoverPhoto() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );

    try {
      if (result != null) {
        final path = result.files.single.path;
        setState(() {
          imageFileForTheCoverPhoto = File(
            path!,
          );
          // //  avatarImage = File(path);
          //
          if (kDebugMode) {
            print(imageFileForTheCoverPhoto);
          }
        });
        return path;
      }
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  selectFileForProfilePhoto() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );

    try {
      if (result != null) {
        final path = result.files.single.path;
        setState(() {
          imageFileForTheProfilePhoto = File(
            path!,
          );
          // //  avatarImage = File(path);
          //
          if (kDebugMode) {
            print(imageFileForTheProfilePhoto);
          }
        });
        return path;
      }
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }
}

class Animate extends StatefulWidget {
  const Animate({Key? key}) : super(key: key);

  @override
  State<Animate> createState() => _AnimateState();
}

class _AnimateState extends State<Animate> {
  @override
  Widget build(BuildContext context) {
    return const CupertinoActivityIndicator(
      radius: 20.0,
      animating: true,
      color: CupertinoColors.activeBlue,
    );
  }
}

class AddPic extends StatelessWidget {
  const AddPic({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(20.0)),
        child: Container(
          color: Colors.white70,
          width: width,
          height: height,
          child: Column(
            children: <Widget>[
              IconButton(onPressed: () {}, icon: const Icon(Icons.image)),
              const Expanded(
                  child: Image(
                image: AssetImage('images/sokpov.jpeg'),
              ))
            ],
          ),
        ));
  }
}
