import 'dart:math';

import 'package:twilio_flutter/twilio_flutter.dart';
import 'package:twilio_phone_verify/twilio_phone_verify.dart';

class Twilio {
  // final client = TwilioFlutter(
  //     accountSid: 'AC913a8a7170c034176dd38a1969d17f1e',
  //     authToken: 'bceff51be8fdd663b1550ca6385d99dc',
  //     twilioNumber: '+14793973708');
  final auth = TwilioPhoneVerify(
      accountSid: 'AC913a8a7170c034176dd38a1969d17f1e',
      serviceSid: 'VAb9909d37304221496f34dd1b0591b29c',
      authToken: "bceff51be8fdd663b1550ca6385d99dc");

  // final seconClient = Twilio();
  // sendMessage() {
  //   try {
  //     client.sendSMS(
  //         toNumber: '+905541524403', messageBody: 'Hello coming from Twilio');
  //   } catch (e) {
  //     print(e.toString());
  //   }
  // }

  // getSentMessages() {
  //   client.getSmsList();
  // }
  verify() async {
    try {
      TwilioResponse result =
          await auth.verifySmsCode(phone: "+905541524403", code: "9230");
      if (result.successful!) {
        print('the numebr is true');
      } else {
        print('not true');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  sendPhoneVerificationCode() async {
    try {
      await auth.sendSmsCode('+905541524403').then((value) => {
            print('succeessfully sent'),
          });
    } catch (e) {
      print(e.toString());
    }
  }
}
