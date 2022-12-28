import 'package:bonapp_restaurant/Provders/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../generated/l10n.dart';
import 'addtional_chat.dart';
import 'call_page.dart';

class SupportPage extends StatefulWidget {
  const SupportPage({Key? key}) : super(key: key);

  @override
  _SupportPageState createState() => _SupportPageState();
}

class _SupportPageState extends State<SupportPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Get Help'),
      // ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,

          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16),
              child: Text(S.of(context).assistString,
                  style: const TextStyle(
                    color: Colors.deepOrangeAccent,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  )),
            ),
            const SizedBox(
              height: 10,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => CallPage()));
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 3.0,
                        ),
                        child: Icon(
                          Icons.phone,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(S.of(context).getHelpWithPhoneCallString,
                          style: Provider.of<MyProvider>(context, listen: true)
                                      .currentLocale
                                      .toString() ==
                                  'en'
                              ? TextStyle(
                                  fontSize: 18,
                                  color: Colors.grey.shade700,
                                )
                              : TextStyle(
                                  fontSize: 13,
                                  color: Colors.grey.shade700,
                                )),
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.only(right: 5.0),
                    child: Icon(
                      Icons.arrow_forward_ios_outlined,
                      color: Colors.deepOrangeAccent,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Container(
                  height: 1,
                  decoration: BoxDecoration(
                      color: Colors.green,
                      border: Border.all(color: Colors.grey))),
            ),
            const SizedBox(
              height: 40,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ChatPages()));
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 3.0,
                        ),
                        child: Icon(
                          Icons.chat,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(S.of(context).chatWithRepresentativeString,
                          style: Provider.of<MyProvider>(context, listen: true)
                                      .currentLocale
                                      .toString() ==
                                  'en'
                              ? TextStyle(
                                  fontSize: 18,
                                  color: Colors.grey.shade700,
                                )
                              : TextStyle(
                                  fontSize: 13,
                                  color: Colors.grey.shade700,
                                )),
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.only(right: 5.0),
                    child: Icon(
                      Icons.arrow_forward_ios_outlined,
                      color: Colors.deepOrangeAccent,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Container(
                  height: 1,
                  decoration: BoxDecoration(
                      color: Colors.green,
                      border: Border.all(color: Colors.grey))),
            )
          ],
        ),
      ),
    );
  }
}
