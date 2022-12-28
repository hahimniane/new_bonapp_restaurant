// import 'package:flutter/material.dart';
//
// class TrialPage extends StatefulWidget {
//   const TrialPage({Key? key}) : super(key: key);
//
//   @override
//   State<TrialPage> createState() => _TrialPageState();
// }
//
// class _TrialPageState extends State<TrialPage> {
//   final ingredient2 = TextEditingController();
//   final ingredient3 = TextEditingController();
//   final ingredient4 = TextEditingController();
//   final ingredient5 = TextEditingController();
//   List<Widget> list = [];
//   List<String> controllers = [];
//   final TextEditingController _controller = TextEditingController();
//
//   int controllerIndex = 0;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         padding: const EdgeInsets.all(20.0),
//         child: ListView.builder(
//           itemBuilder: (context, index) {
//             controllers.add(_controller.text);
//             controllerIndex = index;
//             Widget widget = list.elementAt(index);
//             return widget;
//           },
//           itemCount: list.length,
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           list.add(TextField(
//             onChanged: (value) {
//               print(value);
//             },
//             controller: _controller,
//             decoration: InputDecoration(hintText: 'Hint ${list.length + 1}'),
//           ));
//           setState(() {});
//         },
//         child: const Icon(Icons.add),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

class TrialPage extends StatefulWidget {
  _FbCloneProfileState createState() => _FbCloneProfileState();
}

class _FbCloneProfileState extends State<TrialPage> {
  Widget build(BuildContext cx) {
    return Scaffold(
      appBar: null,
      body: Column(
        children: <Widget>[
          Container(
            child: Stack(
              alignment: Alignment.bottomCenter,
              clipBehavior: Clip.none,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        height: 200.0,
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                    'https://www.sageisland.com/wp-content/uploads/2017/06/beat-instagram-algorithm.jpg'))),
                      ),
                    )
                  ],
                ),
                Positioned(
                  top: 100.0,
                  child: Container(
                    height: 190.0,
                    width: 190.0,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: const DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                              'http://cdn.ppcorn.com/us/wp-content/uploads/sites/14/2016/01/Mark-Zuckerberg-pop-art-ppcorn.jpg'),
                        ),
                        border: Border.all(color: Colors.white, width: 6.0)),
                  ),
                ),
              ],
            ),
          ),
          // Container(
          //   alignment: Alignment.bottomCenter,
          //   height: 130.0,
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     children: const <Widget>[
          //       Text(
          //         'Mohsin AR',
          //         style: TextStyle(
          //             fontWeight: FontWeight.bold, fontSize: 28.0),
          //       ),
          //       SizedBox(
          //         width: 5.0,
          //       ),
          //       Icon(
          //         Icons.check_circle,
          //         color: Colors.blueAccent,
          //       )
          //     ],
          //   ),
          // ),
          // const SizedBox(
          //   height: 12.0,
          // ),
          // Container(
          //     child: const Text(
          //   'Signbox software',
          //   style: TextStyle(fontSize: 18.0),
          // )),
          // const SizedBox(
          //   height: 10.0,
          // ),
          // Container(
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //     children: <Widget>[
          //       Column(
          //         children: <Widget>[
          //           IconButton(
          //             icon:
          //                 Icon(Icons.collections, color: Colors.blueAccent),
          //             onPressed: () {},
          //           ),
          //           const Text(
          //             'following',
          //             style: TextStyle(color: Colors.blueAccent),
          //           )
          //         ],
          //       ),
          //       Column(
          //         children: <Widget>[
          //           IconButton(
          //             icon: Icon(Icons.message, color: Colors.black),
          //             onPressed: () {},
          //           ),
          //           const Text(
          //             'Message',
          //             style: TextStyle(color: Colors.black),
          //           )
          //         ],
          //       ),
          //       Column(
          //         children: <Widget>[
          //           IconButton(
          //             icon:
          //                 const Icon(Icons.more_vert, color: Colors.black),
          //             onPressed: () {
          //               _showMoreOption(cx);
          //             },
          //           ),
          //           const Text(
          //             'More',
          //             style: TextStyle(color: Colors.black),
          //           )
          //         ],
          //       )
          //     ],
          //   ),
          // ),
          // const SizedBox(
          //   height: 10.0,
          // ),
          // Container(
          //   padding: const EdgeInsets.only(left: 10.0, right: 10.0),
          //   child: Column(
          //     children: <Widget>[
          //       Row(
          //         children: <Widget>[
          //           const Icon(Icons.work),
          //           const SizedBox(
          //             width: 5.0,
          //           ),
          //           const Text(
          //             'Founder and CEO at',
          //             style: TextStyle(fontSize: 18.0),
          //           ),
          //           const SizedBox(
          //             width: 5.0,
          //           ),
          //           const Text(
          //             'SignBox',
          //             style: TextStyle(
          //                 fontSize: 18.0, fontWeight: FontWeight.bold),
          //           )
          //         ],
          //       ),
          //       const SizedBox(
          //         height: 10.0,
          //       ),
          //       Row(
          //         children: <Widget>[
          //           const Icon(Icons.work),
          //           const SizedBox(
          //             width: 5.0,
          //           ),
          //           const Text(
          //             'Works at',
          //             style: TextStyle(fontSize: 18.0),
          //           ),
          //           const SizedBox(
          //             width: 5.0,
          //           ),
          //           const Text(
          //             'SignBox',
          //             style: TextStyle(
          //                 fontSize: 18.0, fontWeight: FontWeight.bold),
          //           )
          //         ],
          //       ),
          //       const SizedBox(
          //         height: 10.0,
          //       ),
          //       Row(
          //         children: <Widget>[
          //           const Icon(Icons.school),
          //           const SizedBox(
          //             width: 5.0,
          //           ),
          //           const Text(
          //             'Studied Computer Science at',
          //             style: TextStyle(fontSize: 18.0),
          //           ),
          //           const SizedBox(
          //             width: 5.0,
          //           ),
          //         ],
          //       ),
          //       Wrap(
          //         children: <Widget>[
          //           const Text(
          //             'Abc University',
          //             style: TextStyle(
          //                 fontSize: 18.0, fontWeight: FontWeight.bold),
          //           )
          //         ],
          //       ),
          //       const SizedBox(
          //         height: 10.0,
          //       ),
          //       Row(
          //         children: <Widget>[
          //           const Icon(Icons.home),
          //           const SizedBox(
          //             width: 5.0,
          //           ),
          //           const Text(
          //             'Lives in',
          //             style: TextStyle(fontSize: 18.0),
          //           ),
          //           const SizedBox(
          //             width: 5.0,
          //           ),
          //           const Text(
          //             'Pakistan',
          //             style: TextStyle(
          //                 fontSize: 18.0, fontWeight: FontWeight.bold),
          //           )
          //         ],
          //       ),
          //       const SizedBox(
          //         height: 10.0,
          //       ),
          //       Row(
          //         children: <Widget>[
          //           const Icon(Icons.location_on),
          //           const SizedBox(
          //             width: 5.0,
          //           ),
          //           const Text(
          //             'From',
          //             style: TextStyle(fontSize: 18.0),
          //           ),
          //           const SizedBox(
          //             width: 5.0,
          //           ),
          //           const Text(
          //             'Lahore',
          //             style: TextStyle(
          //                 fontSize: 18.0, fontWeight: FontWeight.bold),
          //           )
          //         ],
          //       ),
          //       const SizedBox(
          //         height: 10.0,
          //       ),
          //       Row(
          //         children: const <Widget>[
          //           Icon(Icons.list),
          //           SizedBox(
          //             width: 5.0,
          //           ),
          //           Text(
          //             'Followed by',
          //             style: TextStyle(fontSize: 18.0),
          //           ),
          //           SizedBox(
          //             width: 5.0,
          //           ),
          //           Text(
          //             '100K people',
          //             style: TextStyle(
          //                 fontSize: 18.0, fontWeight: FontWeight.bold),
          //           )
          //         ],
          //       ),
          //       const SizedBox(
          //         height: 20.0,
          //       ),
          //       Row(
          //         children: <Widget>[
          //           Expanded(
          //             child: RaisedButton(
          //               onPressed: () {},
          //               child: Text('see more about Mohsin'),
          //             ),
          //           )
          //         ],
          //       ),
          //       Container(
          //         height: 10.0,
          //         child: const Divider(
          //           color: Colors.grey,
          //         ),
          //       ),
          //       Container(
          //           alignment: Alignment.topLeft,
          //           child: const Text(
          //             'Photos',
          //             style: TextStyle(
          //               fontSize: 30.0,
          //               fontWeight: FontWeight.bold,
          //             ),
          //           )),
          //       Container(
          //         child: Column(
          //           children: <Widget>[
          //             Row(
          //               children: <Widget>[
          //                 Expanded(
          //                     child: Card(
          //                   child: Image.network(
          //                       'https://nation.com.pk/print_images/large/2014-12-28/truck-art-1419719431-3924.png'),
          //                 )),
          //                 Expanded(
          //                     child: Card(
          //                   child: Image.network(
          //                       'https://nation.com.pk/print_images/large/2014-12-28/truck-art-1419719431-3924.png'),
          //                 ))
          //               ],
          //             ),
          //             Row(
          //               children: <Widget>[
          //                 Expanded(
          //                     child: Card(
          //                   child: Image.network(
          //                       'https://nation.com.pk/print_images/large/2014-12-28/truck-art-1419719431-3924.png'),
          //                 )),
          //                 Expanded(
          //                     child: Card(
          //                   child: Image.network(
          //                       'https://nation.com.pk/print_images/large/2014-12-28/truck-art-1419719431-3924.png'),
          //                 )),
          //                 Expanded(
          //                     child: Card(
          //                   child: Image.network(
          //                       'https://nation.com.pk/print_images/large/2014-12-28/truck-art-1419719431-3924.png'),
          //                 ))
          //               ],
          //             )
          //           ],
          //         ),
          //       )
          //     ],
          //   ),
          // )
        ],
      ),
    );
  }

  _showMoreOption(cx) {
    showModalBottomSheet(
      context: cx,
      builder: (BuildContext bcx) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: const <Widget>[
                  Icon(
                    Icons.feedback,
                    color: Colors.black,
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text(
                    'Give feedback or report this profile',
                    style: TextStyle(fontSize: 18.0),
                  )
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: const <Widget>[
                  Icon(
                    Icons.block,
                    color: Colors.black,
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text(
                    'Block',
                    style: TextStyle(fontSize: 18.0),
                  )
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: const <Widget>[
                  Icon(
                    Icons.link,
                    color: Colors.black,
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text(
                    'Copy link to profile',
                    style: TextStyle(fontSize: 18.0),
                  )
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: const <Widget>[
                  Icon(
                    Icons.search,
                    color: Colors.black,
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text(
                    'Search Profile',
                    style: TextStyle(fontSize: 18.0),
                  )
                ],
              ),
            )
          ],
        );
      },
    );
  }
}
