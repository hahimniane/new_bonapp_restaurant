import 'dart:async';

import 'dart:convert' show json;
import 'package:bonapp_restaurant/From_Sulaiman/screens/login_screen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

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

class FCMNotificationServices extends IFCMNotificationService {
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
            'sound': 'default',
          },
          'content_available': true,
          'data': {
            "payload": {
              "secret": "Awesome Notifications Rocks!",
              "name:": "LoginScreen"
            }
          },
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
      // print('message was sent succesffuly');
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
    return _sendNotification(
      'dhu_yv0PzUeZj5N-zuPS4a:APA91bH6AiTXBP1HTDuwSxLGK_FQSgtjGLTQdySt-3ZoATimGqoYk7vf1E8uQIICDXwAKGn0cBFp4s5dvsQBcgXPbnhhqxXuu4ZFxyb-nHb9XF3zjFADDK7Co0K--xy3lKF9A4Wz1SHC',
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
