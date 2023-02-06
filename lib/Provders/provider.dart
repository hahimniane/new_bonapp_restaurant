import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class MyProvider extends ChangeNotifier {
  bool userEmailIsVerified=false;

  handleUserEmailIsVerified(isVerified){
    userEmailIsVerified=isVerified;
    print('the user email verification is currently set to $userEmailIsVerified');
  }

  Locale _currentLocale = const Locale("fr");
  Locale get currentLocale => _currentLocale;

   DateTime? date;
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

}
