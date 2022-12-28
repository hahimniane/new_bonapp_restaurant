// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:restaurant_version/registration/Widgets.dart';
// import 'package:restaurant_version/services/firbase.dart';
// import 'package:restaurant_version/components/loader.dart';
// import 'package:restaurant_version/components/methods.dart';
// import 'package:restaurant_version/registration/register_welcome_page.dart';
// import 'package:restaurant_version/reset_page.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// class LogInPage extends StatefulWidget {
//   const LogInPage({Key? key}) : super(key: key);
//
//   @override
//   State<LogInPage> createState() => _LogInPageState();
// }
//
// class _LogInPageState extends State<LogInPage> {
//   TextEditingController userNameOrEmail = TextEditingController();
//   bool _isChecked = false;
//
//   TextEditingController password = TextEditingController();
//
//   FirebaseAthentications firebaseAthentications = FirebaseAthentications();
//
//   bool loader = false;
//
//   var auth = FirebaseAuth.instance;
//
//   @override
//   void initState() {
//     // _loadUserEmailPassword();
//   } // TextEditingController passwrodAgain=TextEditingController();
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
//                 'Login',
//                 style: GoogleFonts.alata(
//                   textStyle: const TextStyle(
//                       color: Colors.white,
//                       letterSpacing: .20,
//                       fontWeight: FontWeight.w900),
//                 ),
//               ),
//             ),
//             body: SingleChildScrollView(
//               child: Column(
//                 children: [
//                   SizedBox(
//                     height: height * 0.02,
//                   ),
//                   buildTextField(
//                       width, height, 'Username/E-mail', 0.070, userNameOrEmail),
//                   buildTextField(width, height, 'Password', 0.070, password),
//                   SizedBox(
//                     height: 15,
//                     width: width * 0.95,
//                     child: Padding(
//                       padding: const EdgeInsets.only(left: 255),
//                       child: GestureDetector(
//                         onTap: () {
//                           Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                   builder: (context) => ResetPasswordPage()));
//                         },
//                         child: const Text('Forgot Password'),
//                       ),
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.symmetric(vertical: 16.0),
//                     child: SizedBox(
//                       child: buildTextButton(() async {
//                         setState(() {
//                           loader = true;
//                         });
//                         var resutl = await firebaseAthentications.signInUser(
//                             userNameOrEmail.text, password.text, context);
//                         if (resutl == null) {
//                           loader = false;
//                         } else {
//                           // userNameOrEmail.clear();
//                           // password.clear();
//                         }
//                       }, const Color(0xff2ACB81), 'LOGIN'),
//                       width: width * 0.95,
//                       height: height * 0.054,
//                     ),
//                   ),
//                   Row(
//                     children: [
//                       const Padding(
//                         padding: EdgeInsets.all(8.0),
//                         child: Text('Remember me'),
//                       ),
//                       Checkbox(
//                           fillColor: MaterialStateProperty.all(Colors.green),
//                           value: _isChecked,
//                           onChanged: (value) {
//                             _handleRemeberme(value!);
//                             // setState(() {
//                             //   if (_isChecked) {
//                             //     _isChecked = false;
//                             //   } else {
//                             //     _isChecked = true;
//                             //   }
//                             // });
//                           }),
//                     ],
//                   ),
//                   SizedBox(
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
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Container(
//                       height: height * 0.056,
//                       width: width * 0.95,
//                       child: MenuContainer(
//                           label: 'Sign in with Apple',
//                           labelColor: Colors.black,
//                           theIcon: FontAwesomeIcons.apple,
//                           function: () {
//                             print(
//                                 FirebaseAuth.instance.currentUser?.displayName);
//                           },
//                           borderRadiusColour: Colors.black),
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: SizedBox(
//                       height: height * 0.056,
//                       width: width * 0.95,
//                       child: MenuContainer(
//                         label: 'LOGIN WITH FACEBOOK',
//                         labelColor: Colors.blue.shade500,
//                         theIcon: FontAwesomeIcons.facebook,
//                         function: () {
//                           logoutUser(context) {
//                             try {
//                               auth.signOut().then((value) => {
//                                     // // Navigator.pop(context)
//                                     // Navigator.push(
//                                     //     context, MaterialPageRoute(builder: (context) => LogInPage()));
//                                   });
//                             } on FirebaseException catch (e) {
//                               print(e.message);
//                             }
//                           }
//
//                           logoutUser(context);
//                         },
//                         borderRadiusColour: Colors.blue.shade500,
//                       ),
//                     ),
//                   ),
//                   const Padding(
//                     padding: EdgeInsets.all(8.0),
//                     child: Text(
//                       'Not a member?',
//                       style: TextStyle(fontSize: 16),
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: SizedBox(
//                       height: height * 0.056,
//                       width: width * 0.95,
//                       child: MenuContainer(
//                         label: 'REGISTER',
//                         labelColor: const Color(0xff2ACB81),
//                         theIcon: Icons.person,
//                         function: () {
//                           Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                   builder: (context) =>
//                                       const RegisterWelcomePage()));
//                         },
//                         borderRadiusColour: Color(0xff2ACB81),
//                       ),
//                     ),
//                   )
//                 ],
//               ),
//             ),
//           );
//   }
//
//   //handle remember me function
//   void _handleRemeberme(bool value) {
//     _isChecked = value;
//     SharedPreferences.getInstance().then(
//       (prefs) {
//         prefs.setBool("remember_me", value);
//         prefs.setString('email', userNameOrEmail.text);
//         prefs.setString('password', password.text);
//       },
//     );
//     setState(() {
//       _isChecked = value;
//     });
//   }
//
//   //load email and password
//   // void _loadUserEmailPassword() async {
//   //   try {
//   //     SharedPreferences _prefs = await SharedPreferences.getInstance();
//   //     var _email = _prefs.getString("email") ?? "";
//   //     var _password = _prefs.getString("password") ?? "";
//   //     var _remeberMe = _prefs.getBool("remember_me") ?? false;
//   //     print(_remeberMe);
//   //     print(_email);
//   //     print(_password);
//   //     if (_remeberMe) {
//   //       setState(() {
//   //         _isChecked = true;
//   //       });
//   //       userNameOrEmail.text = _email ?? "";
//   //       password.text = _password ?? "";
//   //     }
//   //   } catch (e) {
//   //     print(e);
//   //   }
//   // }
// }
