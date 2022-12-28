// import 'package:flutter/material.dart';
//
// class MenuContainer extends StatelessWidget {
//   final String label;
//   final theIcon;
//   final VoidCallback function;
//   final Color borderRadiusColour;
//   final Color labelColor;
//   MenuContainer({
//     Key? key,
//     required this.label,
//     required this.labelColor,
//     required this.theIcon,
//     required this.function,
//     required this.borderRadiusColour,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: function,
//       child: Container(
//           decoration: BoxDecoration(
//               border: Border.all(
//                 color: borderRadiusColour,
//                 width: 1,
//               ),
//               borderRadius: BorderRadius.circular(2)),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Padding(
//                 padding: EdgeInsets.all(8.0),
//                 child: Icon(
//                   theIcon,
//                   size: 15,
//                   color: labelColor,
//                 ),
//               ),
//               Text(
//                 label,
//                 style: TextStyle(
//                     color: labelColor,
//                     fontSize: 15,
//                     fontWeight: FontWeight.w600),
//               )
//             ],
//           )),
//     );
//   }
// }
