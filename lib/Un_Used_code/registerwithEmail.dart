// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:google_fonts/google_fonts.dart';
//
// import '../services/firbase.dart';
// import '../components/methods.dart';
//
// class RegisterWithEmailPage extends StatefulWidget {
//   const RegisterWithEmailPage({Key? key}) : super(key: key);
//
//   @override
//   _RegisterWithEmailPageState createState() => _RegisterWithEmailPageState();
// }
//
// class _RegisterWithEmailPageState extends State<RegisterWithEmailPage> {
//   FirebaseAthentications firebaseAthentications = FirebaseAthentications();
//   TextEditingController email = TextEditingController();
//   TextEditingController password = TextEditingController();
//   TextEditingController passwordAgain = TextEditingController();
//   TextEditingController restaurantName = TextEditingController();
//   TextEditingController restaurantFullAddress = TextEditingController();
//   TextEditingController restaurantPhoneNumber = TextEditingController();
//   TextEditingController community = TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     var height = MediaQuery.of(context).size.height;
//     var width = MediaQuery.of(context).size.width;
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           'Register',
//           style: GoogleFonts.alata(
//             textStyle: const TextStyle(
//                 color: Colors.white,
//                 letterSpacing: .20,
//                 fontWeight: FontWeight.w900),
//           ),
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             SizedBox(
//               height: height * 0.02,
//             ),
//             buildTextField(width, height, 'E-mail*', 0.060, email),
//             buildTextField(width, height, 'Password*', 0.060, password),
//             buildTextField(
//                 width, height, 'Password (Again)*', 0.060, passwordAgain),
//             SizedBox(
//               height: height * 0.02,
//               width: width * 0.95,
//               child: Text(
//                 'it must be at least 6 characters.',
//                 style: TextStyle(color: Colors.grey.shade700),
//               ),
//             ),
//             SizedBox(
//               width: width * 0.95,
//               child: Text(
//                 'it should contain 1 uppercase letter, 1 lowercase letter,1 symbol and 1 number',
//                 style: TextStyle(color: Colors.grey.shade700),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.only(top: 16.0, bottom: 8),
//               child: Container(
//                 height: height * 0.01,
//                 color: Colors.grey.shade300,
//               ),
//             ),
//             buildTextField(
//                 width, height, 'Restaurant Name*', 0.060, restaurantName),
//             buildTextField(width, height, 'Restaurant Adress*', 0.060,
//                 restaurantFullAddress),
//             // SizedBox(
//             //     width: width * 0.95,
//             //     child: buildTextButton(() {}, Colors.green, 'Pick a date')),
//             buildTextField(
//                 width, height, 'Phone Number*', 0.060, restaurantPhoneNumber),
//             buildTextField(width, height, 'Community*', 0.060, community),
//             SizedBox(
//                 width: width * 0.95,
//                 child: buildTextButton(() {
//                   var checkPasswordSync =
//                       password.text.compareTo(passwordAgain.text);
//                   if (checkPasswordSync == 0) {
//                     firebaseAthentications.SignUpUser(
//                         context,
//                         email.text,
//                         password.text,
//                         restaurantName.text,
//                         restaurantFullAddress.text,
//                         restaurantPhoneNumber.text,
//                         community.text);
//                   } else {
//                     print('not equal passwords');
//                     Fluttertoast.showToast(
//                         msg: "Please check your password",
//                         toastLength: Toast.LENGTH_LONG,
//                         gravity: ToastGravity.CENTER,
//                         timeInSecForIosWeb: 1,
//                         backgroundColor: Colors.red,
//                         textColor: Colors.white,
//                         fontSize: 16.0);
//                   }
//                 }, Colors.green, 'Register')),
//           ],
//         ),
//       ),
//     );
//   }
// }
