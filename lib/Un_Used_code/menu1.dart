// import 'dart:io';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:path/path.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
//
// class Menu extends StatefulWidget {
//   const Menu({
//     Key? key,
//   }) : super(key: key);
//
//   @override
//   State<Menu> createState() => _MenuState();
// }
//
// class _MenuState extends State<Menu> {
//   final TextEditingController photo = TextEditingController();
//   final TextEditingController name = TextEditingController();
//   final TextEditingController price = TextEditingController();
//   final TextEditingController desc = TextEditingController();
//   final TextEditingController ingredientOne = TextEditingController();
//   final TextEditingController ingredientTwo = TextEditingController();
//   final TextEditingController ingredientThree = TextEditingController();
//   late int imageType;
//
//   late File imageFile1;
//
//   late UploadTask? task;
//
//   late String avatarImage =
//       'https://image.shutterstock.com/image-vector/add-image-vector-icon-260nw-1042853482.jpg';
//
//   late String iconLink =
//       'https://image.shutterstock.com/image-vector/add-image-vector-icon-260nw-1042853482.jpg';
//   buildCard(String img, String title, String subtitle, String price) {
//     return Card(
//       child: TextButton(
//         onPressed: () {},
//         child: ListTile(
//             leading: Image(image: AssetImage(img)),
//             title: Text(title),
//             subtitle: Text(subtitle),
//             trailing: Text(price)),
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     //=====================food name input filed ==============================//
//     final nameField = TextFormField(
//       autofocus: false,
//       controller: name,
//       keyboardType: TextInputType.text,
//       validator: (value) {
//         RegExp regexp = RegExp(r'^.{3,}$');
//         if (value!.isEmpty) {
//           return ('food name is required');
//         }
//         if (!regexp.hasMatch(value)) {
//           return ("Food name can't be less than 3 char");
//         }
//       },
//       onSaved: (value) {
//         name.text = value!;
//       },
//       textInputAction: TextInputAction.next,
//       decoration: InputDecoration(
//           prefixIcon: const Icon(Icons.food_bank),
//           contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
//           hintText: "Food Name",
//           border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
//     );
//     //=====================food name input filed ==============================//
//     final ingredients = <TextFormField>[
//       // thought of this but a little confuse
//     ];
//
//     //=====================food name input filed ==============================//
//     final descField = TextFormField(
//       autofocus: false,
//       controller: desc,
//       keyboardType: TextInputType.text,
//       validator: (value) {
//         RegExp regexp = RegExp(r'^.{3,}$');
//         if (value!.isEmpty) {
//           return ('food description is required');
//         }
//         if (!regexp.hasMatch(value)) {
//           return ("Description can't be less than 3 char");
//         }
//       },
//       onSaved: (value) {
//         desc.text = value!;
//       },
//       textInputAction: TextInputAction.next,
//       decoration: InputDecoration(
//           prefixIcon: const Icon(Icons.fork_left),
//           contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
//           hintText: "Food description",
//           border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
//     );
//     //=====================food name input filed ==============================//
//     final priceField = TextFormField(
//       autofocus: false,
//       controller: price,
//       keyboardType: TextInputType.number,
//       validator: (value) {
//         if (value!.isEmpty) {
//           return ('food price is required');
//         }
//       },
//       onSaved: (value) {
//         price.text = value!;
//       },
//       textInputAction: TextInputAction.next,
//       decoration: InputDecoration(
//           prefixIcon: const Icon(Icons.attach_money),
//           contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
//           hintText: "Price",
//           border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
//     );
//     final ingredientOneField = TextFormField(
//       autofocus: false,
//       controller: ingredientOne,
//       keyboardType: TextInputType.text,
//       validator: (value) {
//         if (value!.isEmpty) {
//           return ('Ingredient is required');
//         }
//       },
//       onSaved: (value) {
//         ingredientOne.text = value!;
//       },
//       textInputAction: TextInputAction.next,
//       decoration: InputDecoration(
//           // prefixIcon: Icon(Icons.),
//           contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
//           hintText: "Ingredient 1",
//           border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
//     );
//     final SaveButton = Material(
//       elevation: 5,
//       borderRadius: BorderRadius.circular(30),
//       color: Colors.pink,
//       child: MaterialButton(
//         padding: const EdgeInsets.all(8.0),
//         minWidth: MediaQuery.of(context).size.width,
//         onPressed: () {
//           // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen()));
//           // await firebaseAthentications.signInUser(
//           //     emailController.text, passwordController.text, context);
//
//           // signIn(emailController.text, passwordController.text);
//         },
//         child: const Text(
//           'Save',
//           textAlign: TextAlign.center,
//           style: TextStyle(
//               fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
//         ),
//       ),
//     );
//     return SafeArea(
//       child: Column(
//         children: [
//           Expanded(
//             flex: 10,
//             child: GridView(
//               primary: false,
//               padding: const EdgeInsets.all(20),
//               gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 1,
//                   childAspectRatio: 3,
//                   mainAxisSpacing: 10,
//                   crossAxisSpacing: 5),
//               children: [
//                 buildCard('images/pizza.png', 'Pizza',
//                     'lorem ipsum is the stander testing text', '1000'),
//                 buildCard('images/burger.png', 'Pizza',
//                     'lorem ipsum is the stander testing text', '900'),
//                 buildCard('images/plate.png', 'Pizza',
//                     'lorem ipsum is the stander testing text', '1200'),
//                 buildCard('images/noodle.png', 'Pizza',
//                     'lorem ipsum is the stander testing text', '300'),
//                 buildCard('images/kfc.png', 'Pizza',
//                     'lorem ipsum is the stander testing text', '2500'),
//                 buildCard('images/chicken.png', 'Pizza',
//                     'lorem ipsum is the stander testing text', '500'),
//                 buildCard('images/shawarma.png', 'Pizza',
//                     'lorem ipsum is the stander testing text', '700'),
//               ],
//             ),
//           ),
//           Expanded(
//             flex: 1,
//             child: Align(
//               alignment: Alignment.bottomRight,
//               child: Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: FloatingActionButton(
//                   splashColor: Colors.pink,
//                   child: const Center(
//                       child: Icon(
//                     Icons.add,
//                     size: 20,
//                   )),
//                   onPressed: () {
//                     showModalBottomSheet(
//                         shape: const RoundedRectangleBorder(
//                           borderRadius: BorderRadius.only(
//                               topLeft: Radius.circular(30),
//                               topRight: Radius.circular(30)),
//                         ),
//                         context: context,
//                         builder: (context) {
//                           return Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Container(
//                               height: double.infinity,
//                               child: Column(
//                                 children: [
//                                   const Padding(
//                                     padding: EdgeInsets.all(8.0),
//                                     child: Text('Add To Menu'),
//                                   ),
//                                   Padding(
//                                     padding: const EdgeInsets.all(12.0),
//                                     child: nameField,
//                                   ),
//                                   Padding(
//                                     padding: const EdgeInsets.all(8.0),
//                                     child: priceField,
//                                   ),
//                                   Padding(
//                                     padding: const EdgeInsets.all(8.0),
//                                     child: descField,
//                                   ),
//                                   // Column(
//                                   // children: ingredients.map((ingredient) {
//                                   //   return  Expanded(
//                                   //     child: Padding(
//                                   //       padding: const EdgeInsets.all(8.0),
//                                   //       child: ingredient,
//                                   //     ),
//                                   //   );
//                                   // }).toList(),
//                                   // ),
//                                   Row(
//                                     children: [
//                                       Expanded(
//                                           flex: 4, child: ingredientOneField),
//                                       Expanded(
//                                           flex: 1,
//                                           child: IconButton(
//                                             icon: const Icon(Icons.plus_one),
//                                             onPressed: () {},
//                                           ))
//                                     ],
//                                   ),
//                                   ElevatedButton(
//                                       onPressed: () async {
//                                         showModalBottomSheet(
//                                             context: context,
//                                             builder: (name) {
//                                               return Container(
//                                                 color: Colors.grey,
//                                                 height: 200,
//                                                 child: Center(
//                                                   child: Row(
//                                                     mainAxisAlignment:
//                                                         MainAxisAlignment
//                                                             .center,
//                                                     children: [
//                                                       IconButton(
//                                                           onPressed: () async {
//                                                             imageType = 0;
//                                                             await _getImage(
//                                                                 imageType);
//                                                             imageType = 0;
//
//                                                             // enumList.photo;
//                                                             // selectFile(imageType);
//                                                           },
//                                                           icon: const Icon(Icons
//                                                               .camera_alt)),
//                                                       IconButton(
//                                                           onPressed: () {
//                                                             // imageType = 1;
//                                                             // _getImage(imageType);
//                                                           },
//                                                           icon: const Icon(
//                                                               // FontAwesomeIcons
//                                                               Icons.clear)),
//                                                     ],
//                                                   ),
//                                                 ),
//                                               );
//                                             });
//                                         // selectFile();
//                                       },
//                                       child: const Text('choose photo')),
//
//                                   Expanded(
//                                     child: Padding(
//                                       padding: const EdgeInsets.symmetric(
//                                           vertical: 18.0, horizontal: 1.0),
//                                       child: SaveButton,
//                                     ),
//                                   )
//                                   // SizedBox(
//                                   //   height: 100,
//                                   //   width: 100,
//                                   //   child: avatarImage ==
//                                   //       'https://image.shutterstock.com/image-vector/add-image-vector-icon-260nw-1042853482.jpg'
//                                   //       ? Image.network(iconLink)
//                                   //       : avatarImage !=
//                                   //       'https://image.shutterstock.com/image-vector/add-image-vector-icon-260nw-1042853482.jpg'
//                                   //       ? Image.file(imageFile1)
//                                   //       : Image.network(avatarImage),
//                                   // ),
//                                   // ElevatedButton(
//                                   //     onPressed: () async {
//                                   //       loader = true;
//                                   //       String result = await uploadFile();
//                                   //       if (result != null) {
//                                   //         firebaseAthentications.getLastMenNumber(
//                                   //             nameController.text,
//                                   //             descriptionController.text,
//                                   //             priceController.text,
//                                   //             result,
//                                   //             ingredient1Controller.text,
//                                   //             ingredient2Controller.text,
//                                   //             ingredient3nameController.text);
//                                   //       }
//                                   //       // var result = await FirebaseStorage.instance
//                                   //       //     .ref('menus')
//                                   //       //     .child(FirebaseAuth.instance.currentUser!.uid)
//                                   //       //     .listAll();
//                                   //       // print(result.items.first.name);
//                                   //     },
//                                   //     child: const Text('upload')),
//                                 ],
//                               ),
//                             ),
//                           );
//                         });
//                   },
//                 ),
//               ),
//             ),
//           )
//         ],
//       ),
//     );
//   }
//
//   uploadFile() async {
//     final fileName = imageFile1;
//
//     var baseName = basename(fileName.path);
//     // task = FirebaseApi.uploadFile(fileName, baseName);
//     if (task != null) {
//       final snapshot = await task?.whenComplete(() => {});
//       final url = await snapshot?.ref.getDownloadURL();
//       setState(() {
//         avatarImage = url!;
//         print(' the download url is ' + avatarImage);
//         // loader = false;
//       });
//       return url;
//     } else {
//       return null;
//     }
//   }
//
//   _getImage(type) async {
//     try {
//       var pickedFile;
//       if (type == 0) {
//         pickedFile = await ImagePicker().pickImage(
//           source: ImageSource.camera,
//           maxWidth: 1800,
//           maxHeight: 1800,
//         );
//       } else {
//         pickedFile = await ImagePicker().pickImage(
//           source: ImageSource.gallery,
//           maxWidth: 1800,
//           maxHeight: 1800,
//         );
//       }
//
//       if (pickedFile != null) {
//         File imageFile = File(pickedFile.path);
//
//         setState(() {
//           imageFile1 = File(pickedFile!.path);
//           print(imageFile);
//         });
//       }
//     } catch (e) {
//       print(e.toString());
//     }
//   }
// }
