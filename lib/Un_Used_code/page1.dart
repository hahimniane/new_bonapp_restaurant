// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:restaurant_version/post_registration/upload_restaurant_menu_photo.dart';
// import 'package:restaurant_version/components/loader.dart';
// import 'package:restaurant_version/components/methods.dart';
//
// import '../registration/setup_profile.dart';
// import 'create_menu_page.dart';
//
// class FirstPage extends StatefulWidget {
//   const FirstPage({Key? key}) : super(key: key);
//
//   @override
//   _FirstPageState createState() => _FirstPageState();
// }
//
// class _FirstPageState extends State<FirstPage> {
//   // bool loader = true;
//   // late String myImageUrl;
//   //
//   // double profileHeigh = 144;
//   // double coverHeight = 280;
//   // Future<void> coverPhotoDownloadFunction() async {
//   //   try {
//   //     String downloadURL = await FirebaseStorage.instance
//   //         .ref('menus/Starbucks-China-iStock.jpg')
//   //         .getDownloadURL();
//   //
//   //     setState(() {
//   //       loader = false;
//   //     });
//   //
//   //     setState(() {
//   //       myImageUrl = downloadURL;
//   //
//   //       print('the image url is ' + myImageUrl);
//   //     });
//   //   } on FirebaseException catch (e) {
//   //     setState(() {
//   //       loader = false;
//   //       print(e.message);
//   //     });
//   //   }
//   //   // Within your widgets:
//   //   // Image.network(downloadURL);
//   // }
//
//   @override
//   Widget build(BuildContext context) {
//     // final top = coverHeight - profileHeigh / 2;
//     // var height = MediaQuery.of(context).size.height;
//     // var width = MediaQuery.of(context).size.width;
//     return Scaffold(
//         appBar: AppBar(title: const Text('Welcome')),
//         body: SafeArea(
//           child: Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Expanded(
//                     child: Container(
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Expanded(
//                         child: Row(
//                           children: [
//                             Expanded(
//                               child: Center(
//                                 child: Card(
//                                   child: buildTextButton(() {
//                                     // Navigator.push(
//                                     //     context,
//                                     //     MaterialPageRoute(
//                                     //         builder: (context) =>
//                                     //             const CreateMenuPage()));
//                                   }, Colors.black, 'Create a New Menu'),
//                                 ),
//                               ),
//                             ),
//                             Expanded(
//                                 child: Center(
//                                     child: Card(
//                               child: buildTextButton(() {
//                                 Navigator.push(
//                                     context,
//                                     MaterialPageRoute(
//                                         builder: (context) =>
//                                             const UploadRestaurantProfilePhotoPage()));
//                               }, Colors.black, 'Update Profile picture'),
//                             ))),
//                           ],
//                         ),
//                       ),
//                       Expanded(
//                         child: Row(
//                           children: [
//                             Expanded(
//                               child: Center(
//                                 child: Card(
//                                   child: buildTextButton(() {
//                                     Navigator.push(
//                                         context,
//                                         MaterialPageRoute(
//                                             builder: (context) =>
//                                                 const UploadRestaurantCoverImage()));
//                                   }, Colors.black, 'Upload Menu Cover photo'),
//                                 ),
//                               ),
//                             ),
//                             Expanded(
//                                 child: Center(
//                               child: Card(
//                                 child: buildTextButton(
//                                     () {}, Colors.black, 'Edit Menu'),
//                               ),
//                             ))
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                   color: Colors.grey,
//                 )),
//                 Expanded(
//                     child: Container(
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Row(
//                         children: [
//                           Expanded(
//                             child: Center(
//                               child: Card(
//                                 child: Padding(
//                                   padding: const EdgeInsets.only(top: 10.0),
//                                   child: buildTextButton(
//                                       () {}, Colors.black, 'Pending Orders'),
//                                 ),
//                               ),
//                             ),
//                           ),
//                           Expanded(
//                             child: Center(
//                               child: Card(
//                                 child: Padding(
//                                   padding: const EdgeInsets.only(top: 10.0),
//                                   child: buildTextButton(
//                                       () {}, Colors.black, 'Previous Orders'),
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ],
//                       )
//                     ],
//                   ),
//                   color: Colors.blue,
//                 )),
//               ],
//             ),
//           ),
//         ));
//   }
//
//   @override
//   void initState() {
//     // coverPhotoDownloadFunction();
//   }
// }
//
// class buildTop extends StatelessWidget {
//   const buildTop({
//     Key? key,
//     required this.coverHeight,
//     required this.myImageUrl,
//     required this.top,
//     required this.width,
//     required this.profileHeigh,
//   }) : super(key: key);
//
//   final double coverHeight;
//   final String myImageUrl;
//   final double top;
//   final double width;
//   final double profileHeigh;
//
//   @override
//   Widget build(BuildContext context) {
//     final bottom = profileHeigh / 2;
//     return Stack(
//       clipBehavior: Clip.none,
//       children: [
//         coverMethod(coverHeight: coverHeight, myImageUrl: myImageUrl),
//         Positioned(
//           top: top,
//           left: width / 3,
//           child: CircleAvatar(
//               radius: profileHeigh / 2,
//               backgroundColor: Colors.green,
//               backgroundImage: const NetworkImage(
//                   'https://scontent.fayt2-1.fna.fbcdn.net/v/t1.6435-9/184025772_1826732714171741_1879089305666859791_n.jpg?_nc_cat=102&ccb=1-5&_nc_sid=e3f864&_nc_ohc=_iFGOn_65BsAX_3fDqD&_nc_ht=scontent.fayt2-1.fna&oh=00_AT-Ll7QK4s3Rpaa-peOatWiTCvW_ojl6DOQ3TXPYSs8Tlw&oe=62124C35')),
//         )
//       ],
//     );
//   }
// }
//
// class coverMethod extends StatelessWidget {
//   const coverMethod({
//     Key? key,
//     required this.coverHeight,
//     required this.myImageUrl,
//   }) : super(key: key);
//
//   final double coverHeight;
//   final String myImageUrl;
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.only(bottom: 144 / 2),
//       height: coverHeight,
//       child: Image.network(
//         myImageUrl
//         // 'assets/backgroundImages/background.jpeg',
//         ,
//         fit: BoxFit.cover,
//       ),
//       color: Colors.green,
//     );
//   }
// }
