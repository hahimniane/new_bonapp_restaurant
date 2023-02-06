import 'dart:async';
import 'package:intl/intl.dart';

import 'package:bonapp_restaurant/Provders/calculate_price_provider.dart';
import 'package:bonapp_restaurant/services/calling_bike.dart';
import 'package:bonapp_restaurant/services/firbase.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'From_Sulaiman/screens/login_screen.dart';
import 'Models/calculate_price.dart';
import 'Utils/fluttertoast.dart';
import 'generated/l10n.dart';
import 'dart:developer' as dev;

List<String> dropdownMenuItems = ['1', '2', '3', '4', '5'];

class ExceptionalHomeScreen extends StatefulWidget {
  const ExceptionalHomeScreen({Key? key}) : super(key: key);

  @override
  State<ExceptionalHomeScreen> createState() => _ExceptionalHomeScreenState();
}

class _ExceptionalHomeScreenState extends State<ExceptionalHomeScreen> {
  late int numberOfDestinations = 1;
  late int currentValue = 1;
  late Row field;

  var _isVisible = false;

  var firstController = TextEditingController();

  var fistVisibility = true;

  var call_bike_button_controller = RoundedLoadingButtonController();

  String _selectedValue = '';

  num? result = 1;

  String selectedValue = '';

  num? totalPrice = 0;

  // fieldFunction(BuildContext context, [controller]) {
  //   TextEditingController firstController = TextEditingController();
  //
  //   setState(() {
  //     _controllers.add(firstController);
  //     _fields.add(field);
  //   });
  // }

  Widget _listView() {
    if (_fields.isEmpty) {
      return Container(
        color: Colors.yellow,
      );
    } else {
      return SizedBox(
        height: _fields.length * 80,
        child: Column(
          children: _fields,
        ),

        // child: ListView.builder(
        //   controller: _scrolController,
        //   itemCount: _fields.length,
        //   itemBuilder: (context, index) {
        //     if (index == _fields.length) {
        //       return Container(
        //         height: 5,
        //       );
        //     }
        //     return Container(
        //       margin: EdgeInsets.all(5),
        //       child: _fields[index],
        //     );
        //   },
        // ),
      );
    }
  }

  final List<TextEditingController> _controllers = [];
  final List<Row> _fields = [];
  FirebaseAuthentications firbaseFunctions = FirebaseAuthentications();

  var dropdownValue = dropdownMenuItems.first;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: const Text('BonApp'),
        actions: [
          ElevatedButton(
            child: const Icon(
              Icons.logout,
            ),
            onPressed: () {
              try {
                showDialog(
                  context: context,
                  builder: (BuildContext context) =>
                      _buildPopupDialogLogout(context),
                );
              } on FirebaseException catch (e) {
                Fluttertoast.showToast(msg: e.code);
              }
              // firbaseFunctions.logoutUser(context);
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => LoginScreen(),
              //   ),
              // );
            },
          )
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    S.of(context).howManyOrdersToDeliver,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Center(
                  child: Card(
                    color: Colors.deepOrangeAccent,
                    elevation: 1,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 50.0),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          dropdownColor: Colors.black.withOpacity(0.7),
                          value: dropdownValue,
                          icon: const Icon(
                            Icons.arrow_drop_down,
                            size: 25,
                            color: Colors.white,
                          ),
                          elevation: 16,
                          style: TextStyle(color: Colors.grey.shade800),
                          onChanged: (String? value) {
                            setState(() {
                              saveToSharedPrefrences();

                              // dev.debugger(when: true);
                              getPrefrences();
                            });
                            // for (int i = 0; i < allPricesForAll.length; ++i) {
                            //   print(
                            //       'the element at index $i is ${allPricesForAll[i]}');
                            // }
                            // var controller = TextEditingController();

                            // This is called when the user selects an item.
                            numberOfDestinations = int.parse(value!);

                            setState(() {
                              totalPrice = 0;
                              if (numberOfDestinations == 1) {
                                //if  numberOfDestinations is equal to 1 the destination String is going to be shown and firstVisibility bool is going to be true;
                                setState(() {
                                  // print(
                                  //     'number of destinations should be one but it is $numberOfDestinations');
                                  fistVisibility = true;

                                  _isVisible = false;
                                  // print('first visibitlity is $fistVisibility');
                                });
                              }
                              // either way the first
                              // fistVisibility = false;
                              if (numberOfDestinations > 1) {
                                _isVisible = true;
                                fistVisibility = false;
                                firstController.clear();
                              }
                              // _controllers.add(controller);
                              currentValue = 1;
                              // firstController.clear();

                              _fields.clear();
                              _controllers.clear();

                              for (int i = 0; i < numberOfDestinations; ++i) {
                                // fistVisibility = false;
                                var controller = TextEditingController();
                                VoidCallback textFieldFunction;
                                final field = Row(
                                  children: [
                                    Expanded(
                                      flex: (MediaQuery.of(context).size.width *
                                              0.90)
                                          .round(),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: TypeAheadField(
                                          hideKeyboard: true,
                                          textFieldConfiguration:
                                              TextFieldConfiguration(
                                            // enabled: false,

                                            controller: controller,
                                            decoration: InputDecoration(
                                              // labelText: 'Mali',
                                              label: LableForTextField(
                                                indexOfThisField: i,
                                                result: result,
                                                controller: controller,
                                                selectedValue: selectedValue,
                                              ),
                                              suffixIcon: GestureDetector(
                                                  onTap: () async {
                                                    if (controller
                                                        .text.isNotEmpty) {
                                                      var price =
                                                          await getPriceFromPrefrences(
                                                              i);
                                                      if (price != null) {
                                                        setState(() {
                                                          totalPrice =
                                                              totalPrice! -
                                                                  price;
                                                        });
                                                      }

                                                      controller.clear();
                                                    }
                                                  },
                                                  child: Icon(Icons.cancel)),
                                              hintText: S
                                                  .of(context)
                                                  .enterDestinationString,
                                              prefixIcon: const Icon(
                                                FontAwesomeIcons.city,
                                                color: Colors.grey,
                                                size: 18,
                                              ),
                                              border: OutlineInputBorder(
                                                borderSide: const BorderSide(
                                                  color: Colors
                                                      .grey, //this has no effect
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                              ),
                                            ),
                                          ),
                                          suggestionsCallback: (pattern) async {
                                            return await _getSuggestions(
                                                pattern);
                                          },
                                          itemBuilder: (context, suggestion) {
                                            CalculatePrice priceCalcualator =
                                                CalculatePrice();
                                            return FutureBuilder<num>(
                                                future: priceCalcualator
                                                    .calculatePrice(suggestion),
                                                builder: (context, snapshot) {
                                                  return snapshot.data != 0
                                                      ? ListTile(
                                                          // tileColor: Colors.blue,
                                                          title: Text(
                                                          suggestion
                                                                  .toString() +
                                                              ' ${snapshot.data} GNF',
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ))
                                                      : SizedBox(height: 0);
                                                });
                                          },
                                          transitionBuilder: (context,
                                              suggestionsBox, controller) {
                                            return suggestionsBox;
                                          },
                                          onSuggestionSelected:
                                              (String suggestion) async {
                                            // print(
                                            //     'just insdde the selected ${allPricesForAll.length}');
                                            setState(() {
                                              selectedValue = suggestion;
                                              controller.text = suggestion;
                                              Provider.of<CalculatePriceProvider>(
                                                      context,
                                                      listen: false)
                                                  .updatePrice(i, suggestion);
                                            });

                                            CalculatePrice calculate =
                                                CalculatePrice();

                                            num data = await calculate
                                                .calculatePrice(suggestion);
                                            setPrefrencesOfASingleConttoller(
                                                i, data.toInt());

                                            setState(() {
                                              // dev.debugger(when: true);
                                              // allPricesForAll[0] = data;
                                              // print('new data has been added');
                                              // for (int i = 0;
                                              //     i < numberOfDestinations;
                                              //     ++i) {
                                              //   allPricesForAll.add(0);
                                              // }

                                              result = data;

                                              selectedValue = result.toString();

                                              totalPrice = (totalPrice! + data);

                                              // print(
                                              //     'the state was called and the price is $result');
                                            });
                                            print(
                                                'the total price is  $totalPrice');
                                            controller.text =
                                                suggestion.toString();
                                            _selectedValue =
                                                suggestion.toString();
                                            suggestion.toString();
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                                _fields.add(field);
                                _controllers.add(controller);

                                currentValue++;
                              }
                              print(
                                  'the number of controllers available ${_controllers.length}');
                              dropdownValue = value;
                            });
                          },
                          items: dropdownMenuItems
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  value,
                                  style: const TextStyle(
                                      // backgroundColor: Colors.deepOrangeAccent,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ),
                ),
                Visibility(
                  visible: fistVisibility,
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      S.of(context).destinationString,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                fistVisibility
                    ? Visibility(
                        visible: fistVisibility,
                        child: Row(
                          children: [
                            Expanded(
                              flex: (MediaQuery.of(context).size.width * 0.90)
                                  .round(),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TypeAheadField(
                                  keepSuggestionsOnSuggestionSelected: false,
                                  hideKeyboard: true,
                                  textFieldConfiguration:
                                      TextFieldConfiguration(
                                    // enabled: false,

                                    controller: firstController,
                                    decoration: InputDecoration(
                                      // labelText: 'Mali',
                                      label: StreamBuilder<DocumentSnapshot>(
                                          stream: FirebaseFirestore.instance
                                              .collection('Restaurants')
                                              .doc(FirebaseAuth
                                                  .instance.currentUser!.uid)
                                              .snapshots(),
                                          builder: (context, snapshot) {
                                            if (!snapshot.hasData) {
                                              return CircularProgressIndicator();
                                            }
                                            return Row(
                                              children: [
                                                Text(
                                                  snapshot.data!['Community'],
                                                  style: TextStyle(
                                                    color: Colors.redAccent,
                                                  ),
                                                ),
                                                SizedBox(width: 5),
                                                Icon(Icons
                                                    .arrow_right_alt_outlined),
                                                // Icon(Icons.home),
                                                SizedBox(width: 5),

                                                (result == 0)
                                                    ? Text('no delivery')
                                                    : (result == 1)
                                                        ? Text('?')
                                                        : Text(
                                                            firstController
                                                                .text,
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold)),
                                              ],
                                            );
                                          }),
                                      suffixIcon: GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              firstController.clear();
                                              _selectedValue = '';
                                              // print(
                                              //     'the selected value is $_selectedValue');
                                            });
                                          },
                                          child: Icon(Icons.cancel)),
                                      hintText:
                                          S.of(context).enterDestinationString,
                                      prefixIcon: const Icon(
                                        FontAwesomeIcons.city,
                                        color: Colors.grey,
                                        size: 18,
                                      ),
                                      border: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color:
                                              Colors.grey, //this has no effect
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                    ),
                                  ),
                                  suggestionsCallback: (pattern) async {
                                    return await _getSuggestions(pattern);
                                  },
                                  itemBuilder: (context, suggestion) {
                                    CalculatePrice priceCalcualator =
                                        CalculatePrice();
                                    // var result = await priceCalcualator
                                    //     .calculatePrice(pattern[]);

                                    return FutureBuilder<num>(
                                        future: priceCalcualator
                                            .calculatePrice(suggestion),
                                        builder: (context, snapshot) {
                                          return snapshot.data != 0
                                              ? ListTile(
                                                  // tileColor: Colors.blue,
                                                  title: Text(
                                                  suggestion.toString() +
                                                      ' ${snapshot.data} GNF',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ))
                                              : SizedBox(height: 0);
                                        });
                                  },
                                  transitionBuilder:
                                      (context, suggestionsBox, controller) {
                                    return suggestionsBox;
                                  },
                                  onSuggestionSelected:
                                      (String suggestion) async {
                                    firstController.text =
                                        suggestion.toString();

                                    // print(
                                    //     'the first controller value is${firstController.text}');
                                    CalculatePrice calculate = CalculatePrice();

                                    num data = await calculate
                                        .calculatePrice(suggestion);
                                    // Timer.periodic(Duration(seconds: 1),
                                    //     (timer) {
                                    //   calculate = CalculatePrice();
                                    //   // Provider.of<CalculatePriceProvider>(
                                    //   //         context,
                                    //   //         listen: false)
                                    //   //     .updatePrice(data);
                                    // });
                                    //
                                    // Provider.of<CalculatePriceProvider>(context,
                                    //         listen: false)
                                    //     .updatePrice(data);

                                    // result =
                                    //     await calculate.calculatePrice(firstController);
                                    setState(() {
                                      result = data;
                                      // print(
                                      //     'the state was called and the price is $result');
                                    });

                                    firstController.text =
                                        suggestion.toString();
                                    _selectedValue = suggestion.toString();
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    : SizedBox(),
                Visibility(
                  visible: _isVisible,
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      S.of(context).destinationString,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Visibility(visible: _isVisible, child: _listView()),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: (result == 0)
                        ? MainAxisAlignment.center
                        : (result == 1)
                            ? MainAxisAlignment.spaceBetween
                            : MainAxisAlignment.spaceBetween,
                    children: [
                      Visibility(
                        visible: (result == 0)
                            ? false
                            : (result == 1)
                                ? true
                                : true,
                        child: Text(S.of(context).theTotalPriceStrint,
                            style: TextStyle(fontWeight: FontWeight.w600)),
                      ),
                      firstController.text.isNotEmpty
                          ? Text(
                              (result == 0)
                                  ? "Sorry, we can't deliver"
                                  : (result == 1)
                                      ? "0 GNF"
                                      : result.toString() + ' GNF',
                              style: TextStyle(
                                fontWeight: FontWeight.w800,
                              ),
                            )
                          : Text(
                              (result == 0)
                                  ? "Sorry, we can't deliver"
                                  : (result == 1)
                                      ? NumberFormat.currency(
                                              locale: 'eu', symbol: 'GNF')
                                          .format(0)
                                      : NumberFormat.currency(
                                              locale: 'eu', symbol: 'GNF')
                                          .format(totalPrice)

                              // totalPrice.toString() + ' GNF'

                              ,
                              style: TextStyle(
                                fontWeight: FontWeight.w800,
                              ),
                            )
                    ],
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                RoundedLoadingButton(
                    width: MediaQuery.of(context).size.width * 0.80,
                    color: Colors.deepOrangeAccent,
                    controller: call_bike_button_controller,
                    onPressed: () async {
                      final callBike = CallBike();
                      if (firstController.text.isNotEmpty) {
                        callBike.callABike(
                            destinationControllerList: _controllers,
                            rejectByTheRestaurant: false,
                            isDelivered: false,
                            canTheRestaurantRequestNewBike: false,
                            hasBikeCome: false,
                            bikeIsCalled: '1',
                            isBikeAssigned: false,
                            pendingOrderDocument: '1',
                            controller: firstController,
                            numberOfDestination: 1,
                            doesItStartWithADigit: true,
                            context: context,
                            buttonController: call_bike_button_controller);
                      } else if (_controllers.isNotEmpty) {
                        // dev.debugger(when: true);
                        // print(_controllers.length);
                        callBike.callABike(
                            controller: firstController,
                            destinationControllerList: _controllers,
                            rejectByTheRestaurant: false,
                            isDelivered: false,
                            canTheRestaurantRequestNewBike: false,
                            hasBikeCome: false,
                            bikeIsCalled: '1',
                            isBikeAssigned: false,
                            pendingOrderDocument: '1',
                            numberOfDestination: 1,
                            doesItStartWithADigit: true,
                            context: context,
                            buttonController: call_bike_button_controller);
                      } else {
                        // print(
                        //     'both the first controller and the list of controllers are empth');
                        openFlutterToast(
                            context: context,
                            errorMessage:
                                S.of(context).pleaseFillIntheDestinationString);
                        call_bike_button_controller.error();
                        await Future.delayed(Duration(milliseconds: 500));
                        call_bike_button_controller.reset();
                      }
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.bike_scooter,
                          size: 30,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Text(S.of(context).callBikeButton,
                            style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.white)),
                      ],
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }

  StreamSubscription? myStream;
  checkIfCanRequestBike() async {
    print('it entered here');
    // dev.debugger(when: true);
    CallBike callBike = CallBike();
    bool result = await callBike.checkIfACollectionIsEmpty(
        collectionName: 'Pending Orders');
    if (!result) {
      bool isThereDigitOrders =
          await callBike.checkIfCollectionContainsDigitOrders('Pending Orders');
      if (isThereDigitOrders) {
        int docId = await callBike.getHighestDocDigit();
        if (docId != 0) {
          bool itCanRequest = await callBike.getAVariableInsedADocument(
              documentId: docId.toString(),
              fieldName: 'can request a new bike');
          if (!itCanRequest) {
            setState(() {
              call_bike_button_controller.error();
            });
            // dev.debugger(when: true);
            myStream = FirebaseFirestore.instance
                .collection('Restaurants')
                .doc(FirebaseAuth.instance.currentUser!.uid)
                .collection("Pending Orders")
                .doc(docId.toString())
                .snapshots()
                .listen((event) {
              print('the event is ${event['can request a new bike']}');
              if (event['can request a new bike'] == true) {
                setState(() {
                  call_bike_button_controller.reset();
                });
              }
              // setState(() {
              //   // call_bike_button_controller.reset();
              // });
            });
          }
        }
      }
    }
  }

  @override
  void initState() {
    checkIfCanRequestBike();
  }

  @override
  void dispose() {
    var single = CallBike.newDocumentStreamForSingleDocumentRegistration;

    CallBike.newDocumentStreamForSingleDocumentRegistration
        ?.cancel()
        .then((value) => {print('canceld single subscription')});
    CallBike.newDocumentStreamForMultipleDocumentRegistration
        ?.cancel()
        .then((value) => {print('canceld Multiple subscription')});

    super.dispose();
    print('subscription cancelled');
    myStream?.cancel();
  }

  Widget _buildPopupDialogLogout(BuildContext context) {
    return AlertDialog(
      title: const Text(
        'Êtes-vous sûr de vouloir vous déconnecter?',
        style: TextStyle(
          fontSize: 14,
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        // children: <Widget>[
        //   Text("He"),
        // ],
      ),
      actions: <Widget>[
        ElevatedButton(
          onPressed: () {
            FirebaseAuth.instance.signOut().then((value) => {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoginScreen())),
                });
          },
          // : Theme.of(context).primaryColor,
          child: Text(S.of(context).logOuntString),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          style: ElevatedButton.styleFrom(backgroundColor: Colors.green),

          // : Theme.of(context).primaryColor,
          child: Text(S.of(context).cancelString),
        ),
      ],
    );
  }

  Future<List<String>> _getSuggestions(String pattern) async {
    DocumentSnapshot result = await FirebaseFirestore.instance
        .collection('Country')
        .doc('Guinea')
        .get();

    List<String> myList = List.from(result['conakry']);
    List<String> sortedList = sortAlphabetically(myList);

    print(result['conakry'].runtimeType);

    return sortedList.where((s) => s.contains(pattern.toUpperCase())).toList();
  }

  List<String> sortAlphabetically(List<String> list) {
    // Sort the list in ascending order
    list.sort();
    return list;
  }

  void saveToSharedPrefrences() {
    for (int i = 0; i < 5; ++i) {
      final prefs = SharedPreferences.getInstance();
      prefs.then((value) => {value.setInt('index$i', 0)});
    }
  }

  getPrefrences() {
    var theValue;
    for (int i = 0; i < 5; ++i) {
      final prefs = SharedPreferences.getInstance();
      prefs.then((value) => {print(value.getInt('index $i'))});
    }
  }

  void setPrefrencesOfASingleConttoller(id, int price) {
    final prefs = SharedPreferences.getInstance();
    prefs.then((value) => {
          value.setInt('index$id', price),
          print(
              'the price has been set at index $id and value is ${value.get('index$id')}')
        });
  }

  Future<int?> getPriceFromPrefrences(int index) async {
    var pref = await SharedPreferences.getInstance();
    int? theData = pref.getInt('index$index');
    if (theData != null) {
      return theData;
    } else {
      return null;
    }
  }
}

class LableForTextField extends StatelessWidget {
  LableForTextField(
      {Key? key,
      required this.result,
      required this.controller,
      required this.selectedValue,
      required this.indexOfThisField})
      : super(key: key);

  final num? result;
  TextEditingController controller;

  String selectedValue;
  int indexOfThisField;
  // pr() {
  //   print('the controller in here is ${controller.text}');
  // }

  @override
  Widget build(BuildContext context) {
    // pr();
    return StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('Restaurants')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return CircularProgressIndicator();
          }
          return Row(
            children: [
              Text(
                snapshot.data!['Community'],
                style: TextStyle(
                  color: Colors.redAccent,
                ),
              ),
              SizedBox(width: 5),
              Icon(Icons.arrow_right_alt_outlined),

              // Icon(Icons.home),
              // SizedBox(width: 5),
              // ElevatedButton(
              //     onPressed: () {
              //       print(' the controller is ${controller.text}');
              //     },
              //     child: Text('Text')),
              // Text(Provider.of<CalculatePriceProvider>(context, listen: false)
              //     .locationsToDeliver[indexOfThisField]),
              // Text('30000 GNF')

              // (result == 0)
              //     ? Text('no delivery')
              //     : (result == 1)
              //         ? Text('?')
              //         : Text(
              //             controller.text,
              //             style: TextStyle(fontWeight: FontWeight.bold),
              //           ),
            ],
          );
        });
  }
}

//-------------------------------------------------------------
