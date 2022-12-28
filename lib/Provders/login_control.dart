import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../From_Sulaiman/screens/home_screen.dart';

class ControlSignIn extends ChangeNotifier {
  bool _isSignedIn = false;

  bool get isSignedIn => _isSignedIn;

  signInKey(bool key) {
    _isSignedIn = key;
    notifyListeners();
  }

  bool canSendAnotherUpdateMessage = false;
  controlSendAnotherUpdateMesaage(bool value) {
    canSendAnotherUpdateMessage = value;
    print('now the active value has turned to ${canSendAnotherUpdateMessage}');
    notifyListeners();
  }

  controlSignIn() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        _isSignedIn = false;
      } else {
        _isSignedIn = true;
      }
    });

    // if (_isSignedIn) {
    //   Navigator.pushReplacement(
    //       context, MaterialPageRoute(builder: (context) => HomeScreen()));
    // } else {}
    notifyListeners();
  }
}
