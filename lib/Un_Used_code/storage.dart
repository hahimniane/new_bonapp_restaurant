// import 'dart:io';
//
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_storage/firebase_storage.dart';
//
// class FireStorage {
//   FirebaseAuth auth = FirebaseAuth.instance;
//   UploadTask? uploadFile(String destination, File file) {
//     try {
//       final ref = FirebaseStorage.instance
//           .ref(destination)
//           .child(auth.currentUser!.uid);
//
//       return ref.putFile(file);
//     } on FirebaseException catch (e) {
//       print(e.message);
//       return null;
//     }
//   }
// }
