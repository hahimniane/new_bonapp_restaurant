import 'package:bonapp_restaurant/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../../Provders/validate_form.dart';
import '../../generated/l10n.dart';
import '../../services/firbase.dart';
import '../../Provders/provider.dart';
import 'login_screen.dart';
import 'dart:io' show Platform;

String? selectedAverageTime;
String? selectedAveragePrice;
final formKey = GlobalKey<FormState>();
final TextEditingController email = TextEditingController();
final TextEditingController password = TextEditingController();
final TextEditingController passwordAgain = TextEditingController();
final TextEditingController restaurantName = TextEditingController();
final TextEditingController restaurantFullAddress = TextEditingController();
final TextEditingController restaurantPhoneNumber = TextEditingController();


Future<Position?> getLocation() async {
  final position;
  LocationPermission permission = await Geolocator.checkPermission();

  if (permission == LocationPermission.denied) {
    await Geolocator.requestPermission();

    return null;
  } else if (permission == LocationPermission.deniedForever) {
    await Geolocator.openLocationSettings();

    return null;
  } else {
    position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    print("latitude = ${position.latitude}");
    print("longitude= ${position.longitude}");

    // addRestaurantLocationToFirebase(
    //     position.latitude.toString(), position.longitude.toString());
    return position;
  }
}
String? community;

class RegistrationScreen extends StatefulWidget {
  final Function updateEmail;
  bool dateErrorVisible;

  RegistrationScreen({
    Key? key,
    required this.updateEmail,
    required this.dateErrorVisible
  }) : super(key: key);

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  late FormValidationProvider _formValidationProvider;

  // void _validateForm() {
  //   if (_formKey.currentState!.validate()) {
  //     widget.updateEmail(email.text);
  //     widget.validate();
  //   }
  // }

  var signUpButtonController = RoundedLoadingButtonController();



  late MyProvider myProvider;

  List<DropdownMenuItem<String>> priceDropdownList = [
    DropdownMenuItem(
      value: '10.000,000',
      child: Text('10.000,000 GNF'),
    ),
    DropdownMenuItem(
      value: '25.000,000',
      child: Text('25.000,000 GNF'),
    ),
    DropdownMenuItem(
      value: '50.000,000',
      child: Text('50.000,000 GNF'),
    ),
    DropdownMenuItem(
      value: '75.000,000',
      child: Text('75.000,000 GNF'),
    ),
    DropdownMenuItem(
      value: '100.000,000',
      child: Text('100.000,000 GNF'),
    ),
  ];

  List<DropdownMenuItem<String>> timeDropdownList = [
    DropdownMenuItem(
      value: '20',
      child: Text('20 Min'),
    ),
    DropdownMenuItem(
      value: '30',
      child: Text('30 Min'),
    ),
    DropdownMenuItem(
      value: '45',
      child: Text('45 Min'),
    ),
    DropdownMenuItem(
      value: '60',
      child: Text('1Hr'),
    ),
    DropdownMenuItem(
      value: '90',
      child: Text('1 hr:30 Min'),
    ),
  ];

  _selectDate() async {
    DateTime? picked;
    if (Theme.of(context).platform == TargetPlatform.iOS) {
      picked = await showModalBottomSheet(
        useSafeArea: true,
        constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.98,
            maxHeight: MediaQuery.of(context).size.height * 0.90),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        context: context,
        builder: (BuildContext context) {
          return Container(
            decoration: BoxDecoration(
              color: Colors.grey,
              // color: Colors.grey,
              borderRadius: BorderRadius.circular(20),
            ),
            height: 400,
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(bottom: 18),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    // color: Colors.purple,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(18)),
                    height: 300,
                    width: MediaQuery.of(context).size.width * 0.90,
                    child: Column(
                      children: [
                        Expanded(
                          child: CupertinoDatePicker(
                            mode: CupertinoDatePickerMode.date,
                            initialDateTime: DateTime.now(),
                            onDateTimeChanged: (DateTime newDateTime) {
                              setState(() {
                                Provider.of<MyProvider>(
                                  context,
                                  listen: false,
                                ).updateDate(newDateTime);
                              });
                            },
                          ),
                        ),
                        Divider(
                          height: 5,
                          thickness: 1,
                        ),
                        Container(
                          decoration: BoxDecoration(

                              // borderRadius: BorderRadius.circular(15)
                              ),
                          width: MediaQuery.of(context).size.width,
                          child: TextButton(
                            child: Text(
                              "OK",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 23,
                                  color: Colors.blue),
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            style: TextButton.styleFrom(
                              // backgroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(bottom: 10),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20.0)),
                  width: MediaQuery.of(context).size.width * 0.93,
                  height: 60,
                  child: TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Center(
                      child: Text("Cancel",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue)),
                    ),
                  ),
                )
              ],
            ),
          );
        },
      );
    } else {
      picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1900),
        lastDate: DateTime(2100),
      );
    }
    return picked;
  }

  addRestaurantLocationToFirebase(String latitude, String longitude) {
    FirebaseFirestore.instance
        .collection('Restaurants')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .set({
      'latitude': latitude,
      'longitude': longitude,
    }, SetOptions(merge: true));
  }



  List<String> myList = [];
  List<String> cities = [];

  @override
  void initState() {
    getLocation();
    super.initState();
  }

  FirebaseAuthentications firebaseFunction = FirebaseAuthentications();

  // from key


  final _auth = FirebaseAuth.instance;

  //editing controller


  // final TextEditingController community = TextEditingController();



  @override
  Widget build(BuildContext context) {
    //=====================email input filed ==============================//
    final emailField = TextFormField(
      onChanged: (value) {
        print('the value is $value');
        widget.updateEmail(value);
      },
      autofocus: false,
      controller: email,
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        // RegExp regexp = RegExp(r'^.{3,}$');
        if (value!.isEmpty) {
          return (S.of(context).emailAddressIsRequired);
        }
        // if (!regexp.hasMatch(value)) {
        //   return ("Restaurant name can't be less than 3 char");
        // }
      },
      onSaved: (value) {
        widget.updateEmail(value);
        email.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: const Icon(Icons.email),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "example@gmail.com",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
    );

    final restaurantCommunity = FormField<String>(
      builder: (FormFieldState<String> state) {
        return StreamBuilder<DocumentSnapshot>(
            stream: FirebaseFirestore.instance
                .collection('Country')
                .doc('Guinea')
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Container(
                  child: CircularProgressIndicator(),
                );
              }
              return Column(
                children: <Widget>[
                  DropdownButtonFormField(
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
                      state.didChange(value as String?);
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
                  ),
                  if (state.hasError)
                    Container(
                      padding: const EdgeInsets.fromLTRB(16, 10, 20, 0),
                      alignment: Alignment.topLeft,
                      decoration: BoxDecoration(

                          // color: Colors.red[100],
                          // borderRadius: BorderRadius.circular(5),
                          ),
                      child: Text(
                        state.errorText!,
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 14,
                        ),
                      ),
                    ),
                ],
              );
            });
      },
      validator: (community) {
        if (community == null || community.isEmpty) {
          return (S.of(context).communitySelectionIsRequired);
        }
        return null;
      },
      onSaved: (value) {
        community = value!;
      },
    );

    //=====================restaurant name input filed ==============================//
    final restaurantNameField = TextFormField(
      autofocus: false,
      controller: restaurantName,
      keyboardType: TextInputType.text,
      validator: (value) {
        RegExp regexp = RegExp(r'^.{3,}$');
        if (value!.isEmpty) {
          return (S.of(context).restaurantNameIsRequired);
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
          return (S.of(context).restaurantFullAddressIsRequired);
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
          hintText: S.of(context).restaurantFullAddressString,
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
          return (S.of(context).phoneNumberIsRequired);
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
          return (S.of(context).passwordIsRequired);
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
          return (S.of(context).confirmPasswordIsRequired);
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
        if (Provider.of<MyProvider>(context, listen: false).date == null) {
          setState(() {
            // print('The date variable is ${Provider.of<MyProvider>(context,listen: false).date}');
           widget. dateErrorVisible = true;
          });
        } else {
          setState(() {
            widget. dateErrorVisible = false;
            // print('The date variable is ${Provider.of<MyProvider>(context,listen: false).date}');
          });
        }
        var checkPasswordSync = password.text.compareTo(passwordAgain.text);

        if (formKey.currentState!.validate() &&
            Provider.of<MyProvider>(context, listen: false).date != null) {
          //---------------------------------------------------//
          // firebaseFunction.SignUpUser(
          //      context: context,
          //   email:  email.text,
          //   password:  password.text,
          //   userName:  restaurantName.text,
          //    fullAddress: restaurantFullAddress.text,
          //   phoneNumber:  restaurantPhoneNumber.text,
          //   community:  community!,
          //  restaurantFoundationDate:   Provider.of<MyProvider>(
          //       context,
          //       listen: false,
          //     ).date,
          //   controller:  signUpButtonController,
          //   position: await getLocation()
          //
          // );
        } else {
          signUpButtonController.reset();
        }
      },
      controller: signUpButtonController,
      child: Text(
        'Next',
        // S.of(context).signUpButtonString,
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
      ),
    );

    return  SingleChildScrollView(
          child: Container(
        color: Colors.white,
        child: Form(
          key: formKey,
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              // const CircleAvatar(
              //   backgroundImage: AssetImage('images/appLogo.png'),
              //   backgroundColor: Colors.white,
              //   radius: 50,
              // ),
              // const Text(
              //   'BonApp',
              //   style: TextStyle(
              //       fontSize: 40,
              //       fontWeight: FontWeight.bold,
              //       color: Colors.deepOrangeAccent,
              //       fontFamily: 'pacifico'),
              // ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 0.0, vertical: 5),
                child: emailField,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 0.6, vertical: 5),
                child: restaurantNameField,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 0.0, vertical: 4),
                child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    decoration: BoxDecoration(
                      // border: Border.all(width: 0, color: Colors.grey),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: restaurantCommunity),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 4, vertical: 5),
                child: restaurantAddressField,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 6, vertical: 5),
                child: restaurantPhoneNumberField,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 6, vertical: 5),
                child: DatePicker(),
              ),
              Visibility(
                visible: widget.dateErrorVisible,
                child: Container(
                  padding: const EdgeInsets.fromLTRB(55, 0, 20, 0),
                  alignment: Alignment.topLeft,
                  decoration: BoxDecoration(

                      // color: Colors.red[100],
                      // borderRadius: BorderRadius.circular(5),
                      ),
                  child: Text(
                    'choose date',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                child: passwordField,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                child: passwordAgainField,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                child: AverageSelector(
                  hintText: S.of(context).chooseAveragePrice,
                  icon: Icon(Icons.money),
                  dropdownMenuItems: priceDropdownList,
                  valueToUpdate: 'price',
                ),
              ),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                child: AverageSelector(
                  hintText: S.of(context).chooseAverageTime,
                  icon: Icon(Icons.timelapse),
                  dropdownMenuItems: timeDropdownList,
                  valueToUpdate: 'time',
                ),
              ),



              // Row(
              //   mainAxisAlignment: MainAxisAlignment.end,
              //   children: [
              //     Padding(
              //       padding: const EdgeInsets.symmetric(
              //           horizontal: 0.0, vertical: 5),
              //       child: TextButton(
              //         style: TextButton.styleFrom(
              //             shape: RoundedRectangleBorder(
              //                 borderRadius: BorderRadius.circular(10)),
              //             backgroundColor: Colors.deepOrange,
              //             elevation: 1),
              //         onPressed:  (){
              //           if (Provider.of<MyProvider>(context, listen: false).date == null) {
              //             setState(() {
              //               // print('The date variable is ${Provider.of<MyProvider>(context,listen: false).date}');
              //               dateErrorVisible = true;
              //             });
              //           } else {
              //             setState(() {
              //               dateErrorVisible = false;
              //               // print('The date variable is ${Provider.of<MyProvider>(context,listen: false).date}');
              //             });
              //           }
              //           var checkPasswordSync = password.text.compareTo(passwordAgain.text);
              //
              //           if (_formKey.currentState!.validate() &&
              //               Provider.of<MyProvider>(context, listen: false).date != null) {
              //             //---------------------------------------------------//
              //             // firebaseFunction.SignUpUser(
              //             //      context: context,
              //             //   email:  email.text,
              //             //   password:  password.text,
              //             //   userName:  restaurantName.text,
              //             //    fullAddress: restaurantFullAddress.text,
              //             //   phoneNumber:  restaurantPhoneNumber.text,
              //             //   community:  community!,
              //             //  restaurantFoundationDate:   Provider.of<MyProvider>(
              //             //       context,
              //             //       listen: false,
              //             //     ).date,
              //             //   controller:  signUpButtonController,
              //             //   position: await getLocation()
              //             //
              //             // );
              //           } else {
              //             signUpButtonController.reset();
              //           }
              //          print('selected average time $selectedAverageTime');
              //           print('selected average Price $selectedAveragePrice');
              //         },
              //         child: Text(
              //           'Next',
              //           style: TextStyle(
              //               fontWeight: FontWeight.bold, color: Colors.white),
              //         ),
              //       ),
              //     ),
              //   ],
              // ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     Text(S.of(context).alreadyHaveAnAccountString),
              //     GestureDetector(
              //         onTap: () {
              //           Navigator.push(
              //               context,
              //               MaterialPageRoute(
              //                   builder: (context) => LoginScreen()));
              //         },
              //         child: Text(
              //           S.of(context).loginButtonString,
              //           style: TextStyle(
              //               fontWeight: FontWeight.bold,
              //               fontSize: 15,
              //               color: Colors.deepOrangeAccent,
              //               decoration: TextDecoration.underline),
              //         ))
              //   ],
              // )
            ],
          ),
        ),
      ));

  }

  void signUp(String email, String password) async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

    if (formKey.currentState!.validate()) {
      // await _auth
      // .createUserWithEmailAndPassword(email: email, password: password)
      // .then((value) => {
      //       // postDetailsToFirestore()
      //     })
      //   .catchError((e) {
      // Fluttertoast.showToast(msg: e!.messsage);
    }
  }

  // FormValidationProvider? _formValidationProvider;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    myProvider = Provider.of<MyProvider>(context, listen: false);
    // _formValidationProvider.initializeFormKey(formKey);
  }

  @override
  void dispose() {
    super.dispose();
    restaurantFullAddress.clear();
    restaurantName.clear();
    community=null;
    restaurantPhoneNumber.clear();
    selectedAveragePrice=null;
    selectedAverageTime=null;

    email.clear();
    password.clear();
    passwordAgain.clear();

    myProvider.date = null;
  }
}

class AverageSelector extends StatefulWidget {
  String hintText;
  Icon icon;
  List<DropdownMenuItem<String>> dropdownMenuItems;
  String valueToUpdate;

  AverageSelector({
    Key? key,
    required this.hintText,
    required this.icon,
    required this.dropdownMenuItems,
    required this.valueToUpdate,
  }) : super(key: key);

  @override
  State<AverageSelector> createState() => _AverageSelectorState();
}

class _AverageSelectorState extends State<AverageSelector> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.green,
      height: 56,
      child: Align(
        alignment: Alignment.center,
        child: DropdownButtonFormField(
          isExpanded: true,
          validator: (String? value) {
            if (value == null || value.isEmpty) {
              return (widget.valueToUpdate.toLowerCase() == 'time'
                  ? S.of(context).averageTimeIsRequired
                  : S.of(context).averagePriceIsRequired);
            }
            return null;
          },
          onSaved: (value) {
            if (widget.valueToUpdate.toLowerCase() == 'time') {
              setState(() {
                selectedAverageTime = value as String?;
                print('the value is $value');
              });
            } else {
              setState(() {
                selectedAveragePrice = value as String?;
              });
            }
          },
          decoration: InputDecoration(
            contentPadding: EdgeInsets.only(bottom: 15),
            // errorText: 'error',
            hintText: widget.hintText,
            prefixIcon: widget.icon,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          items: widget.dropdownMenuItems,
          onChanged: (value) {
            setState(() {
              if (widget.valueToUpdate.toLowerCase() == 'time') {
                selectedAverageTime = value as String?;
              } else {
                selectedAveragePrice = value as String?;
              }
            });
          },
        ),
      ),
    );
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

class DatePicker extends StatefulWidget {
  // =DateTime(2016, 10, 26);
  DatePicker({
    Key? key,
  }) : super(key: key);

  @override
  State<DatePicker> createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  DateTime? date;

  // DateTime(2000, 01, 01);

  DateTime time = DateTime(2016, 5, 10, 22, 35);
  DateTime dateTime = DateTime(2016, 8, 3, 17, 45);

  Future<DateTime?> _selectDate() async {
    DateTime? picked;
    if (Theme.of(context).platform == TargetPlatform.iOS) {
      picked = await showModalBottomSheet(
        useSafeArea: true,
        constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.98,
            maxHeight: MediaQuery.of(context).size.height * 0.90),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        context: context,
        builder: (BuildContext context) {
          return Container(
            decoration: BoxDecoration(
              color: Colors.grey,
              // color: Colors.grey,
              borderRadius: BorderRadius.circular(20),
            ),
            height: 400,
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(bottom: 18),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    // color: Colors.purple,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(18)),
                    height: 300,
                    width: MediaQuery.of(context).size.width * 0.90,
                    child: Column(
                      children: [
                        Expanded(
                          child: CupertinoDatePicker(
                            mode: CupertinoDatePickerMode.date,
                            initialDateTime: DateTime.now(),
                            maximumDate: DateTime.now(),
                            onDateTimeChanged: (DateTime newDateTime) {
                              setState(() {
                                date = newDateTime;
                                picked = newDateTime;
                                Provider.of<MyProvider>(context, listen: false)
                                    .updateDate(newDateTime);
                              });
                            },
                          ),
                        ),
                        Divider(
                          height: 5,
                          thickness: 1,
                        ),
                        Container(
                          decoration: BoxDecoration(

                              // borderRadius: BorderRadius.circular(15)
                              ),
                          width: MediaQuery.of(context).size.width,
                          child: TextButton(
                            child: Text(
                              "OK",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 23,
                                  color: Colors.blue),
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            style: TextButton.styleFrom(
                              // backgroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),


                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(bottom: 5),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20.0)),
                    width: MediaQuery.of(context).size.width * 0.93,
                    height: 60,
                    child: TextButton(
                      onPressed: () {
                 Navigator.pop(context);
                      },
                      child: Center(
                        child: Text("Cancel",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue)),
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
        },
      );
    } else {
      DateTime? selectedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1900),
        lastDate: DateTime.now(),
      );

      if (selectedDate != null) {
        setState(() {
          date = selectedDate;
          Provider.of<MyProvider>(context, listen: false)
              .updateDate(selectedDate);
        });
      }
    }
    return picked;
  }

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
                  Expanded(
                    child: Text(
                      S.of(context).restaurantFoundationDateString,
                      style: const TextStyle(
                        fontSize: 12,
                      ),
                    ),
                  ),
                  CupertinoButton(
                    // Display a CupertinoDatePicker in date picker mode.
                    onPressed: () => _selectDate(),
                    child: Text(
                      '${date?.month ?? '01'}-${date?.day ?? '01'}-${date?.year ?? '2000'}',
                      style: TextStyle(
                          fontSize: 21.0, color: Colors.grey.shade600),
                    ),
                  ),
                ],
              ),
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
          )),
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
