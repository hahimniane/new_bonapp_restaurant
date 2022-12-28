import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:developer' as dev;

class ConakryListView extends StatefulWidget {
  @override
  _ConakryListViewState createState() => _ConakryListViewState();
}

class _ConakryListViewState extends State<ConakryListView> {
  String? selectedItem;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('Country')
            .doc('Guinea')
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return LinearProgressIndicator();

          List<DropdownMenuItem<String>> conakryList = [];
          List itemsToChooseFrom = [];

          for (int i = 0; i < snapshot.data!['conakry'].length; i++) {
            itemsToChooseFrom.add(snapshot.data!['conakry'][i]);
            // dev.debugger(when: true);
            conakryList.add(
              DropdownMenuItem(
                child: Builder(builder: (context) {
                  return Text(
                    itemsToChooseFrom[i],
                    style: TextStyle(color: Colors.black),
                  );
                }),
                value: itemsToChooseFrom[i],
              ),
            );
          }

          return Center(
            child: ListView.builder(
              itemCount: 2,
              itemBuilder: (context, index) {
                return DropdownButton<String>(
                  items: conakryList,
                  onChanged: (value) {
                    // dev.debugger(when: true);
                    setState(() {
                      itemsToChooseFrom[index] = value!;
                      print(
                          'the chosen value is now ${itemsToChooseFrom[index]}');
                    });
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }
}
