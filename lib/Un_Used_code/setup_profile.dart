// import 'dart:io';
// import 'package:file_picker/file_picker.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:restaurant_version/services/firbase.dart';
// import 'package:restaurant_version/components/loader.dart';
//
// class UploadRestaurantProfilePhotoPage extends StatefulWidget {
//   const UploadRestaurantProfilePhotoPage({Key? key}) : super(key: key);
//
//   @override
//   _UploadRestaurantProfilePhotoPageState createState() =>
//       _UploadRestaurantProfilePhotoPageState();
// }
//
// class _UploadRestaurantProfilePhotoPageState
//     extends State<UploadRestaurantProfilePhotoPage> {
//   bool loader = false;
//   FirebaseAthentications firebaseAthentications = FirebaseAthentications();
//   late File imageFile;
//   late UploadTask? task;
//   late String avatarImage =
//       'https://image.shutterstock.com/image-vector/add-image-vector-icon-260nw-1042853482.jpg';
//
//   late String iconLink =
//       'https://image.shutterstock.com/image-vector/add-image-vector-icon-260nw-1042853482.jpg';
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
//                     ElevatedButton(
//                         onPressed: () async {
//                           selectFile();
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
//                               ? Image.file(imageFile)
//                               : Image.network(avatarImage),
//                     ),
//                     ElevatedButton(
//                         onPressed: () async {
//                           loader = true;
//                           String result = await uploadFile();
//                           firebaseAthentications.uploadRestaurantProfilePhoto(
//                               result, context);
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
//     super.initState();
//   }
//
//   void selectFile() async {
//     final result = await FilePicker.platform.pickFiles(
//       type: FileType.image,
//     );
//
//     try {
//       if (result != null) {
//         final path = result.files.single.path;
//         setState(() {
//           imageFile = File(path!);
//           //  avatarImage = File(path);
//
//           print(imageFile);
//         });
//       }
//     } catch (e) {}
//   }
//
//   uploadFile() async {
//     final fileName = imageFile;
//     final destination =
//         'RestaurantProfilePictures/${FirebaseAuth.instance.currentUser?.uid}';
//     task = FirebaseApi.uploadFile(fileName, destination);
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
//   static UploadTask? uploadFile(File filename, String destination) {
//     try {
//       final ref = FirebaseStorage.instance.ref(destination);
//       return ref.putFile(filename);
//     } catch (e) {
//       print(e);
//     }
//     return null;
//   }
// }
