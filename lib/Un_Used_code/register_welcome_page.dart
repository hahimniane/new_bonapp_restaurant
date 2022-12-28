// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:restaurant_version/registration/registerwithEmail.dart';
//
// import '../login_page.dart';
// import 'Widgets.dart';
// import '../components/loader.dart';
//
// class RegisterWelcomePage extends StatefulWidget {
//   const RegisterWelcomePage({Key? key}) : super(key: key);
//
//   @override
//   State<RegisterWelcomePage> createState() => _RegisterWelcomePageState();
// }
//
// class _RegisterWelcomePageState extends State<RegisterWelcomePage> {
//   bool loader = true;
//   late String myImageUrl;
//   // 'https://scontent.fayt2-1.fna.fbcdn.net/v/t39.30808-6/239881616_1907936872717991_8466700498267012965_n.jpg?_nc_cat=109&ccb=1-5&_nc_sid=174925&_nc_ohc=FaukwfOz0eoAX8ymD_w&_nc_ht=scontent.fayt2-1.fna&oh=00_AT_ySIH4QVyokKzKRuzn2we4tp_JLp-jUsoP0IulEYXbsw&oe=61EB3440';
//   Future<void> downloadURLExample() async {
//     try {
//       String downloadURL = await FirebaseStorage.instance
//           .ref('restaurant/background.png')
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
//
//   @override
//   Widget build(BuildContext context) {
//     var height = MediaQuery.of(context).size.height;
//     var width = MediaQuery.of(context).size.width;
//     return loader
//         ? Loader()
//         : Scaffold(
//             appBar: AppBar(
//               title: Text(
//                 'Register',
//                 style: GoogleFonts.alata(
//                   textStyle: const TextStyle(
//                       color: Colors.white,
//                       letterSpacing: .20,
//                       fontWeight: FontWeight.w900),
//                 ),
//               ),
//             ),
//             body: Column(
//               children: [
//                 SizedBox(
//                   height: height * 0.020,
//                   width: width * 0.95,
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Container(
//                     child: Image.network(
//                       myImageUrl
//                       // 'assets/backgroundImages/background.jpeg',
//                       ,
//                       fit: BoxFit.cover,
//                     ),
//                     height: height * 0.3,
//                     width: width * 0.95,
//                     color: Colors.green,
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: SizedBox(
//                     width: width * 0.95,
//                     child: TextButton(
//                       style: TextButton.styleFrom(
//                           backgroundColor: const Color(0xff2ACB81)),
//                       onPressed: () {
//                         Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (context) =>
//                                     const RegisterWithEmailPage()));
//                       },
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: const [
//                           Padding(
//                             padding: EdgeInsets.all(8),
//                             child: Icon(
//                               Icons.email,
//                               color: Colors.white,
//                             ),
//                           ),
//                           Padding(
//                             padding: EdgeInsets.all(8.0),
//                             child: Text(
//                               'REGISTER WITH EMIAL',
//                               style:
//                                   TextStyle(color: Colors.white, fontSize: 15),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.all(20.0),
//                   child: SizedBox(
//                     height: height * 0.03,
//                     width: width * 0.95,
//                     child: Row(
//                       children: const [
//                         Expanded(
//                           flex: 9,
//                           child: Text('__________________________________'),
//                         ),
//                         Expanded(
//                           flex: 1,
//                           child: Text('Or '),
//                         ),
//                         Expanded(
//                           flex: 9,
//                           child: Text('_______________________________'),
//                         )
//                       ],
//                     ),
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Container(
//                     height: height * 0.056,
//                     width: width * 0.95,
//                     child: MenuContainer(
//                         label: 'Sign in with Apple',
//                         labelColor: Colors.black,
//                         theIcon: FontAwesomeIcons.apple,
//                         function: () {},
//                         borderRadiusColour: Colors.black),
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: SizedBox(
//                     height: height * 0.056,
//                     width: width * 0.95,
//                     child: MenuContainer(
//                         label: 'LOGIN WITH FACEBOOK',
//                         labelColor: Colors.blue.shade500,
//                         theIcon: FontAwesomeIcons.facebook,
//                         function: () {},
//                         borderRadiusColour: Colors.black),
//                   ),
//                 ),
//                 const Padding(
//                   padding: EdgeInsets.all(8.0),
//                   child: Text(
//                     'Already on GetIt',
//                     style: TextStyle(fontSize: 16),
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: SizedBox(
//                     height: height * 0.056,
//                     width: width * 0.95,
//                     child: MenuContainer(
//                         label: 'LOGIN',
//                         labelColor: const Color(0xff2ACB81),
//                         theIcon: Icons.login,
//                         function: () {
//                           Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                   builder: (context) => LogInPage()));
//                         },
//                         borderRadiusColour: const Color(0xff2ACB81)),
//                   ),
//                 ),
//               ],
//             ),
//           );
//   }
//
//   @override
//   void initState() {
//     downloadURLExample();
//   }
// }
