// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAhAzV7s1_JJAPwXbOHWHPcRzMfvXBnn1I',
    appId: '1:128947506644:android:7ad81c5ff2a51ace185a41',
    messagingSenderId: '128947506644',
    projectId: 'yemeksepeti-f4347',
    storageBucket: 'yemeksepeti-f4347.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCaegRCQi5BHCD1Vneil7DcT4YT2dFkPhw',
    appId: '1:128947506644:ios:3e20ff95c49c18ff185a41',
    messagingSenderId: '128947506644',
    projectId: 'yemeksepeti-f4347',
    storageBucket: 'yemeksepeti-f4347.appspot.com',
    androidClientId:
        '128947506644-5nk32ppre7auv4madbcjv0jdajrgcpqa.apps.googleusercontent.com',
    iosClientId:
        '128947506644-bfcdv0tv8jj7fldkvjbj4fpsrt7lu3q7.apps.googleusercontent.com',
    iosBundleId: 'com.hashimniane.bonappRestaurant',
  );
}