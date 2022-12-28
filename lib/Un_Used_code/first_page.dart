// import 'dart:io';
//
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
//
// import 'package:geolocator/geolocator.dart';
// import 'package:google_fonts/google_fonts.dart';
//
// import 'package:image_picker/image_picker.dart';
// import 'package:restaurant_version/registration/firbase.dart';
// import 'package:restaurant_version/registration/loader.dart';
//
// import '../storage.dart';
//
// class FirstPage extends StatefulWidget {
//   FirstPage({Key? key}) : super(key: key);@
//
//   @override
//   _FirstPageState createState() => _FirstPageState();
//
//   late String _currentAddress;
// }
//
// class _FirstPageState extends State<FirstPage> {
//   bool loader = true;
//   FirebaseAthentications firebaseAthentications = FirebaseAthentications();
//   FireStorage fireStorage = FireStorage();
//   FirebaseAuth auth = FirebaseAuth.instance;
//   late File _imageFile;
//   late UploadTask task;
//   late String myImageUrl =
//       'https://image.shutterstock.com/image-vector/add-photo-icon-vector-illustration-260nw-1871525389.jpg';
//
//   yukleFotograf() async {
//     var file = await ImagePicker().pickImage(source: ImageSource.gallery);
//     setState(() {
//       _imageFile = File(file!.path);
//       print(_imageFile);
//     });
//   }
//
//   // late File yuklenecekDosya;
//   // kameradanYukle() async {
//   //   var alinanDosya = await ImagePicker().pickImage(source: ImageSource.camera);
//   //   setState(() {
//   //     _imageFile = File(alinanDosya!.path);
//   //   });
//   //   final ref = FirebaseStorage.instance
//   //       .ref()
//   //       .child('photos')
//   //       .child( 'profile');
//   //   await ref.putFile(yuklenecekDosya).onComplete;
//   //   final url = await ref.getDownloadURL();
//   //   print("Image URL: " + url);
//   //   });
//   // }
//
//   static final List<Widget> _widgetOptions = <Widget>[
//     FirstPage(),
//     // const SearchPage(),
//     // const BasketPage(),
//     // SupportPage(),
//     // MyAccountPage(),
//     // const RegisterWithEmailPage(),
//   ];
//   int _selectedIndex = 0;
//
//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return loader
//         ? Loader()
//         :
//   }
//
//   @override
//   void initState() {
//     getLocation();
//     downloadURLExample();
//   }
//
//   void getLocation() async {
//     Position position = await Geolocator.getCurrentPosition(
//         desiredAccuracy: LocationAccuracy.high);
//     print(position.latitude);
//     print(position.longitude);
//   }
//
//   Future<void> downloadURLExample() async {
//     try {
//       String downloadURL = await FirebaseStorage.instance
//           .ref('photos/${auth.currentUser!.uid}')
//           .getDownloadURL();
//
//       if (downloadURL != null) {
//         setState(() {
//           loader = false;
//         });
//       }
//
//       setState(() {
//         myImageUrl = downloadURL;
//
//         print('the image url is ' + myImageUrl);
//       });
//     } on FirebaseException catch (e) {
//       setState(() {
//         loader = false;
//         print(e.message);
//       });
//     }
//     // Within your widgets:
//     // Image.network(downloadURL);
//   }
// }
