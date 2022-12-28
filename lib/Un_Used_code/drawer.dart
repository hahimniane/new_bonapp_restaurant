// import 'package:flutter/material.dart';
//
// import '../../Un_Used_code/testpage.dart';
// import '../screens/home_screen.dart';

// class DrawerNavBar extends StatelessWidget {
//   const DrawerNavBar({
//     Key? key,
//   }) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Drawer(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Container(
//                 padding: const EdgeInsets.fromLTRB(0, 5, 0, 10),
//                 color: Colors.pink,
//                 child: const Expanded(
//                   child: Image(
//                     image: AssetImage('images/sokpov.jpeg'),
//                   ),
//                 )
//                 // Row(
//                 //   children: [
//                 //     const Expanded(
//                 //       flex: 1,
//                 //       child: CircleAvatar(
//                 //         backgroundColor: Colors.white,
//                 //         radius: 40,
//                 //       ),
//                 //     ),
//                 //     Padding(
//                 //       padding: const EdgeInsets.all(10),
//                 //       child: Expanded(
//                 //         flex: 3,
//                 //         child: Column(
//                 //           crossAxisAlignment: CrossAxisAlignment.start,
//                 //           children: const [
//                 //             Text('Sulaiman A. Barry', style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold, fontSize: 20),),
//                 //             Text('b.sulaiman0199@gmail.com', style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
//                 //           ],
//                 //         ),
//                 //       ),
//                 //     ),
//                 //   ],
//                 // ),
//                 ),
//             const Divider(
//               height: 10,
//               color: Colors.pink,
//             ),
//             Card(
//               color: Colors.white70,
//               child: TextButton(
//                 onPressed: () {
//                   Navigator.push(context,
//                       MaterialPageRoute(builder: (context) => HomeScreen()));
//                 },
//                 child: Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Row(
//                     children: const [
//                       Icon(
//                         Icons.home,
//                         size: 30,
//                         color: Colors.pink,
//                       ),
//                       SizedBox(
//                         width: 10,
//                       ),
//                       Text(
//                         'Home',
//                         style: TextStyle(fontSize: 20, color: Colors.pink),
//                       )
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//             Card(
//               color: Colors.white70,
//               child: TextButton(
//                 onPressed: () {
//                   Navigator.push(context,
//                       MaterialPageRoute(builder: (context) => TrialPage()));
//                   // Navigator.push(context,
//                   //     MaterialPageRoute(builder: (context) => MenuScreen()));
//                 },
//                 child: Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Row(
//                     children: const [
//                       Icon(
//                         Icons.menu_book,
//                         color: Colors.pink,
//                       ),
//                       SizedBox(
//                         width: 10,
//                       ),
//                       Text(
//                         'Menu',
//                         style: TextStyle(
//                           fontSize: 20,
//                           color: Colors.pink,
//                         ),
//                       )
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//             Card(
//               color: Colors.white70,
//               child: TextButton(
//                 onPressed: () {},
//                 child: Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Row(
//                     children: const [
//                       Icon(
//                         Icons.shopping_cart,
//                         color: Colors.pink,
//                       ),
//                       SizedBox(
//                         width: 10,
//                       ),
//                       Text(
//                         'Orders',
//                         style: TextStyle(
//                           fontSize: 20,
//                           color: Colors.pink,
//                         ),
//                       )
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//             Card(
//               color: Colors.white70,
//               child: TextButton(
//                 onPressed: () {},
//                 child: Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Row(
//                     children: const [
//                       Icon(
//                         Icons.settings,
//                         color: Colors.pink,
//                       ),
//                       SizedBox(
//                         width: 10,
//                       ),
//                       Text(
//                         'Setting',
//                         style: TextStyle(
//                           fontSize: 20,
//                           color: Colors.pink,
//                         ),
//                       )
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
