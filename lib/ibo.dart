import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Projeler extends StatefulWidget {
  Projeler({Key? key}) : super(key: key);

  @override
  State<Projeler> createState() => _ProjelerState();
}

class _ProjelerState extends State<Projeler> {
  String source = 'Miniere';
  String destination2 = 'hamdallaye';
  String destination1 = 'dixinn';
  getDocuments(
      {required String source,
      required String destination1,
      required String destination2}) async {
    DocumentSnapshot valueToReturn = await FirebaseFirestore.instance
        .collection('Country')
        .doc('Guinea')
        .get();
    if (valueToReturn.exists) {
      var price =
          await valueToReturn['Destinations'][source]['miniere_$destination1'];

      return price;
    } else
      return null;

    // print(
    //   value['Destinations'][source]['miniere_$destination1'],
    // ),

    return valueToReturn;
  }

  String _message = 'No message';
  String _price = '0';

  getCommunity() async {
    var data = await FirebaseFirestore.instance
        .collection('Restaurants')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
  }

  @override
  void initState() {}

  Future<void> updateMessage(String newMessage) async {
    setState(() {
      destination1 = newMessage;

      print('the updated destination $destination1');
    });
    var update = await getDocuments(
        source: source, destination1: destination1, destination2: destination2);

    setState(() {
      _price = update;
      print('the new price is $_price');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MyDropdownButton(
              updateMessage: updateMessage,
            ),
            SizedBox(height: 20),
            Text(
                'the price from your location to $destination1 is $_price GNF '),
            // ElevatedButton(
            //   onPressed: () {
            //
            //   },
            //   child: Text('Press me'),
            // ),
          ],
        ),
      ),
    ));
  }
}

class MyDropdownButton extends StatefulWidget {
  late final void Function(String) updateMessage;
  MyDropdownButton({required this.updateMessage});
  @override
  _MyDropdownButtonState createState() => _MyDropdownButtonState();
}

class _MyDropdownButtonState extends State<MyDropdownButton> {
  List<DropdownButton>? listOfDropDowns;
  String? _selectedColor;
  String numberOfDestinations = '0';

  var dropdownData = [];

  List<DropdownButton> dropdownButtons = [];

  String? location;
  Future<void> updateMessage(String newMessage) async {
    setState(() {
      numberOfDestinations = newMessage;

      print('the updated destination $numberOfDestinations');
    });

    // var update = await getDocuments(
    //     source: source, destination1: destination1, destination2: destination2);

    // setState(() {
    //   _price = update;
    //   print('the new price is $_price');
    // });
  }

  addDropDownToList(int numberOfButtonsToCreate) {
    for (int i = 0; i < numberOfButtonsToCreate; ++i) {
      // listOfDropDowns.add();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      NewDropDown(
        updateMessage: updateMessage,
      ),
      StreamBuilder<DocumentSnapshot>(
          stream: FirebaseFirestore.instance
              .collection('Country')
              .doc('Guinea')
              .snapshots(),
          builder: (context, snapshot) {
            return ListView.builder(
                shrinkWrap: true,
                itemCount: int.parse(numberOfDestinations),
                itemBuilder: (context, index) {
                  List<String> selectedItems = [];

                  DropdownButton<String> dropdownButton =
                      DropdownButton<String>(
                    // hint: Text('choose destination please'),
                    items: snapshot.data!['conakry']
                        .map<DropdownMenuItem<String>>((conakry) {
                      return DropdownMenuItem<String>(
                        onTap: () {
                          print('the new location is $location');
                        },
                        value: location,
                        child: location == null
                            ? Text(
                                location!,
                                style: TextStyle(color: Colors.black),
                              )
                            : Text(
                                'Nothing selected',
                                style: TextStyle(color: Colors.black),
                              ),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      setState(() {
                        location = newValue!;
                        print(
                            'the selcected item is at index $index of dropdown button  $location');
                      });
                    },
                  );
                  dropdownButtons.add(dropdownButton);
                  return dropdownButton;
                });
          })
    ]);
    //     StreamBuilder<DocumentSnapshot>(
    //         stream: FirebaseFirestore.instance
    //             .collection('Country')
    //             .doc('Guinea')
    //             .snapshots(),
    //         builder: (context, snapshot) {
    // if (!snapshot.hasData) {
    // return CircularProgressIndicator();
    // }
    // List<dynamic> items = snapshot.data!['conakry'];
    // return ListView.builder(
    // itemCount: int.parse(numberOfDestinations),
    // itemBuilder: (context, index) {
    // return DropdownButton<String>(
    // value: dropdownData[index]['value'],
    // onChanged: (newValue) {
    // setState(() {
    // dropdownData[index]['value'] = newValue;
    // });
    // },
    // items: dropdownData[index]['options'].map<DropdownMenuItem<String>>((option) {
    // return DropdownMenuItem<String>(
    // value: option['value'],
    // child: Text(option['label']),
    // );
    // }).toList(),
    // );
    // })
    //  ],
    // );
  }
}

List<Widget> list = [];

class NewDropDown extends StatefulWidget {
  late final void Function(String) updateMessage;
  NewDropDown({required this.updateMessage});
  @override
  _NewDropDownState createState() => _NewDropDownState();
}

class _NewDropDownState extends State<NewDropDown> {
  String? _selectedColor; // Default selection

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('Country')
            .doc('Guinea')
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return CircularProgressIndicator();
          }
          List<dynamic> items = snapshot.data!['conakry'];
          return DropdownButton<String>(
            hint: Text('Please choose a destination'),
            value: _selectedColor,
            onChanged: (newValue) {
              setState(() {
                widget.updateMessage(newValue.toString().toLowerCase());
                _selectedColor = newValue;
              });
            },
            items: ['1', '2', '3'].map((value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          );
        });
  }
}

//
// DropdownButton<String>(
// hint: Text('Please choose a destination'),
// value: _selectedColor,
// onChanged: (newValue) {
// setState(() {
// widget.updateMessage(newValue.toString().toLowerCase());
// _selectedColor = newValue;
// });
// },
// items: items.map((value) {
// return DropdownMenuItem<String>(
// value: value,
// child: Text(value),
// );
// }).toList(),
// );
