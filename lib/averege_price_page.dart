import 'package:bonapp_restaurant/services/firbase.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import 'generated/l10n.dart';

class AveragePricePage extends StatefulWidget {
  const AveragePricePage({Key? key}) : super(key: key);

  @override
  State<AveragePricePage> createState() => _AveragePricePageState();
}

class _AveragePricePageState extends State<AveragePricePage> {
  addRestaurantLocationToFirebase(String latitude, String longitude) {
    FirebaseFirestore.instance
        .collection('Restaurants')
        .doc(FirebaseAuth.instance.currentUser!.uid)
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

  FirebaseAthentications service = FirebaseAthentications();

  Prices price = Prices.twentyMinute;
  var choosenPrice;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Expanded(
                  flex: 3,
                  child: Center(
                      child: Image(
                    // color: Colors.white,
                    image: AssetImage('images/appLogo.png'),
                  )),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  S.of(context).chooseFoodAverageString,
                  style: TextStyle(
                    color: Colors.grey.shade700,
                    height: 1.3,
                    fontSize: 17,
                    fontWeight: FontWeight.w900,
                    // color: Color(0xff030199),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Card(
                    elevation: 15,
                    shape: const StadiumBorder(
                      side: BorderSide(
                        color: Colors.black,
                        width: 1,
                      ),
                    ),
                    child: ListTile(
                      title: const Text(
                        '10.000,000 GNF',
                        style: TextStyle(
                          color: Colors.deepOrangeAccent,
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      leading: Radio(
                        activeColor: Colors.deepOrangeAccent,
                        value: Prices.twentyMinute,
                        groupValue: price,
                        onChanged: (Prices? value) {
                          setState(() {
                            price = value!;
                            choosenPrice = '10000';
                          });
                        },
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Card(
                    elevation: 15,
                    shape: const StadiumBorder(
                      side: BorderSide(
                        color: Colors.black,
                        width: 1.5,
                      ),
                    ),
                    child: ListTile(
                      title: const Text(
                        '25.000,000 GNF',
                        style: TextStyle(
                          color: Colors.deepOrangeAccent,
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      leading: Radio(
                        activeColor: Colors.deepOrangeAccent,
                        value: Prices.thirtyMinutes,
                        groupValue: price,
                        onChanged: (Prices? value) {
                          setState(() {
                            price = value!;
                            choosenPrice = '25000';
                          });
                        },
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Card(
                    elevation: 15,
                    shape: const StadiumBorder(
                      side: BorderSide(
                        color: Colors.black,
                        width: 1.5,
                      ),
                    ),
                    child: ListTile(
                      title: const Text(
                        '50.000,000 GNF',
                        style: TextStyle(
                          color: Colors.deepOrangeAccent,
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      leading: Radio(
                        activeColor: Colors.deepOrangeAccent,
                        value: Prices.fourtyFiveMinutes,
                        groupValue: price,
                        onChanged: (Prices? value) {
                          setState(() {
                            price = value!;
                            choosenPrice = '50000';
                          });
                        },
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Card(
                    elevation: 15,
                    // margin: EdgeInsets.symmetric(vertical: 15),
                    shape: const StadiumBorder(
                      side: BorderSide(
                        color: Colors.black,
                        width: 1.5,
                      ),
                    ),
                    child: ListTile(
                      title: const Text(
                        '75.000,000 GNF',
                        style: TextStyle(
                          color: Colors.deepOrangeAccent,
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      leading: Radio(
                        activeColor: Colors.deepOrangeAccent,
                        value: Prices.oneHour,
                        groupValue: price,
                        onChanged: (Prices? value) {
                          setState(() {
                            price = value!;
                            choosenPrice = '75000';
                          });
                        },
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Card(
                    elevation: 15,
                    // margin: EdgeInsets.symmetric(vertical: 15),
                    shape: const StadiumBorder(
                      side: BorderSide(
                        color: Colors.black,
                        width: 1.5,
                      ),
                    ),
                    child: ListTile(
                      title: const Text(
                        '100.000,000 GNF',
                        style: TextStyle(
                          color: Colors.deepOrangeAccent,
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      leading: Radio(
                        activeColor: Colors.deepOrangeAccent,
                        value: Prices.oneHourThirtyMinutes,
                        groupValue: price,
                        onChanged: (Prices? value) {
                          setState(() {
                            price = value!;
                            choosenPrice = '100000';
                          });
                        },
                      ),
                    ),
                  ),
                ),
                Center(
                  child: GestureDetector(
                    onTap: () {
                      service.updateAverageRestaurantPrice(
                          choosenPrice.toString(), context);
                    },
                    child: Container(
                        height: MediaQuery.of(context).size.height * 0.08,
                        margin: const EdgeInsets.all(10),
                        padding: EdgeInsets.all(10),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: Colors.deepOrange,
                            border: Border.all(
                                // Set border color
                                // width: 3.0,
                                ), // Set border width
                            borderRadius: const BorderRadius.all(
                                Radius.circular(
                                    20.0)), // Set rounded corner radius
                            boxShadow: const [
                              BoxShadow(
                                  blurRadius: 10,
                                  // color: Colors.black,
                                  offset: Offset(1, 3))
                            ] // Make rounded corner of border
                            ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              S.of(context).nextString,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Icon(
                              Icons.skip_next_outlined,
                              color: Colors.white,
                              size: 30,
                            )
                          ],
                        )),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    getLocation();
    print(price);
  }
}

enum Prices {
  twentyMinute,
  thirtyMinutes,
  fourtyFiveMinutes,
  oneHour,
  oneHourThirtyMinutes
}
