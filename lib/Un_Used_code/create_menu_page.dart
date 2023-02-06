// import 'dart:io';
//
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:restaurant_version/services/firbase.dart';
// import 'package:restaurant_version/components/loader.dart';
// import 'package:restaurant_version/components/methods.dart';
// import 'package:path/path.dart';
//
// import '../storage.dart';
//
// class CreateMenuPage extends StatefulWidget {
//   const CreateMenuPage({Key? key}) : super(key: key);
//
//   @override
//   _CreateMenuPageState createState() => _CreateMenuPageState();
// }
//
// class _CreateMenuPageState extends State<CreateMenuPage> {
//   late int imageType;
//   bool loader = false;
//   FirebaseAthentications firebaseAthentications = FirebaseAthentications();
//   late File imageFile1;
//   late UploadTask? task;
//   late String avatarImage =
//       'https://image.shutterstock.com/image-vector/add-image-vector-icon-260nw-1042853482.jpg';
//
//   late String iconLink =
//       'https://image.shutterstock.com/image-vector/add-image-vector-icon-260nw-1042853482.jpg';
//
//   TextEditingController nameController = TextEditingController();
//
//   TextEditingController descriptionController = TextEditingController();
//
//   TextEditingController priceController = TextEditingController();
//
//   TextEditingController ingredient1Controller = TextEditingController();
//
//   TextEditingController ingredient2Controller = TextEditingController();
//
//   TextEditingController ingredient3nameController = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     double height = MediaQuery.of(context).size.height;
//     double width = MediaQuery.of(context).size.width;
//     return loader
//         ? const Loader()
//         : Scaffold(
//             appBar: AppBar(
//               title: Text(
//                 'Yemeksepeti',
//                 style: GoogleFonts.alata(
//                   textStyle: const TextStyle(
//                       color: Colors.white,
//                       letterSpacing: .20,
//                       fontWeight: FontWeight.w900),
//                 ),
//               ),
//             ),
//             body: SingleChildScrollView(
//               child: Center(
//                 child: Column(
//                   children: [
//                     SizedBox(
//                       height: height * 0.01,
//                     ),
//                     buildTextField(width, height, 'Enter food name ', 0.05,
//                         nameController),
//                     buildTextField(width, height, 'Enter Description', 0.05,
//                         descriptionController),
//                     buildTextField(width, height, 'Enter ingredient 1', 0.05,
//                         ingredient1Controller),
//                     buildTextField(width, height, 'Enter ingredient 2', 0.05,
//                         ingredient2Controller),
//                     buildTextField(width, height, 'Enter ingredient 3', 0.05,
//                         ingredient3nameController),
//                     buildTextField(
//                         width, height, 'Enter price', 0.05, priceController),
//                     ElevatedButton(
//                         onPressed: () async {
//                           showModalBottomSheet(
//                               context: context,
//                               builder: (name) {
//                                 return Container(
//                                   color: Colors.grey,
//                                   height: 200,
//                                   child: Center(
//                                     child: Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.center,
//                                       children: [
//                                         IconButton(
//                                             onPressed: () async {
//                                               imageType = 0;
//                                               await _getImage(imageType);
//                                               // imageType = 0;
//                                               //
//                                               // // enumList.photo;
//                                               // selectFile(imageType);
//                                             },
//                                             icon: const Icon(Icons.camera_alt)),
//                                         IconButton(
//                                             onPressed: () {
//                                               imageType = 1;
//                                               _getImage(imageType);
//                                             },
//                                             icon: const Icon(
//                                                 FontAwesomeIcons.photoVideo)),
//                                       ],
//                                     ),
//                                   ),
//                                 );
//                               });
//                           // selectFile();
//                         },
//                         child: const Text('choose photo')),
//                     SizedBox(
//                       height: 400,
//                       width: 250,
//                       child: avatarImage ==
//                               'https://image.shutterstock.com/image-vector/add-image-vector-icon-260nw-1042853482.jpg'
//                           ? Image.network(iconLink)
//                           : avatarImage !=
//                                   'https://image.shutterstock.com/image-vector/add-image-vector-icon-260nw-1042853482.jpg'
//                               ? Image.file(imageFile1)
//                               : Image.network(avatarImage),
//                     ),
//                     ElevatedButton(
//                         onPressed: () async {
//                           loader = true;
//                           String result = await uploadFile();
//                           // if (result != null) {
//                           //   firebaseAthentications.getLastMenNumber(
//                           //       nameController.text,
//                           //       descriptionController.text,
//                           //       priceController.text,
//                           //       result,
//                           //       ingredient1Controller.text,
//                           //       ingredient2Controller.text,
//                           //       ingredient3nameController.text);
//                           // }
//                           // var result = await FirebaseStorage.instance
//                           //     .ref('menus')
//                           //     .child(FirebaseAuth.instance.currentUser!.uid)
//                           //     .listAll();
//                           // print(result.items.first.name);
//                         },
//                         child: const Text('upload')),
//                   ],
//                 ),
//               ),
//             ),
//           );
//   }
//
//   @override
//   void initState() {
//     choose();
//   }
//
//   // void selectFile(int filetype) async {
//   //   // ImagePicker.platform.getImage(source: ImageSource.gallery);
//   //   final result;
//   //   if (filetype == 0) {
//   //     result = await ImagePicker.platform.getImage(source: ImageSource.camera);
//   //     //
//   //     // FilePicker.platform.pickFiles(
//   //     //   type: FileType.image,
//   //     //
//   //     // );
//   //   } else {
//   //     // result = await FilePicker.platform.pickFiles(
//   //     //   type: FileType.image,
//   //     // );
//   //     result = await ImagePicker.platform.getImage(source: ImageSource.gallery);
//   //     print('the image type is ');
//   //   }
//   //
//   //   try {
//   //     if (result != null) {
//   //       final path = result.files.single.path;
//   //       setState(() {
//   //         imageFile = File(path!);
//   //         //  avatarImage = File(path);
//   //
//   //         print(imageFile);
//   //       });
//   //     }
//   //   } catch (e) {
//   //     print(e.toString());
//   //   }
//   // }
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
//
//   // getTheLastUploadedImageName() async {
//   //   var result = await FirebaseStorage.instance
//   //       .ref('menus')
//   //       .child(FirebaseAuth.instance.currentUser!.uid)
//   //       .listAll();
//   //   if (result.items.isNotEmpty) {
//   //     var result2 = int.parse(result.items.last.name) + 1;
//   //     return result2.toString();
//   //   } else {
//   //     return '1';
//   //   }
//   // }
//
//   uploadFile() async {
//     final fileName = imageFile1;
//
//     var baseName = basename(fileName.path);
//     task = FirebaseApi.uploadFile(fileName, baseName);
//     if (task != null) {
//       final snapshot = await task?.whenComplete(() => {});
//       final url = await snapshot?.ref.getDownloadURL();
//       setState(() {
//         avatarImage = url!;
//         print(' the download url is ' + avatarImage);
//         loader = false;
//       });
//       return url;
//     } else {
//       return null;
//     }
//   }
//
//   void choose() {
//     setState(() {
//       avatarImage =
//           'https://image.shutterstock.com/image-vector/add-image-vector-icon-260nw-1042853482.jpg';
//     });
//   }
// }
//
// class FirebaseApi {
//   static UploadTask? uploadFile(File filename, destination) {
//     try {
//       final ref = FirebaseStorage.instance
//           .ref('/menus')
//           .child(FirebaseAuth.instance.currentUser!.uid)
//           .child(destination);
//       return ref.putFile(filename);
//     } catch (e) {
//       print(e);
//     }
//   }
// }

//   GridView(
//   primary: false,
//   padding: const EdgeInsets.all(20),
//   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//       crossAxisCount: 1,
//       childAspectRatio: 3,
//       mainAxisSpacing: 10,
//       crossAxisSpacing: 5),
//   children: [
//     // StreamBuilder<QuerySnapshot>(
//   stream: FirebaseFirestore.instance
//       .collection('Restaurants')
//       .doc(FirebaseAuth.instance.currentUser!.uid)
//       .collection('Pending Orders')
//       .snapshots(),
//     //   builder:
//     //       (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//     //     if (snapshot.hasError) {
//     //       return const Text('Something went wrong');
//     //     }
//     //
//     //     if (snapshot.connectionState == ConnectionState.waiting) {
//     //       return const Text("Loading");
//     //     }
//     //     if (!snapshot.hasData) {
//     //       return const Center(
//     //           child: SizedBox(
//     //               height: 50,
//     //               width: 50,
//     //               child: CircularProgressIndicator()));
//     //     }
//     //     return GridView(
//     //       primary: false,
//     //       padding: const EdgeInsets.all(20),
//     //       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//     //           crossAxisCount: 1,
//     //           childAspectRatio: 3,
//     //           mainAxisSpacing: 10,
//     //           crossAxisSpacing: 5),
//     //       children: snapshot.data!.docs.map((DocumentSnapshot document) {
//     //         Map<String, dynamic> data =
//     //             document.data()! as Map<String, dynamic>;
//     //         return Card(
//     //           child: GestureDetector(
//     //             onLongPress: () {
//     //               print('card was long pressed');
//     //             },
//     //             child: Row(
//     //               children: [
//     //                 Expanded(
//     //                   flex: 6,
//     //                   child: ListTile(
//     //                       leading: Image(
//     //                           image: NetworkImage(data['image link'])),
//     //                       title: Text(data['food name']),
//     //                       subtitle: Text(data['description']),
//     //                       trailing: Text(' ${data['food price']} GNF')),
//     //                 ),
//     //                 Expanded(
//     //                     flex: 1,
//     //                     child: GestureDetector(
//     //                       onTap: () {
//     //                         print('the edit button was pressed');
//     //                       },
//     //                       child: const Icon(
//     //                         Icons.edit,
//     //                         size: 15,
//     //                       ),
//     //                     ))
//     //               ],
//     //             ),
//     //           ),
//     //         );
//     //       }).toList(),
//     //     );
//     //     return ListView(
//     //       children: snapshot.data!.docs.map((DocumentSnapshot document) {
//     //         Map<String, dynamic> data =
//     //             document.data()! as Map<String, dynamic>;
//     //         return ListTile(
//     //           title: Text(data['full_name']),
//     //           subtitle: Text(data['company']),
//     //         );
//     //       }).toList(),
//     //     );
//     //   },
//     // ),
//     Card(
//       child: TextButton(
//         onPressed: () {},
//         child: const ListTile(
//             leading: Icon(
//               Icons.person,
//               size: 40,
//               color: Colors.pink,
//             ),
//             title: Text('Orders'),
//             subtitle: Text('1000'),
//             trailing: Icon(
//               Icons.check,
//               size: 30,
//               color: Colors.green,
//             )),
//       ),
//     ),
// Card(
//   child: TextButton(
//     onPressed: () {},
//     child: const ListTile(
//         leading: Icon(
//           Icons.person,
//           size: 40,
//           color: Colors.pink,
//         ),
//         title: Text('Orders'),
//         subtitle: Text('1000'),
//         trailing: Icon(
//           Icons.check,
//           size: 30,
//           color: Colors.green,
//         )),
//   ),
// ),
//     // Card(
//     //   child: TextButton(
//     //     onPressed: () {},
//     //     child: const ListTile(
//     //         leading: Icon(
//     //           Icons.person,
//     //           size: 40,
//     //           color: Colors.pink,
//     //         ),
//     //         title: Text('Orders'),
//     //         subtitle: Text('1000'),
//     //         trailing: Icon(
//     //           Icons.check,
//     //           size: 30,
//     //           color: Colors.green,
//     //         )),
//     //   ),
//     // ),
//     // Card(
//     //   child: TextButton(
//     //     onPressed: () {},
//     //     child: const ListTile(
//     //         leading: Icon(
//     //           Icons.person,
//     //           size: 40,
//     //           color: Colors.pink,
//     //         ),
//     //         title: Text('Orders'),
//     //         subtitle: Text('1000'),
//     //         trailing: Icon(
//     //           Icons.check,
//     //           size: 30,
//     //           color: Colors.green,
//     //         )),
//     //   ),
//     // ),
//     // Card(
//     //   child: TextButton(
//     //     onPressed: () {},
//     //     child: const ListTile(
//     //         leading: Icon(
//     //           Icons.person,
//     //           size: 40,
//     //           color: Colors.pink,
//     //         ),
//     //         title: Text('Orders'),
//     //         subtitle: Text('1000'),
//     //         trailing: Icon(
//     //           Icons.check,
//     //           size: 30,
//     //           color: Colors.green,
//     //         )),
//     //   ),
//     // ),
//     // Card(
//     //   child: TextButton(
//     //     onPressed: () {},
//     //     child: const ListTile(
//     //         leading: Icon(
//     //           Icons.person,
//     //           size: 40,
//     //           color: Colors.pink,
//     //         ),
//     //         title: Text('Orders'),
//     //         subtitle: Text('1000'),
//     //         trailing: Icon(
//     //           Icons.check,
//     //           size: 30,
//     //           color: Colors.green,
//     //         )),
//     //   ),
//     // ),
//     // Card(
//     //   child: TextButton(
//     //     onPressed: () {},
//     //     child: const ListTile(
//     //         leading: Icon(
//     //           Icons.person,
//     //           size: 40,
//     //           color: Colors.pink,
//     //         ),
//     //         title: Text('Orders'),
//     //         subtitle: Text('1000'),
//     //         trailing: Icon(
//     //           Icons.check,
//     //           size: 30,
//     //           color: Colors.green,
//     //         )),
//     //   ),
//     // ),
//     // Card(
//     //   child: TextButton(
//     //     onPressed: () {},
//     //     child: const ListTile(
//     //         leading: Icon(
//     //           Icons.person,
//     //           size: 40,
//     //           color: Colors.pink,
//     //         ),
//     //         title: Text('Sulaiman A.Barry'),
//     //         subtitle: Text('1000'),
//     //         trailing: Icon(
//     //           Icons.check,
//     //           size: 30,
//     //           color: Colors.green,
//     //         )),
//     //   ),
//     // ),
//   ],
// );
