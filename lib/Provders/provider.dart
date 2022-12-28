import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class MyProvider extends ChangeNotifier {
  Locale _currentLocale = const Locale("fr");
  Locale get currentLocale => _currentLocale;

  late DateTime date;
  String sharedAuth = '';
  upadateSharedAuth(uid) {
    sharedAuth = uid;
    notifyListeners();
  }

  // DateTime date= parseDt;
  updateDate(newDate) {
    date = newDate;
    notifyListeners();
  }

  void changeLocale(String _locale) {
    _currentLocale = Locale(_locale);
    notifyListeners();
  }

  // getLocal() async {
  //   await FirebaseFirestore.instance
  //       .collection('Restaurants')
  //       .doc(FirebaseAuth.instance.currentUser!.uid)
  //       .get()
  //       .then((value) => {
  //             _currentLocale = value['active Locale'],
  //             print('active local is $_currentLocale'),
  //           });
  // }
  bool shouldLoad = false;
  controlIsLoading(isLoading) {
    if (isLoading) {
      shouldLoad = false;
    } else {
      shouldLoad = true;
    }
    notifyListeners();
  }

  BuildContext? _context;
  setContext(context) {
    _context = context;
    notifyListeners();
  }
  //
  // static void setContext(BuildContext context) => FCMProvider._context = context;
  //
  // /// when app is in the foreground
  // static Future<void> onTapNotification(String? payload) async {
  //   if (FCMProvider._context == null || payload == null) return;
  //   final Json _data = FCMProvider.convertPayload(payload);
  //   if (_data.containsKey(...)){
  //     await Navigator.of(FCMProvider._context!).push(...);
  //   }
  // }
}
