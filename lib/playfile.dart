// import 'dart:async';
//
// import 'package:flutter/material.dart';
//
// class PlayClass extends StatefulWidget {
//   const PlayClass({Key? key}) : super(key: key);
//
//   @override
//   State<PlayClass> createState() => _PlayClassState();
// }
//
// class _PlayClassState extends State<PlayClass> {
//   StreamController<Text> _controller = StreamController();
//   List<int> texts = [];
//   Stream? stream;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             ElevatedButton(
//               onPressed: () {
//                 final Stream stream = _controller.stream;
//                 print('subscribed');
//                 stream.listen((event) {
//                   texts.add(event);
//                 });
//               },
//               child: Text('Subscribe'),
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 _controller.sink.add(Text('ji'));
//               },
//               child: Text('Add text'),
//             ),
//             StreamBuilder(
//                 stream: _controller.stream,
//                 builder: (context, snapshot) {
//                   return SizedBox(
//                     height: 400,
//                     child: ListView.builder(
//                       itemCount: texts.length,
//                       itemBuilder: (BuildContext context, int index) {
//                         return Text(snapshot.toString());
//                       },
//                     ),
//                   );
//                 })
//           ],
//         ),
//       ),
//     );
//   }
//
//   @override
//   void initState() {}
// }
