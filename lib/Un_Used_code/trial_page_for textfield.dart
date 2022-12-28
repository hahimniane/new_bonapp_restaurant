// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
//
// class MyForm extends StatefulWidget {
//   const MyForm({Key? key}) : super(key: key);
//
//   @override
//   _MyFormState createState() => _MyFormState();
// }
//
// class _MyFormState extends State<MyForm> {
//   final _formKey = GlobalKey<FormState>();
//   TextEditingController? _nameController;
//   static List friendsList = [null];
//
//   @override
//   void initState() {
//     super.initState();
//     _nameController = TextEditingController();
//   }
//
//   @override
//   void dispose() {
//     _nameController!.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[200],
//       appBar: AppBar(
//         title: const Text('Dynamic TextFormFields'),
//       ),
//       body: Form(
//         key: _formKey,
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // name textfield
//               Padding(
//                 padding: const EdgeInsets.only(right: 32.0),
//                 child: TextFormField(
//                   controller: _nameController,
//                   decoration:
//                       const InputDecoration(hintText: 'Enter your name'),
//                   validator: (v) {
//                     if (v!.trim().isEmpty) return 'Please enter something';
//                     return null;
//                   },
//                 ),
//               ),
//               const SizedBox(
//                 height: 20,
//               ),
//               const Text(
//                 'Add Friends',
//                 style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
//               ),
//               ..._getFriends(),
//               const SizedBox(
//                 height: 40,
//               ),
//               TextButton(
//                 style: TextButton.styleFrom(
//                   backgroundColor: Colors.green,
//                 ),
//                 onPressed: () {
//                   if (_formKey.currentState!.validate()) {
//                     _formKey.currentState!.save();
//                   }
//                 },
//                 child: const Text('Submit'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   /// get firends text-fields
//   List<Widget> _getFriends() {
//     List<Widget> friendsTextFields = [];
//     for (int i = 0; i < friendsList.length; i++) {
//       friendsTextFields.add(Padding(
//         padding: const EdgeInsets.symmetric(vertical: 16.0),
//         child: Row(
//           children: [
//             Expanded(child: FriendTextFields(i)),
//             const SizedBox(
//               width: 16,
//             ),
//             // we need add button at last friends row
//             // _addRemoveButton(i == friendsList.length - 1, i),
//           ],
//         ),
//       ));
//     }
//     return friendsTextFields;
//   }
//
//   /// add / remove button
//   // Widget _addRemoveButton(bool add, int index) {
//   //   return InkWell(
//   //     onTap: () {
//   //       if (add) {
//   //         // add new text-fields at the top of all friends textfields
//   //         friendsList.insert(0, '');
//   //       } else {
//   //         friendsList.removeAt(index);
//   //       }
//   //       setState(() {});
//   //     },
//   //     child: Container(
//   //       width: 30,
//   //       height: 30,
//   //       decoration: BoxDecoration(
//   //         color: (add) ? Colors.green : Colors.red,
//   //         borderRadius: BorderRadius.circular(20),
//   //       ),
//   //       child: Icon(
//   //         (add) ? Icons.add : Icons.remove,
//   //         color: Colors.white,
//   //       ),
//   //     ),
//   //   );
//   // }
// }
//
// class FriendTextFields extends StatefulWidget {
//   final int index;
//   const FriendTextFields(this.index, {Key? key}) : super(key: key);
//   @override
//   _FriendTextFieldsState createState() => _FriendTextFieldsState();
// }
//
// class _FriendTextFieldsState extends State<FriendTextFields> {
//   TextEditingController? _nameController;
//
//   @override
//   void initState() {
//     super.initState();
//     _nameController = TextEditingController();
//   }
//
//   @override
//   void dispose() {
//     _nameController!.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
//       _nameController!.text = _MyFormState.friendsList[widget.index];
//     });
//
//     return TextFormField(
//       controller: _nameController,
//       onChanged: (v) {
//         _MyFormState.friendsList[widget.index] = v;
//         print(_MyFormState.friendsList[widget.index]);
//       },
//       decoration: InputDecoration(
//           prefixIcon: const Icon(
//             FontAwesomeIcons.mortarPestle,
//             color: Colors.grey,
//             size: 18,
//           ),
//           border: OutlineInputBorder(
//             borderSide: const BorderSide(
//               color: Colors.grey, //this has no effect
//             ),
//             borderRadius: BorderRadius.circular(10.0),
//           ),
//           hintText: 'Enter Ingredient  ${widget.index + 1}'),
//       validator: (v) {
//         if (v!.trim().isEmpty) return 'Please enter something';
//         return null;
//       },
//     );
//   }
// }
// //-------------====================================================================================================================
// // import 'dart:io';
// //
// // import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:flutter/foundation.dart';
// // import 'package:flutter/material.dart';
// // import 'package:fluttertoast/fluttertoast.dart';
// // import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// //
// // class NewPage extends StatefulWidget {
// //   const NewPage({Key? key}) : super(key: key);
// //
// //   @override
// //   State<NewPage> createState() => _NewPageState();
// // }
// //
// // class _NewPageState extends State<NewPage> {
// //   TextEditingController firstController = TextEditingController();
// //   final List<TextEditingController> _controllers = [];
// //   final List<Row> _fields = [];
// //   TextEditingController controller = TextEditingController();
// //
// //   late Row field;
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return SafeArea(
// //       child: Scaffold(
// //           body: Column(
// //         children: [
// //           Row(
// //             children: [
// //               Expanded(
// //                 flex: (MediaQuery.of(context).size.width * 0.90).round(),
// //                 child: TextField(
// //                   textAlign: TextAlign.center,
// //                   controller: firstController,
// //                   decoration: InputDecoration(
// //                     hintText: ' Enter Ingredient ${'1'}',
// //                     prefixIcon: const Icon(
// //                       FontAwesomeIcons.mortarPestle,
// //                       color: Colors.grey,
// //                       size: 18,
// //                     ),
// //                     border: OutlineInputBorder(
// //                       borderSide: const BorderSide(
// //                         color: Colors.grey, //this has no effect
// //                       ),
// //                       borderRadius: BorderRadius.circular(10.0),
// //                     ),
// //                   ),
// //                 ),
// //               ),
// //               addTextFieldButton(),
// //             ],
// //           ),
// //           Expanded(child: _listView()),
// //           Expanded(
// //             child: TextButton(
// //                 onPressed: () {
// //                   int checkFields = 0;
// //                   for (var controller in _controllers) {
// //                     if (controller.text.isEmpty) {
// //                       var index = _controllers.indexOf(controller);
// //                       checkFields = 1;
// //                       print('the controller at index ${index + 1} is empty');
// //                       Fluttertoast.showToast(
// //                           gravity: ToastGravity.CENTER,
// //                           msg: 'Field is empty please try again');
// //                       break;
// //                     }
// //                   }
// //                   ;
// //
// //                   if (checkFields == 0) {
// //                     for (int i = 0; i < _controllers.length; ++i) {
// //                       print(_controllers[i].text);
// //
// //                       FirebaseFirestore.instance
// //                           .collection('Trying')
// //                           .doc('1')
// //                           .set(
// //                               {
// //                             "ingredient ${i + 1}": _controllers[i].text,
// //                           },
// //                               SetOptions(
// //                                 merge: true,
// //                               ));
// //                     }
// //                   }
// //                 },
// //                 child: Text('print')),
// //           ),
// //         ],
// //       )),
// //     );
// //   }
// //
// //   @override
// //   void initState() {
// //     super.initState();
// //   }
// //
// //   Widget _listView() {
// //     return Container(
// //       height: MediaQuery.of(context).size.height,
// //       child: ListView.builder(
// //         itemCount: _fields.length,
// //         itemBuilder: (context, index) {
// //           return Container(
// //             margin: EdgeInsets.all(5),
// //             child: _fields[index],
// //           );
// //         },
// //       ),
// //     );
// //   }
// //
// //   addTextFieldButton() {
// //     return Container(
// //       padding: EdgeInsets.all(5.0),
// //       height: MediaQuery.of(context).size.width * 0.2,
// //       width: MediaQuery.of(context).size.width * 0.10,
// //       child: FloatingActionButton(
// //           onPressed: () {
// //             final field = Row(
// //               children: [
// //                 Expanded(
// //                   flex: (MediaQuery.of(context).size.width * 0.90).round(),
// //                   child: TextField(
// //                     textAlign: TextAlign.center,
// //                     controller: controller,
// //                     decoration: InputDecoration(
// //                       hintText: ' Enter Ingredient ${_fields.length + 2}',
// //                       prefixIcon: const Icon(
// //                         FontAwesomeIcons.mortarPestle,
// //                         color: Colors.grey,
// //                         size: 18,
// //                       ),
// //                       border: OutlineInputBorder(
// //                         borderSide: const BorderSide(
// //                           color: Colors.grey, //this has no effect
// //                         ),
// //                         borderRadius: BorderRadius.circular(10.0),
// //                       ),
// //                     ),
// //                   ),
// //                 ),
// //                 Expanded(
// //                     flex: (MediaQuery.of(context).size.width * 0.10).round(),
// //                     child: Padding(
// //                       padding: const EdgeInsets.all(8.0),
// //                       child: FloatingActionButton(
// //                           backgroundColor: Colors.red,
// //                           child: Icon(
// //                             Icons.remove,
// //                           ),
// //                           onPressed: () {
// //                             setState(() {
// //                               _fields.removeLast();
// //                               _controllers.removeLast();
// //                             });
// //                           }),
// //                     ))
// //               ],
// //             );
// //
// //             setState(() {
// //               if (_controllers.length <= 3) {
// //                 _controllers.add(controller);
// //                 _fields.add(field);
// //               } else {
// //                 Fluttertoast.showToast(
// //                     msg: 'You cant add more than 8 ingredients');
// //               }
// //             });
// //           },
// //           child: Icon(Icons.add)),
// //     );
// //   }
// //
// //   @override
// //   void dispose() {
// //     for (var controller in _controllers) {
// //       controller.dispose();
// //       super.dispose();
// //     }
// //   }
// // }
