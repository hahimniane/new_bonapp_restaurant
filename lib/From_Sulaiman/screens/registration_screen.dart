import 'package:bonapp_restaurant/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../../generated/l10n.dart';
import '../../services/firbase.dart';
import '../../Provders/provider.dart';
import 'login_screen.dart';
import 'dart:io' show Platform;

class RegistrationScreen extends StatefulWidget {
  List<String> ourList;
  String theFirstCommunity;
  RegistrationScreen(
      {Key? key, required this.ourList, required this.theFirstCommunity})
      : super(key: key);
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  var signUpButtonController = RoundedLoadingButtonController();

  addRestaurantLocationToFirebase(String latitude, String longitude) {
    FirebaseFirestore.instance
        .collection('Restaurants')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .set({
      'latitude': latitude,
      'longitude': longitude,
    }, SetOptions(merge: true));
  }

  getLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      await Geolocator.requestPermission();

      return;
    } else if (permission == LocationPermission.deniedForever) {
      await Geolocator.openLocationSettings();

      return;
    } else {
      final position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      print("latitude = ${position.latitude}");
      print("longitude= ${position.longitude}");

      addRestaurantLocationToFirebase(
          position.latitude.toString(), position.longitude.toString());
    }
  }

  List<String> myList = [];
  List<String> cities = [];

  @override
  void initState() {
    getLocation();
    super.initState();
  }

  // List<String> communityItems = [
  //   // "Almamya",
  //   // "Boulbinet",
  //   // "Coronthie",
  //   // "Fotoba",
  //   // "Kassa",
  //   // "Kouléwondy",
  //   // "Manquepas",
  //   // "Sandervalia",
  //   // "Sans-fil",
  //   // "Témitaye",
  //   // "Tombo",
  //   // "Belle-vue école",
  //   // "Belle-vue-marché",
  //   // "Camayenne",
  //   // "Cameroun",
  //   // "Dixinn-cité1",
  //   // "Dixinn-cité 2",
  //   // "Dixinn-gare",
  //   // "Dixinn-gare-rails",
  //   // "Dixinn-mosquée",
  //   // "Dixinn-port",
  //   // " Hafia 1",
  //   // "Hafia 2",
  //   // " Hafia-minière",
  //   // "Hafia-mosquée",
  //   // "Kénien",
  //   // "Landréah",
  //   // "Minière-cité",
  //   // "Boussoura",
  //   // "Bonfi",
  //   // "Bonfi-marché",
  //   // "Carrière",
  //   // "Coléah-centre",
  //   // "Coléah-cité",
  //   // "Domino",
  //   // "Hermakönon",
  //   // "Imprimerie",
  //   // "Lanséboudji",
  //   // "Madina-centre",
  //   // "Madina-cité",
  //   // "Madina-école",
  //   // "Madina-marché",
  //   // "Madina-mosquée",
  //   // "Mafanco",
  //   // "Mafonco-centre",
  //   // "Matam",
  //   // "Matam-lido",
  //   // "Touguiwondy",
  //   // " Cobaya",
  //   // "Dar-es-salam",
  //   // " Hamdalaye 1",
  //   // "Hamdalaye 2",
  //   // "Hamdalaye-mosquée",
  //   // "Kaporo-centre",
  //   // "Kaporo-rails",
  //   // " Kipé",
  //   // " Koloma 1",
  //   // "Koloma 2",
  //   // "Lambadji",
  //   // "Nongo",
  //   // "Ratoma-centre",
  //   // "Ratoma-dispensaire",
  //   // "Simbaya-gare",
  //   // "Sonfonia-gare",
  //   // "Taouyah",
  //   // "Wanindara",
  //   // "Yattayah",
  //   // "Béanzin",
  //   // "Camp Alpha Yaya Diallo",
  //   // "Citée de l'air",
  //   // "Dabompa, Dabondy 1",
  //   // "Dabondy 2",
  //   // "Dabondy 3",
  //   // "Dabondyécole",
  //   // "Dabondy-rails",
  //   // "Dar-es-salam",
  //   // "Gbéssia-centre",
  //   // "Gbéssia-cité 1",
  //   // "Gbessia-cité 2",
  //   // "Gbessia-cité 3",
  //   // "Gbéssia-école",
  //   // "Gbéssia-port 1",
  //   // "Gbéssia-port 2",
  //   // "Kissosso",
  //   // " Matoto-centre",
  //   // "Matoto-marché",
  //   // "Sangoya-mosquée",
  //   // "Simbaya 1",
  //   // "Simbaya 2",
  //   // "Tanéné-marché",
  //   // "Tanéné-mosquée",
  //   // "Tombolia",
  //   // "Yimbaya-école",
  //   // "Yimbaya-permanence",
  //   // "Yimbaya-tannerie"
  // ];

  FirebaseAthentications firebaseFunction = FirebaseAthentications();
  @override
  // from key
  final _formKey = GlobalKey<FormState>();

  final _auth = FirebaseAuth.instance;
  //editing controller
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController passwordAgain = TextEditingController();
  final TextEditingController restaurantName = TextEditingController();
  final TextEditingController restaurantFullAddress = TextEditingController();
  final TextEditingController restaurantPhoneNumber = TextEditingController();
  // final TextEditingController community = TextEditingController();
  String? community;
  @override
  Widget build(BuildContext context) {
    //=====================email input filed ==============================//
    final emailField = TextFormField(
      autofocus: false,
      controller: email,
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        // RegExp regexp = RegExp(r'^.{3,}$');
        if (value!.isEmpty) {
          return ('Email address is required');
        }
        // if (!regexp.hasMatch(value)) {
        //   return ("Restaurant name can't be less than 3 char");
        // }
      },
      onSaved: (value) {
        email.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: const Icon(Icons.email),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "example@gmail.com",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
    );

    //=====================restaurant name input filed ==============================//
    final restaurantNameField = TextFormField(
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
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: const Icon(Icons.house),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: S.of(context).restaurantHintString,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
    );

    //=====================restaurant address input filed ==============================//
    final restaurantAddressField = TextFormField(
      autofocus: false,
      controller: restaurantFullAddress,
      keyboardType: TextInputType.text,
      validator: (value) {
        RegExp regexp = RegExp(r'^.{3,}$');
        if (value!.isEmpty) {
          return ('Restaurant address is required');
        }
        if (!regexp.hasMatch(value)) {
          return ("Restaurant address can't be less than 3 char");
        }
      },
      onSaved: (value) {
        restaurantFullAddress.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: const Icon(Icons.place),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Restaurant full address",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
    );

    //=====================restaurant phone number input field ==============================//
    final restaurantPhoneNumberField = TextFormField(
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
          hintText: "+224(**)-******",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
    );

    //=====================community input filed ==============================//
    // final communityField = TextFormField(
    //   autofocus: false,
    //   controller: dropdownValue as TextEditingController,
    //   keyboardType: TextInputType.text,
    //   validator: (value) {
    //     RegExp regexp = RegExp(r'^.{3,}$');
    //     if (value!.isEmpty) {
    //       return ('Community name is required');
    //     }
    //     if (!regexp.hasMatch(value)) {
    //       return ("Community name can't be less than 3 char");
    //     }
    //   },
    //   onSaved: (value) {
    //     community = value!;
    //   },
    //   textInputAction: TextInputAction.next,
    //   decoration: InputDecoration(
    //       prefixIcon: const Icon(Icons.location_city),
    //       contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
    //       hintText: "Community",
    //       border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
    // );
    // final restaurantFullAddressField = TextFormField(
    //   autofocus: false,
    //   controller: restaurantFullAddress,
    //   keyboardType: TextInputType.text,
    //   validator: (value) {
    //     RegExp regexp = RegExp(r'^.{3,}$');
    //     if (value!.isEmpty) {
    //       return ('Full Address is required');
    //     }
    //     if (!regexp.hasMatch(value)) {
    //       return ("Full addres name can't be less than 3 char");
    //     }
    //   },
    //   onSaved: (value) {
    //     community.text = value!;
    //   },
    //   textInputAction: TextInputAction.next,
    //   decoration: InputDecoration(
    //       prefixIcon: const Icon(Icons.location_city),
    //       contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
    //       hintText: "West Point",
    //       border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
    // );

    //=====================password input filed ==============================//
    final passwordField = TextFormField(
      autofocus: false,
      obscureText: true,
      controller: password,
      keyboardType: TextInputType.visiblePassword,
      validator: (value) {
        RegExp regexp = new RegExp(r'^.{6,}$');
        if (value!.isEmpty) {
          return ('Password is required');
        }

        if (!regexp.hasMatch(value)) {
          return ('Please enter the of six characters');
        }
      },
      onSaved: (value) {
        password.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: const Icon(Icons.key),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: S.of(context).passwordHintString,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
    );

    //=====================password again input filed ==============================//
    final passwordAgainField = TextFormField(
      autofocus: false,
      obscureText: true,
      controller: passwordAgain,
      keyboardType: TextInputType.visiblePassword,
      validator: (value) {
        RegExp regexp = new RegExp(r'^.{6,}$');
        if (value!.isEmpty) {
          return ('Password is required');
        }

        if (!regexp.hasMatch(value)) {
          return ('Please enter the of six characters');
        }

        if (password.text != value) {
          return "Password dosent match";
        }
      },
      onSaved: (value) {
        passwordAgain.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.vpn_key),
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: S.of(context).confirmPasswordString,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );

    final registerButton = RoundedLoadingButton(
      color: Colors.deepOrangeAccent,
      width: MediaQuery.of(context).size.width * 0.90,
      // padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
      // minWidth: MediaQuery.of(context).size.width,
      onPressed: () async {
        var checkPasswordSync = password.text.compareTo(passwordAgain.text);
        if (_formKey.currentState!.validate()) {
          // await _auth
          // .createUserWithEmailAndPassword(email: email, password: password)
          // .then((value) => {
          //       // postDetailsToFirestore()
          //     })
          //   .catchError((e) {
          // Fluttertoast.showToast(msg: e!.messsage);
          //---------------------------------------------------//
          firebaseFunction.SignUpUser(
              context,
              email.text,
              password.text,
              restaurantName.text,
              restaurantFullAddress.text,
              restaurantPhoneNumber.text,
              community!,
              Provider.of<MyProvider>(
                context,
                listen: false,
              ).date,
              signUpButtonController);
          print('hi');
        } else {
          signUpButtonController.reset();
        }

        // if (checkPasswordSync == 0) {
        //
        // }
        // else {
        //   Fluttertoast.showToast(
        //       msg: 'The passwords must match',
        //       toastLength: Toast.LENGTH_LONG,
        //       gravity: ToastGravity.CENTER,
        //       timeInSecForIosWeb: 1,
        //       backgroundColor: Colors.red,
        //       textColor: Colors.white,
        //       fontSize: 20.0);
        // }

        // signUp(email.text, password.text);
      },
      controller: signUpButtonController,
      child: Text(
        S.of(context).signUpButtonString,
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.pink,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
            child: Container(
          color: Colors.white,
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const CircleAvatar(
                  backgroundImage: AssetImage('images/appLogo.png'),
                  backgroundColor: Colors.white,
                  radius: 50,
                ),
                const Text(
                  'BonApp',
                  style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepOrangeAccent,
                      fontFamily: 'pacifico'),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40.0, vertical: 5),
                  child: emailField,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40.0, vertical: 5),
                  child: restaurantNameField,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30.0, vertical: 4),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    decoration: BoxDecoration(
                      // border: Border.all(width: 0, color: Colors.grey),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: StreamBuilder<DocumentSnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('Country')
                          .doc('Guinea')
                          .snapshots(),
                      builder: (context, snapshot) {
                        return snapshot.hasData
                            ? DropdownButtonFormField(
                                hint: Text(S.of(context).chooseCommunity),
                                borderRadius: BorderRadius.circular(8),
                                isExpanded: true,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  prefixIcon: const Icon(
                                    Icons.my_location_sharp,
                                    color: Colors.grey,
                                  ),
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    community = value.toString();
                                  });
                                },
                                value: community,
                                items: [
                                  for (int i = 0;
                                      i <= snapshot.data!['conakry'].length - 1;
                                      ++i)
                                    DropdownMenuItem(
                                      child: Text(
                                        snapshot.data!['conakry'][i],
                                      ),
                                      value: snapshot.data!['conakry'][i],
                                    ),
                                ],
                              )
                            : Container();
                      },
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40.0, vertical: 5),
                  child: restaurantAddressField,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40.0, vertical: 5),
                  child: restaurantPhoneNumberField,
                ),
                Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40.0, vertical: 5),
                    child: DatePickerExample()
                    // : Container(
                    //   height:20,
                    //   width:400,
                    //   child: TextButton(onPressed: () {  }, child: Text('Choose Date'),
                    //
                    //   )
                    // ),
                    ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40.0, vertical: 5),
                  child: passwordField,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40.0, vertical: 5),
                  child: passwordAgainField,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40.0, vertical: 5),
                  child: registerButton,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(S.of(context).alreadyHaveAnAccountString),
                    GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginScreen()));
                        },
                        child: Text(
                          S.of(context).loginButtonString,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: Colors.deepOrangeAccent,
                              decoration: TextDecoration.underline),
                        ))
                  ],
                )
              ],
            ),
          ),
        )),
      ),
    );
  }

  void signUp(String email, String password) async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

    if (_formKey.currentState!.validate()) {
      // await _auth
      // .createUserWithEmailAndPassword(email: email, password: password)
      // .then((value) => {
      //       // postDetailsToFirestore()
      //     })
      //   .catchError((e) {
      // Fluttertoast.showToast(msg: e!.messsage);
    }
  }
}

postDetailsToFirestore() async {
  // call our firestore
  //calling our user modal
  //sending  these values
  // FirebaseFirestore firebaseFirestore = FirebaseFirestore.intance
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  // User? user = _auth.currentUser;

  // UserModel userModel = UserModel();

  //writing all value
  // userModel.email = user!.email;
  // userModel.uid = user!.uid;
  // userModel.name = name as String?;
  // userModel.restaurantAddress = restaurantFullAddress as String?;
  // userModel.restaurantName = restaurantName as String?;
  // userModel.community = community as String?;
  // userModel.restaurantPhoneNumber = restaurantPhoneNumber as String?;

  //   await firebaseFirestore
  //       .collection("Restaurants Database")
  //       .doc(_auth.currentUser?.uid)
  //       .set({
  //         'Email': email,
  //         'Restaurant Name': restaurantName,
  //         'Restaurant Full Address': restaurantFullAddress,
  //         'Phone Number': restaurantPhoneNumber,
  //         'Community': community,
  //       })
  //       .then((value) => {
  //             firebaseFirestore
  //                 .collection('Restaurants Uid')
  //                 .doc(_auth.currentUser!.uid)
  //                 .set({'user id': _auth.currentUser!.uid})
  //           })
  //       .then((value) => {
  //             Navigator.push(context,
  //                 MaterialPageRoute(builder: (context) => const HomeScreen()))
  //           })
  //       .then((value) => {
  //             firebaseFirestore
  //                 .collection('All restaurant profile Pictures')
  //                 .doc(_auth.currentUser!.uid)
  //                 .set({
  //               'location': community,
  //               'restaurant name': restaurantName
  //             })
  //           });
  // }
}

class DatePickerExample extends StatefulWidget {
  // =DateTime(2016, 10, 26);
  DatePickerExample({
    Key? key,
  }) : super(key: key);

  @override
  State<DatePickerExample> createState() => _DatePickerExampleState();
}

class _DatePickerExampleState extends State<DatePickerExample> {
  DateTime date = DateTime(2000, 01, 01);

  DateTime time = DateTime(2016, 5, 10, 22, 35);
  DateTime dateTime = DateTime(2016, 8, 3, 17, 45);

  // This function displays a CupertinoModalPopup with a reasonable fixed height
  // which hosts CupertinoDatePicker.
  void _showDialog(Widget child) {
    showCupertinoModalPopup<void>(
        context: context,
        builder: (BuildContext context) => Container(
              height: 216,
              padding: const EdgeInsets.only(top: 6.0),
              // The Bottom margin is provided to align the popup above the system
              // navigation bar.
              margin: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              // Provide a background color for the popup.
              color: CupertinoColors.systemBackground.resolveFrom(context),
              // Use a SafeArea widget to avoid system overlaps.
              child: SafeArea(
                top: false,
                child: child,
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      // navigationBar: const CupertinoNavigationBar(
      //   middle: Text('CupertinoDatePicker Sample'),
      // ),
      child: DefaultTextStyle(
        style: TextStyle(
          color: CupertinoColors.label.resolveFrom(context),
          fontSize: 22.0,
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _DatePickerItem(
                children: <Widget>[
                  Text(
                    S.of(context).restaurantFoundationDateString,
                    style: const TextStyle(
                      fontSize: 12,
                    ),
                  ),
                  CupertinoButton(
                    // Display a CupertinoDatePicker in date picker mode.
                    onPressed: () => _showDialog(
                      CupertinoDatePicker(
                        initialDateTime: date,
                        mode: CupertinoDatePickerMode.date,
                        use24hFormat: true,
                        // This is called when the user changes the date.
                        onDateTimeChanged: (DateTime newDate) {
                          setState(() {
                            date = newDate;
                            Provider.of<MyProvider>(
                              context,
                              listen: false,
                            ).updateDate(newDate);
                          });
                        },
                      ),
                    ),
                    // In this example, the date is formatted manually. You can
                    // use the intl package to format the value based on the
                    // user's locale settings.
                    child: Text(
                      '${date.month}-${date.day}-${date.year}',
                      style: TextStyle(
                          fontSize: 22.0, color: Colors.grey.shade600),
                    ),
                  ),
                ],
              ),
              // _DatePickerItem(
              //   children: <Widget>[
              //     const Text('Time'),
              //     CupertinoButton(
              //       // Display a CupertinoDatePicker in time picker mode.
              //       onPressed: () => _showDialog(
              //         CupertinoDatePicker(
              //           initialDateTime: time,
              //           mode: CupertinoDatePickerMode.time,
              //           use24hFormat: true,
              //           // This is called when the user changes the time.
              //           onDateTimeChanged: (DateTime newTime) {
              //             setState(() => time = newTime);
              //           },
              //         ),
              //       ),
              //       // In this example, the time value is formatted manually.
              //       // You can use the intl package to format the value based on
              //       // the user's locale settings.
              //       child: Text(
              //         '${time.hour}:${time.minute}',
              //         style: const TextStyle(
              //           fontSize: 22.0,
              //         ),
              //       ),
              //     ),
              //   ],
              // ),
              // _DatePickerItem(
              //   children: <Widget>[
              //     const Text('DateTime'),
              //     CupertinoButton(
              //       // Display a CupertinoDatePicker in dateTime picker mode.
              //       onPressed: () => _showDialog(
              //         CupertinoDatePicker(
              //           initialDateTime: dateTime,
              //           use24hFormat: true,
              //           // This is called when the user changes the dateTime.
              //           onDateTimeChanged: (DateTime newDateTime) {
              //             setState(() => dateTime = newDateTime);
              //           },
              //         ),
              //       ),
              //       // In this example, the time value is formatted manually. You
              //       // can use the intl package to format the value based on the
              //       // user's locale settings.
              //       child: Text(
              //         '${dateTime.month}-${dateTime.day}-${dateTime.year} ${dateTime.hour}:${dateTime.minute}',
              //         style: const TextStyle(
              //           fontSize: 22.0,
              //         ),
              //       ),
              //     ),
              //   ],
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DatePickerItem extends StatelessWidget {
  const _DatePickerItem({required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Colors.grey,
            width: 1.5,
          )
          // Border(
          //   top: BorderSide(
          //     color: CupertinoColors.inactiveGray,
          //     width: 0.0,
          //   ),
          //   bottom: BorderSide(
          //     color: CupertinoColors.inactiveGray,
          //     width: 0.0,
          //   ),
          // ),
          ),
      child: Padding(
        padding: const EdgeInsets.only(left: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: children,
        ),
      ),
    );
  }
}
