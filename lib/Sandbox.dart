import 'package:bonapp_restaurant/notification_badge.dart';
import 'package:bonapp_restaurant/push_notification.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

import 'dart:convert' show json;

import 'From_Sulaiman/components/orders.dart';

Future _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // return
}

class SandBox extends StatefulWidget {
  const SandBox({Key? key}) : super(key: key);

  @override
  State<SandBox> createState() => _SandBoxState();
}

class _SandBoxState extends State<SandBox> {
  FCMNotificationService service = FCMNotificationService();
  final String hashimPhoneToken =
      'dYit65-yQ0GUl3ZjVCSO-E:APA91bFUugE4mEiK9RHfp-ymdIeLhaEbhf89LLJWak0b2fr8JShPkySBeYeiWnqPEuFP8__THJmZ2bkUYwE7pF81issq9ZrCZiMKMm_c1DvsZQB9FdrSh3vH-ImgGZhZaFGQBpUaI17X';
  late int _totalNotification;
  late final FirebaseMessaging _messaging;
  PushNotification? _notificationInfo;

  Future<void> requestAndRegisterNotifications() async {
    //initialize the Firebase App
    await Firebase.initializeApp();
    //Instantiate Firebase Messaging;
    _messaging = FirebaseMessaging.instance;

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('Just received a notification when app is opened');

      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const Order()));
//       showNotification(message, context);
//       if(message.notification != null){
// //"route" will be your root parameter you sending from firebase
//         final routeFromNotification = message.data["route"];
//         if (routeFromNotification != null) {
//           routeFromNotification == "profile"?
//           Navigator.of(context).pushNamed('profile')
//         }
//         else {
//           developer.log('could not find the route');
//         }
//       }
    });
    // on Ios, this helps to take the user permissions out of the user
    NotificationSettings settings = await _messaging.requestPermission(
        alert: true, badge: true, provisional: false, sound: true);
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('permission granted');
      String? token = await _messaging.getToken();
      // FirebaseFirestore _firestore = FirebaseFirestore.instance;

      print('the token is $token');
      //for handling  the received Notification
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
          alert: true, // Required to display a heads up notification
          badge: true,
          sound: true,
        );
        //parse the message received
        PushNotification notification = PushNotification(
          title: message.notification?.title,
          body: message.notification?.body,
        );
        setState(() {
          _notificationInfo = notification;
          _totalNotification++;
        });
        if (_notificationInfo != null) {
          //for displaying the notification as an overlay
          showSimpleNotification(
            Text(_notificationInfo!.title!),
            leading: NotificationBadge(totalNotification: _totalNotification),
            subtitle: Text(_notificationInfo!.body!),
            background: Colors.cyan.shade700,
            duration: const Duration(seconds: 10),
          );
        }
      });
    }
  }

  @override
  void initState() {
    requestAndRegisterNotifications();
    _totalNotification = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notify'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'App for capturing Firebase Push Notification',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          NotificationBadge(totalNotification: _totalNotification),
          _notificationInfo != null
              ? Column(
                  children: [
                    Text(
                      'Title ${_notificationInfo!.title!}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      'Title ${_notificationInfo!.body!}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    )
                  ],
                )
              : Container(),
          ElevatedButton(
            onPressed: () {
              service.sendNotificationToUser(
                  fcmToken: hashimPhoneToken,
                  title: 'test token',
                  body: 'the test from the emulator');
            },
            child: Text('Send Notification to hashim'),
          )
        ],
      ),
    );
  }
}

abstract class IFCMNotificationService {
  Future<void> sendNotificationToUser({
    required String fcmToken,
    required String title,
    required String body,
  });
  Future<void> sendNotificationToGroup({
    required String group,
    required String title,
    required String body,
  });
  Future<void> unsubscribeFromTopic({
    required String topic,
  });
  Future<void> subscribeToTopic({
    required String topic,
  });
}

class FCMNotificationService extends IFCMNotificationService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final String _endpoint = 'https://fcm.googleapis.com/fcm/send';
  final String _contentType = 'application/json';
  final String _authorization =
      'key=AAAAHgXezdQ:APA91bFp5LtxRiYpw_EiJfoiBsVcZ_YL21SGAyKFvTa1IvtcS7Y82iw3dzMjOPfl1Y0gBy0BnGR21v16sfcrnqf4TdosITInYj_7a63Gu7n_tPadLfP_Gn1B9GPO4or1sWEUCpGan3Fk';

  Future<http.Response> _sendNotification(
    String to,
    String title,
    String body,
  ) async {
    try {
      final dynamic data = json.encode(
        {
          'to': to,
          'priority': 'high',
          'notification': {
            'title': title,
            'body': body,
            // 'icon':
            //     'https://cdn4.iconfinder.com/data/icons/ionicons/512/icon-image-512.png',
            "sound": "default",
          },
          'content_available': true
        },
      );
      http.Response response = await http.post(
        Uri.parse(_endpoint),
        body: data,
        headers: {
          'Content-Type': _contentType,
          'Authorization': _authorization
        },
      );
      print('message was sent succesffuly');
      return response;
    } catch (error) {
      throw Exception(error);
    }
  }

  @override
  Future<void> unsubscribeFromTopic({required String topic}) {
    return _firebaseMessaging.unsubscribeFromTopic(topic);
  }

  @override
  Future<void> subscribeToTopic({required String topic}) {
    return _firebaseMessaging.subscribeToTopic(topic);
  }

  @override
  Future<void> sendNotificationToUser({
    required String fcmToken,
    required String title,
    required String body,
  }) {
    print('entered here');
    return _sendNotification(
      fcmToken,
      title,
      body,
    );
  }

  @override
  Future<void> sendNotificationToGroup(
      {required String group, required String title, required String body}) {
    return _sendNotification('/topics/' + group, title, body);
  }
}
