import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart'as http;


class Notification1{

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  void sendNotification(List<String> tokens, String title, String body, Map<String, dynamic> payload) async {

    var message = {
      "registration_ids": tokens,
      "data": payload,
      "notification": {
        "title": title,
        "body": body,
        "sound":'images/aiff.aiff'
      },
    };

    var headers = {
      'content-type': 'application/json',
      'Authorization': 'key=AAAAHgXezdQ:APA91bFp5LtxRiYpw_EiJfoiBsVcZ_YL21SGAyKFvTa1IvtcS7Y82iw3dzMjOPfl1Y0gBy0BnGR21v16sfcrnqf4TdosITInYj_7a63Gu7n_tPadLfP_Gn1B9GPO4or1sWEUCpGan3Fk',
    };

    var response = await http.post(
      Uri.parse('https://fcm.googleapis.com/fcm/send'),
      headers: headers,
      body: json.encode(message),
    );

    print(response.statusCode);
    print(response.body);
  }

// void sendNotification(List<String> tokens, String title, String body) async {
//   var message = {
//     "registration_ids": tokens,
//     "notification": {
//       "title": title,
//       "body": body,
//     },
//   };
//
//   var headers = {
//     'content-type': 'application/json',
//     'Authorization': 'key=<YOUR_SERVER_KEY>',
//   };
//
//   var response = await http.post(
//     Uri.parse('https://fcm.googleapis.com/fcm/send'),
//     headers: headers,
//     body: json.encode(message),
//   );
//
//   print(response.statusCode);
//   print(response.body);
// }
}