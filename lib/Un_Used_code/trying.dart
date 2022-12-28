// import 'package:flutter/material.dart';
// import 'package:restaurant_version/trial_page_for%20textfield.dart';
//
// class BottomSheetState extends StatefulWidget {
//   @override
//   _BottomSheetStateState createState() => _BottomSheetStateState();
// }
//
// class _BottomSheetStateState extends State<BottomSheetState> {
//   bool toggleIcon = true;
//   toggleIconState(bool value) {
//     setState(() {
//       toggleIcon = value;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(),
//       body: Container(
//         child: Center(
//           child: Column(
//             children: [
//               Icon(
//                   toggleIcon ? Icons.check_box : Icons.check_box_outline_blank),
//               ElevatedButton(
//                   onPressed: () {
//                     showModalBottomSheet(
//                         context: context,
//                         builder: (BuildContext context) {
//                           return StatefulBottomSheet();
//                         });
//                   },
//                   child: const Text('Show Bottom Sheet'))
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// class StatefulBottomSheet extends StatefulWidget {
//   StatefulBottomSheet({
//     Key? key,
//   });
//
//   @override
//   _StatefulBottomSheetState createState() => _StatefulBottomSheetState();
// }
//
// class _StatefulBottomSheetState extends State<StatefulBottomSheet> {
//   List<Widget> _getFriends() {
//     List<Widget> friendsTextFields = [];
//     for (int i = 0; i < friendsList.length; i++) {
//       friendsTextFields.add(Padding(
//         padding: const EdgeInsets.symmetric(vertical: 16.0),
//         child: Row(
//           children: [
//             Expanded(child: FriendTextFields(i)),
//             SizedBox(
//               width: 16,
//             ),
//             // we need add button at last friends row
//             _addRemoveButton(i == friendsList.length - 1, i),
//           ],
//         ),
//       ));
//     }
//     return friendsTextFields;
//   }
//
//   /// add / remove button
//   Widget _addRemoveButton(bool add, int index) {
//     return InkWell(
//       onTap: () {
//         if (add) {
//           // add new text-fields at the top of all friends textfields
//           friendsList.insert(0, '');
//         } else
//           friendsList.removeAt(index);
//         setState(() {});
//       },
//       child: Container(
//         width: 30,
//         height: 30,
//         decoration: BoxDecoration(
//           color: (add) ? Colors.green : Colors.red,
//           borderRadius: BorderRadius.circular(20),
//         ),
//         child: Icon(
//           (add) ? Icons.add : Icons.remove,
//           color: Colors.white,
//         ),
//       ),
//     );
//   }
//
//   final _formKey = GlobalKey<FormState>();
//   TextEditingController? _nameController;
//   static List friendsList = [null];
//   @override
//   void initState() {
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Container(
//         height: MediaQuery.of(context).size.height,
//         child: ListView(
//           children: [
//             SizedBox(
//               height: MediaQuery.of(context).size.height,
//               child: Column(
//                 children: [
//                   const Padding(
//                     padding: EdgeInsets.all(8.0),
//                     child: Text('Add To Menu'),
//                   ),
//
//                   Padding(
//                     padding: const EdgeInsets.all(12.0),
//                     child: nameField,
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: priceField,
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: descField,
//                   ),
//                   // Column(
//                   // children: ingredients.map((ingredient) {
//                   //   return  Expanded(
//                   //     child: Padding(
//                   //       padding: const EdgeInsets.all(8.0),
//                   //       child: ingredient,
//                   //     ),
//                   //   );
//                   // }).toList(),
//                   // ),
//                   //***************************************************
//                   // Row(
//                   //   children: [
//                   //     Expanded(
//                   //         flex: 4, child: ingredientOneField),
//                   //     Expanded(
//                   //         flex: 1,
//                   //         child: IconButton(
//                   //           icon: const Icon(Icons.plus_one),
//                   //           onPressed: () {},
//                   //         ))
//                   //   ],
//                   // ),
//                   const SizedBox(
//                     height: 5,
//                   ),
//                   Form(
//                     key: _formKey,
//                     child: Padding(
//                       padding: const EdgeInsets.all(16.0),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           // name textfield
//                           Padding(
//                             padding: const EdgeInsets.only(right: 32.0),
//                             child: TextFormField(
//                               controller: _nameController,
//                               decoration:
//                                   InputDecoration(hintText: 'Enter your name'),
//                               validator: (v) {
//                                 if (v!.trim().isEmpty)
//                                   return 'Please enter something';
//                                 return null;
//                               },
//                             ),
//                           ),
//                           SizedBox(
//                             height: 20,
//                           ),
//
//                           ..._getFriends(),
//                           SizedBox(
//                             height: 40,
//                           ),
//                           TextButton(
//                             style: TextButton.styleFrom(
//                               backgroundColor: Colors.green,
//                             ),
//                             onPressed: () {
//                               if (_formKey.currentState!.validate()) {
//                                 _formKey.currentState!.save();
//                               }
//                             },
//                             child: Text('Submit'),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   ElevatedButton(
//                       onPressed: () async {
//                         showModalBottomSheet(
//                             context: context,
//                             builder: (name) {
//                               return Container(
//                                 color: Colors.grey,
//                                 height: 200,
//                                 child: Center(
//                                   child: Row(
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     children: [
//                                       IconButton(
//                                           onPressed: () async {
//                                             imageType = 0;
//                                             await _getImage(imageType);
//                                             // imageType = 0;
//                                             //
//                                             // // enumList.photo;
//                                             // selectFile(imageType);
//                                           },
//                                           icon: const Icon(Icons.camera_alt)),
//                                       IconButton(
//                                           onPressed: () {
//                                             imageType = 1;
//                                             _getImage(imageType);
//                                           },
//                                           icon: const Icon(
//                                               FontAwesomeIcons.photoVideo)),
//                                     ],
//                                   ),
//                                 ),
//                               );
//                             });
//                         // selectFile();
//                       },
//                       child: const Text('choose photo')),
//
//                   Expanded(
//                       flex: 1,
//                       child: Padding(
//                         padding: const EdgeInsets.symmetric(vertical: 46.0),
//                         child: SaveButton,
//                       )),
//                   // SizedBox(
//                   //   height: 100,
//                   //   width: 100,
//                   //   child: avatarImage ==
//                   //       'https://image.shutterstock.com/image-vector/add-image-vector-icon-260nw-1042853482.jpg'
//                   //       ? Image.network(iconLink)
//                   //       : avatarImage !=
//                   //       'https://image.shutterstock.com/image-vector/add-image-vector-icon-260nw-1042853482.jpg'
//                   //       ? Image.file(imageFile1)
//                   //       : Image.network(avatarImage),
//                   // ),
//                   // ElevatedButton(
//                   //     onPressed: () async {
//                   //       loader = true;
//                   //       String result = await uploadFile();
//                   //       if (result != null) {
//                   //         firebaseAthentications.getLastMenNumber(
//                   //             nameController.text,
//                   //             descriptionController.text,
//                   //             priceController.text,
//                   //             result,
//                   //             ingredient1Controller.text,
//                   //             ingredient2Controller.text,
//                   //             ingredient3nameController.text);
//                   //       }
//                   //       // var result = await FirebaseStorage.instance
//                   //       //     .ref('menus')
//                   //       //     .child(FirebaseAuth.instance.currentUser!.uid)
//                   //       //     .listAll();
//                   //       // print(result.items.first.name);
//                   //     },
//                   //     child: const Text('upload')),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// //
// // Form(
// // key: _formKey,
// // child: Padding(
// // padding: const EdgeInsets.all(16.0),
// // child: Column(
// // crossAxisAlignment: CrossAxisAlignment.start,
// // children: [
// // // name textfield
// //
// // ..._getFriends(),
// // const SizedBox(
// // height: 10,
// // ),
// // TextButton(
// // style: TextButton.styleFrom(
// // backgroundColor: Colors.green,
// // ),
// // onPressed: () {
// // if (_formKey.currentState!.validate()) {
// // _formKey.currentState!.save();
// // }
// // },
// // child: Text('Submit'),
// // ),
// // ],
// // ),
// // ),
// // ),
