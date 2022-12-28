import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class SignInProvider extends ChangeNotifier {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final FacebookAuth facebookAuth = FacebookAuth.instance;

  bool _hasError = false;
  String? _errorCode;
  String? _uid;
  String? _imageUrl;
  String? _name;
  String? _email;
  String? _provider;

  String? get errorCode => _errorCode;
  bool _isSignedIn = false;

  bool get isSignedIn => _isSignedIn;

  bool get hasError => _hasError;

  String? get uid => _uid;

  String? get imageUrl => _imageUrl;

  String? get name => _name;

  String? get email => _email;

  String? get provider => _provider;

  SignInProvider() {
    checkSignInUser();
  }
  Future checkSignInUser() async {
    final SharedPreferences s = await SharedPreferences.getInstance();
    _isSignedIn = s.getBool('Singed_in') ?? false;
    notifyListeners();
  }

  Future setSignIn() async {
    final s = await SharedPreferences.getInstance();
    s.setBool('Signed_in', true);
    _isSignedIn = true;
    notifyListeners();
  }

  //signIn with google account
  Future signInWithGoogle() async {
    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();
    if (googleSignInAccount != null) {
      try {
        GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );
        //sign in to firebase user instance
        final User userDetails =
            (await firebaseAuth.signInWithCredential(credential)).user!;
        //time to save all the values from the user instance;
        _email = userDetails.email;
        _imageUrl = userDetails.photoURL;
        _name = userDetails.displayName;
        _provider = 'GOOGLE';
        _uid = userDetails.uid;
        notifyListeners();
      } on FirebaseAuthException catch (e) {
        switch (e.code) {
          case "account-exists-with-different-credentials":
            _errorCode =
                "You already have a different account with us;use correct provider";
            _hasError = true;
            notifyListeners();
            break;
          case "null":
            _errorCode = "an unexpected error occured while trying to sign in ";
            _hasError = true;
            notifyListeners();
            break;
          default:
            _errorCode = e.toString();
            _hasError = true;
            notifyListeners();
        }
      }
    } else {
      _hasError = true;
      notifyListeners();
    }
  }

  Future signInWithFacebook() async {
    final LoginResult result = await facebookAuth.login();

    final graphResponse = await http.get(Uri.parse(
        'https://graph.facebook.com/v2.12/me?fields=name,picture.width(800).height(800),first_name,last_name,email&access_token=${result.accessToken?.token}'));
    final profile = jsonDecode(graphResponse.body);
    if (result.status == LoginStatus.success) {
      try {
        final OAuthCredential credential =
            FacebookAuthProvider.credential(result.accessToken!.token);
        await firebaseAuth.signInWithCredential(credential);
        //saving values:
        _name = profile['name'];
        _email = profile['email'];
        _imageUrl = profile['picture']['data']['url'];
        _uid = profile['id'];
        _provider = 'FACEBOOK';
      } on FirebaseException catch (e) {
        switch (e.code) {
          case "account-exists-with-different-credentials":
            _errorCode =
                "You already have a different account with us;use correct provider";
            _hasError = true;
            notifyListeners();
            break;
          case "null":
            _errorCode = "an unexpected error occured while trying to sign in ";
            _hasError = true;
            notifyListeners();
            break;
          default:
            _errorCode = e.toString();
            _hasError = true;
            notifyListeners();
        }
      }
    } else {
      _hasError = true;
      notifyListeners();
    }
  }

  Future<bool> checkUserExist() async {
    DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection('Restaurants')
        .doc(_uid)
        .get();
    if (snapshot.exists) {
      print('Existing user');
      return true;
    } else {
      print('New user');
      return false;
    }
  }

  Future getUserDataFromFirestore(uid) async {
    await FirebaseFirestore.instance
        .collection('Restaurants')
        .doc(uid)
        .get()
        .then((DocumentSnapshot snapshot) => {
              _uid = snapshot['uid'],
              _name = snapshot['name'],
              _email = snapshot['email'],
              _imageUrl = snapshot['image_url'],
              _provider = snapshot['provider']
            });
  }

  Future saveDataToFireStore() async {
    final DocumentReference r =
        FirebaseFirestore.instance.collection('Restaurants').doc(_uid);
    await r.set({
      'uid': _uid,
      'name': _name,
      'email': _email,
      'image_url': _imageUrl,
      'provider': _provider,
    });
    notifyListeners();
  }

  saveUserDataToSharedPrefrences() async {
    final s = await SharedPreferences.getInstance();
    s.setString('name', _name!);
    s.setString('uid', _uid!);
    s.setString('email', _email!);
    s.setString('image_url', _imageUrl!);
    s.setString('provider', _provider!);
    notifyListeners();
  }
}
