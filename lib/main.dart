import 'package:bonapp_restaurant/Provders/calculate_price_provider.dart';
import 'package:bonapp_restaurant/Provders/internet_provider.dart';
import 'package:bonapp_restaurant/Provders/signInProvider.dart';
import 'package:bonapp_restaurant/Sandbox.dart';

import 'package:bonapp_restaurant/push_notification.dart';

import 'package:bonapp_restaurant/Provders/provider.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'From_Sulaiman/screens/home_screen.dart';
import 'From_Sulaiman/screens/login_screen.dart';
import 'Provders/login_control.dart';

import 'average_time_page.dart';
import 'averege_price_page.dart';
import 'bot.dart';
import 'firebase_options.dart';
import 'generated/l10n.dart';

import 'ibo.dart';
import 'notification_badge.dart';

Future _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print('${message.data['data']['payload']}');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isSignedIn = false;

  final List<AppLifecycleState> _stateHistoryList = <AppLifecycleState>[];

  bool get isSignedIn => _isSignedIn;

  controlSignIn() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      print('something changed');
      if (user == null) {
        _isSignedIn = false;
      } else {
        _isSignedIn = true;
      }
    });
  }

  String uid = '6AIIwwA2SJcH3X1CTr19Byea4fh1';
  getUidPrefrence() async {
    // print(

    final prefs = await SharedPreferences.getInstance();
    setState(() {
      uid = prefs.get('documentId').toString();
    });
  }

  FCMNotificationService service = FCMNotificationService();
  final String hashimPhoneToken =
      'dYit65-yQ0GUl3ZjVCSO-E:APA91bFUugE4mEiK9RHfp-ymdIeLhaEbhf89LLJWak0b2fr8JShPkySBeYeiWnqPEuFP8__THJmZ2bkUYwE7pF81issq9ZrCZiMKMm_c1DvsZQB9FdrSh3vH-ImgGZhZaFGQBpUaI17X';
  late int _totalNotification;
  late final FirebaseMessaging _messaging;
  PushNotification? _notificationInfo;
  FirebaseAuth auth = FirebaseAuth.instance;
  Future<void> requestAndResgisterNotifications() async {
    await Firebase.initializeApp();
    //Instantiate Firebase Messaging;
    _messaging = FirebaseMessaging.instance;

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('Just received a notification when app is opened');
      print('${message.data['data']['payload']}');
      print('${message.data}');
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
        print(message.data);
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

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => CalculatePriceProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => MyProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => InternetProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => SignInProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ControlSignIn(),
        ),
      ],
      child: Builder(builder: (context) {
        return OverlaySupport.global(
          child: MaterialApp(
            builder: EasyLoading.init(),
            locale:
                // Locale('fr'),
                Provider.of<MyProvider>(context, listen: true).currentLocale,
            localizationsDelegates: const [
              S.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: S.delegate.supportedLocales,
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: Colors.deepOrange,
              brightness: Brightness.light,
              primaryColor: Colors.deepOrange[800],
            ),
            home: FirebaseAuth.instance.currentUser != null
                ? HomeScreen()
                : LoginScreen(),
          ),
        );
      }),
    );
  }

  getInfo() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    print('the app name is ${packageInfo.appName} ,\n'
        '      the app version is ${packageInfo.version}');
  }

  @override
  void initState() {
    getUidPrefrence();
    super.initState();
    requestAndResgisterNotifications();
    _totalNotification = 0;
    controlSignIn();
    // Provider.of<ControlSignIn>(context, listen: false).controlSignIn();
  }
}
