// import 'dart:io';
// import 'package:file_picker/file_picker.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:restaurant_version/services/firbase.dart';
// import 'package:restaurant_version/components/loader.dart';
// import 'package:path/path.dart';
// import '../storage.dart';
//
// class UploadRestaurantCoverImage extends StatefulWidget {
//   const UploadRestaurantCoverImage({Key? key}) : super(key: key);
//
//   @override
//   _UploadRestaurantCoverImageState createState() =>
//       _UploadRestaurantCoverImageState();
// }
//
// class _UploadRestaurantCoverImageState
//     extends State<UploadRestaurantCoverImage> {
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
//                 'Upload Main Menu Photo',
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
//                           String result = await uploadFile(imageFile);
//                           if (result != null) {
//                             firebaseAthentications
//                                 .uploadRestaurantCoverPhoto(result);
//                           }
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
//     } catch (e) {
//       print(e.toString());
//     }
//   }
//
//   uploadFile(
//     File theImageFile,
//   ) async {
//     final fileName = theImageFile;
//     var fileBaseName = basename(fileName.path);
//     final destination = '${FirebaseAuth.instance.currentUser?.uid}';
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
//       final ref =
//           FirebaseStorage.instance.ref('/Main Menu photo').child(destination);
//       return ref.putFile(filename);
//     } catch (e) {
//       print(e);
//     }
//   }
// }
