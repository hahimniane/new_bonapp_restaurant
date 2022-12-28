import 'dart:async';

import 'package:bonapp_restaurant/Provders/internet_provider.dart';
import 'package:bonapp_restaurant/Provders/provider.dart';
import 'package:bonapp_restaurant/Provders/signInProvider.dart';
import 'package:bonapp_restaurant/Utils/fluttertoast.dart';
import 'package:bonapp_restaurant/Utils/sanckbar.dart';
import 'package:bonapp_restaurant/reset_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:new_version/new_version.dart';
import 'package:provider/provider.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Provders/login_control.dart';
import '../../Utils/next_page.dart';
import '../../averege_price_page.dart';
import '../../generated/l10n.dart';
import '../../services/firbase.dart';

import '../../services/local_auth.dart';
import '../../services/secure_storage.dart';
import 'home_screen.dart';
import 'registration_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  SecureStorage secureStorage = SecureStorage();
  // final GlobalKey scaffoldKey = GlobalKey<ScaffoldState>();

  final RoundedLoadingButtonController googleController =
      RoundedLoadingButtonController();
  final RoundedLoadingButtonController facebookController =
      RoundedLoadingButtonController();

  var phoneAuthController = RoundedLoadingButtonController();

  var otpCodeController = TextEditingController();

  var loginController = RoundedLoadingButtonController();

  bool canSendAnotherUpdateMesaage = false;
  ControlSignIn controlSignIn = ControlSignIn();

  setSharedPrefrences() async {
    String language = 'French';
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    _prefs.setString('language', language);
    if (kDebugMode) {
      print(_prefs.getString('language'));
    }
  }

  String sharedAuth = '';
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firebase = FirebaseFirestore.instance;

  setActiveLanguageToDatabase(language) async {
    await firebase
        .collection('Restaurants')
        .doc(Provider.of<MyProvider>(context, listen: false).sharedAuth)
        .set({'active Locale': language}, SetOptions(merge: true));
  }

  // getLocalFromServer() async {
  //   return await firebase
  //       .collection('Restaurants')
  //       .doc('6AIIwwA2SJcH3X1CTr19Byea4fh1'
  //           //     Provider.of<MyProvider>(context, listen: false
  //           // )
  //           //         .sharedAuth
  //           //         .toString()
  //           )
  //       .get()
  //       .then((value) => {
  //             setState(() {
  //               dropdownValue = value['active Locale'];
  //             })
  //           });
  // }

  List<String> list = <String>['English', 'French'];
  // setSharedLocalPrefrences() async {
  //  final _prefrences=SharedPreferences.getInstance();
  //  await _prefrences.
  //
  // }
  late String dropdownValue = 'French';
  getPrefrenceLanguage() async {
    final _prefrences = await SharedPreferences.getInstance();
    setState(() {
      dropdownValue = _prefrences.getString('language')!;
    });
  }

  static SnackBar activeSnackBar = SnackBar(
      backgroundColor: Colors.deepOrangeAccent,
      elevation: 3,
      content: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Text(
            'Activated',
            style: TextStyle(fontWeight: FontWeight.w400, color: Colors.white),
          ),
          SizedBox(width: 10),
          Icon(
            Icons.done,
            color: Colors.greenAccent,
          ),
        ],
      ));
  static var notActiveSnackBar = SnackBar(
      backgroundColor: Colors.deepOrangeAccent,
      elevation: 3,
      content: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Text('Deactivated', style: TextStyle(color: Colors.white)),
          SizedBox(
            width: 10,
          ),
          Icon(
            Icons.cancel, color: Colors.white,
            // Container(
            //   child: Image(
            //     image: AssetImage('images/Screenshot 2022-11-07 at 11.40.28.png'),
            //   ),
          ),
        ],
      )
      // Text(
      //   ' Activated Successfully',
      //   style: TextStyle(fontWeight: FontWeight.bold),
      // ),
      );

  // String currentActiveLocal = 'English';

  Future<void> _handleRememberMe(bool value) async {
    isActive = value;
    // final flutterSecureStorage = await FlutterSecureStorage();
    //
    // await flutterSecureStorage.write(
    //     key: "remember_me", value: value.toString());
    //
    // await flutterSecureStorage.write(key: 'email', value: emailController.text);
    // // prefs.setString('Language', value)
    // await flutterSecureStorage.write(
    //     key: 'password', value: passwordController.text);
    // if (kDebugMode) {
    //   print(await flutterSecureStorage.read(key: 'email'));
    // }
    // if (kDebugMode) {
    //   print(await flutterSecureStorage.read(key: 'password'));
    // }

    SharedPreferences.getInstance().then(
      (prefs) {
        prefs.setBool("remember_me", value);

        prefs.setString('email', emailController.text);
        // prefs.setString('Language', value)
        prefs.setString('password', passwordController.text);
        if (kDebugMode) {
          print(prefs.get('email'));
        }
        if (kDebugMode) {
          print(prefs.get('password'));
        }
      },
    );
    setState(() {
      isActive = value;
    });
  }

  void _loadUserEmailPassword() async {
    try {
      final flutterSecureStorage = await FlutterSecureStorage();
      SharedPreferences _prefs = await SharedPreferences.getInstance();
      var _email = _prefs.getString("email") ?? "";
      // String _email =
      //     await flutterSecureStorage.read(key: "email").toString() ?? "";
      var _password = _prefs.getString("password") ?? "";
      // String _password =
      //     await flutterSecureStorage.read(key: "password").toString() ?? "";
      // var _remeberMe =
      //     await flutterSecureStorage.read(key: "remember_me") ?? "false";
      var _remeberMe = _prefs.getBool("remember_me") ?? false;
      if (kDebugMode) {
        print(_remeberMe);
      }
      if (kDebugMode) {
        print(_email);
      }
      if (kDebugMode) {
        print(_password);
      }
      if (_remeberMe == true) {
        setState(() {
          isActive = true;
        });
        emailController.text = await _email;
        passwordController.text = await _password;
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  late List<String> myList = [];
  late String community;

  FirebaseAthentications firebaseFunction = FirebaseAthentications();

  // form key
  final _formKey = GlobalKey<FormState>();

  //editing controller
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  //========================= firebase auth function =========================
  // firebase
  final _auth = FirebaseAuth.instance;

  // string for displaying the error Message
  String? errorMessage;

  var isActive = true;

  @override
  Widget build(BuildContext context) {
    //=====================email input filed ==============================//
    // email field
    final emailField = TextFormField(
      autofocus: false,
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value!.isEmpty) {
          return ('Please enter you email');
        }

        // reg expression for email validation
        if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(value)) {
          return ('Please enter a valid email');
        }

        return null;
      },
      //validator: () {},
      onSaved: (value) {
        emailController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: const Icon(Icons.email),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "example@gmail.com",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
    );
    //=====================password input filed ==============================//
    // password field
    final passwordField = TextFormField(
      autofocus: false,
      obscureText: true,
      controller: passwordController,
      keyboardType: TextInputType.visiblePassword,
      validator: (value) {
        RegExp regexp = new RegExp(r'^.{6,}$');
        if (value!.isEmpty) {
          return ('Password is required');
        }

        if (!regexp.hasMatch(value)) {
          return ('Please enter the of six characters');
        }
      },
      //validator: () {},
      onSaved: (value) {
        emailController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: const Icon(Icons.key),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "********",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
    );

    final loginButton = RoundedLoadingButton(
      errorColor: Colors.red,
      successColor: Colors.green,
      color: Colors.deepOrangeAccent,
      width: MediaQuery.of(context).size.width * 0.90,
      controller: loginController,
      onPressed: () {
        if (emailController.text.isEmpty || passwordController.text.isEmpty) {
          openFlutterToast(
              context: context,
              errorMessage: S.of(context).pleaseFillIntheDestinationString);
          loginController.error();
          loginController.reset();
        } else {
          firebaseFunction.signInUser(emailController.text,
              passwordController.text, context, loginController);
        }
      },
      child: Wrap(children: [
        Icon(
          Icons.login_sharp,
        ),
        const SizedBox(
          width: 15,
        ),
        Text(
          S.of(context).loginButtonString,
          textAlign: TextAlign.center,
          style: const TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ]),
    );
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        // key: scaffoldKey,
        appBar: AppBar(
          elevation: 0,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              // Text(
              //   'Choose Language',
              //   style: TextStyle(color: Colors.green),
              // ),
              Card(
                // color: Color(0xfff9812A),
                elevation: 1,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                        padding: const EdgeInsets.only(left: 8.0, right: 30),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: dropdownValue,
                            icon: const Icon(
                              Icons.arrow_drop_down,
                              size: 25,
                              color: Colors.deepOrangeAccent,
                            ),
                            elevation: 16,
                            style: TextStyle(color: Colors.grey.shade800),
                            onChanged: (String? value) {
                              // setActiveLanguageToDatabase(value);
                              setPrefrence(value);
                              setState(() {
                                dropdownValue = value!;
                                // setActiveLanguageToDatabase(value);
                              });
                              if (value == "English") {
                                Provider.of<MyProvider>(context, listen: false)
                                    .changeLocale('en');
                              } else {
                                Provider.of<MyProvider>(context, listen: false)
                                    .changeLocale('fr');
                              }

                              // setState(() {
                              //   if (value == 'English') {
                              //     context.read<MyProvider>().changeLocale('en');
                              //     stateDropdownValue = value!;
                              //   }
                              // });
                              // FirebaseFirestore.instance
                              //     .collection('Restaurants')
                              //     .doc(FirebaseAuth.instance.currentUser!.uid)
                              //     .set({'active Locale': value}, SetOptions(merge: true)).then(
                              //         (value) => {print('successful')});
                              //
                              // setState(() {
                              //   if (value == 'French') {
                              //     context.read<MyProvider>().changeLocale('fr');
                              //   }
                              //   stateDropdownValue = value!;
                              // });
                            },
                            items: list
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(
                                  value,
                                  style: const TextStyle(
                                      color: Colors.deepOrangeAccent,
                                      fontWeight: FontWeight.bold),
                                ),
                              );
                            }).toList(),
                          ),
                        )),
                  ],
                ),
              )
            ],
          ),
          backgroundColor: Colors.white,
        ),
        backgroundColor: Colors.white,
        body: Center(
          child: SingleChildScrollView(
              child: Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    const SizedBox(
                      width: 250,
                      height: 200,
                      child: CircleAvatar(
                        backgroundImage: AssetImage('images/appLogo.png'),
                        radius: 50,
                        backgroundColor: Colors.white,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(15.0),
                      child: Visibility(
                        visible: false,
                        child: Text(
                          'BonApp',
                          style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.w900,
                            color: Colors.deepOrangeAccent,
                            // fontFamily: 'pacifico'
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: emailField,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: passwordField,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 10.0),
                          child: Checkbox(
                              value: isActive,
                              onChanged: (value) {
                                if (value == true) {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(activeSnackBar);
                                } else {
                                  emailController.clear();
                                  passwordController.clear();
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(notActiveSnackBar);
                                }

                                setState(() {
                                  isActive = value!;
                                  _handleRememberMe(value);
                                  // secureStorage.setValue(emailController,
                                  //     passwordController, value);
                                });
                              }),
                        ),
                        Text(S.of(context).rememberMeString),
                        Expanded(
                          child: SizedBox(
                              width: MediaQuery.of(context).size.width * 0.15),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ResetPasswordPage()));
                              },
                              child: Text('Forgot Password?')),
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: loginButton,
                    ),
                    // TextButton(
                    //   onPressed: () async {
                    //     if (await LocalAuth.authenticate()) {
                    //       SharedPreferences prefs =
                    //           await SharedPreferences.getInstance();
                    //       if (prefs.getString('email') != null &&
                    //           prefs.getString('password') != null) {
                    //         firebaseFunction.signInUser(
                    //           prefs.getString('email')!,
                    //           prefs.getString('password')!,
                    //           context,
                    //         );
                    //       } else {
                    //         print('it was here');
                    //         openSnackBar(context,
                    //             'Login using email and password', Colors.red);
                    //       }
                    //     }
                    //   },
                    //   child: Text('Authenticate with biometrics'),
                    // ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(S.of(context).dontHaveAccountString),
                        GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => RegistrationScreen(
                                            ourList: myList,
                                            theFirstCommunity: 'Almamya',
                                          )));
                            },
                            child: Text(
                              S.of(context).signUpButtonString,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: Colors.deepOrangeAccent,
                                  decoration: TextDecoration.underline),
                            ))
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    // RoundedLoadingButton(
                    //   controller: phoneAuthController,
                    //   onPressed: () {
                    //     login(context);
                    //   },
                    //   child: Center(
                    //     child: Wrap(children: const [
                    //       Icon(
                    //         FontAwesomeIcons.phone,
                    //       ),
                    //       SizedBox(
                    //         width: 16,
                    //       ),
                    //       Text('Signin with phone')
                    //     ]),
                    //   ),
                    // ),
                    // Column(
                    //   children: [
                    //     RoundedLoadingButton(
                    //         width: MediaQuery.of(context).size.width * 0.80,
                    //         elevation: 0,
                    //         color: Colors.red,
                    //         successColor: Colors.deepOrangeAccent,
                    //         controller: googleController,
                    //         onPressed: () {
                    //           _handleGoogleSignIn();
                    //         },
                    //         child: Wrap(
                    //           children: const [
                    //             Icon(
                    //               FontAwesomeIcons.google,
                    //               color: Colors.white,
                    //               size: 20,
                    //             ),
                    //             SizedBox(
                    //               width: 15,
                    //             ),
                    //             Text(
                    //               'Sign In with Google',
                    //               style: TextStyle(fontWeight: FontWeight.w500),
                    //             )
                    //           ],
                    //         )),
                    //     const SizedBox(
                    //       height: 10,
                    //     ),
                    //     RoundedLoadingButton(
                    //       width: MediaQuery.of(context).size.width * 0.80,
                    //       elevation: 0,
                    //       color: Colors.lightBlue,
                    //       successColor: Colors.deepOrangeAccent,
                    //       controller: facebookController,
                    //       onPressed: () {
                    //         _handleFacebookSignIn();
                    //       },
                    //       child: Wrap(
                    //         children: const [
                    //           Icon(
                    //             FontAwesomeIcons.facebook,
                    //             color: Colors.white,
                    //             size: 20,
                    //           ),
                    //           SizedBox(
                    //             width: 15,
                    //           ),
                    //           Text(
                    //             'Sign In with Facebook',
                    //             style: TextStyle(
                    //               fontWeight: FontWeight.w500,
                    //             ),
                    //           )
                    //         ],
                    //       ),
                    //     ),
                    //   ],
                    // )
                  ],
                ),
              ),
            ),
          )),
        ),
      ),
    );
  }

// login function
  void signIn(String email, String password) async {
    EasyLoading.show(indicator: CircularProgressIndicator());
    if (_formKey.currentState!.validate()) {
      try {
        await _auth
            .signInWithEmailAndPassword(email: email, password: password)
            .then((uid) => {
                  Fluttertoast.showToast(msg: "Login Successful"),
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => HomeScreen())),
                });
      } on FirebaseAuthException catch (error) {
        switch (error.code) {
          case "invalid-email":
            errorMessage = "Your email address appears to be invalid.";

            break;
          case "wrong-password":
            errorMessage = "Your password is wrong.";
            break;
          case "user-not-found":
            errorMessage = "User with this email doesn't exist.";
            break;
          case "user-disabled":
            errorMessage = "User with this email has been disabled.";
            break;
          case "too-many-requests":
            errorMessage = "Too many requests";
            break;
          case "operation-not-allowed":
            errorMessage = "Signing in with Email and Password is not enabled.";
            break;
          default:
            errorMessage = "An undefined Error happened.";
        }
        Fluttertoast.showToast(msg: errorMessage!);
        print(error.code);
      }
    }
  }

  Timer? timer;
  // this function is a timer that when a user has not gotten the latest version of the app. it remindes them every 10 minutes that they are using the app
  timerFunctionForUpdateReminder() {
    newVersions();
    Timer.periodic(Duration(minutes: 10), (timer) {
      timer = timer;
      if (controlSignIn.canSendAnotherUpdateMessage) {
        newVersions();
        controlSignIn.controlSendAnotherUpdateMesaage(false);

        print('coming from the timer');
      }
    });
  }

  setPrefrence(value) async {
    String language = value ?? 'French';
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('language', language);
    print(prefs.get('language'));
  }

// this below method is useed to check if the user has the latest app version. if they have the latest they be reminded if not it doesnt get run
  newVersions() async {
    final newVersion = NewVersion();

    final status = await newVersion.getVersionStatus();

    print('can update: ${status?.canUpdate}');
    print('local version ${status?.localVersion}');
    print('store version ${status?.storeVersion}');

    print(status?.storeVersion);
    print(status?.appStoreLink);
    if (status!.localVersion != status.storeVersion) {
      newVersion.showUpdateDialog(
          context: context,
          versionStatus: status,
          dialogTitle: 'Update Available',
          dialogText:
              'You can now update this app from ${status.localVersion} to ${status.storeVersion}',
          updateButtonText: 'Update',
          dismissButtonText: 'Dismiss',
          dismissAction: () => {
                setState(() {
                  controlSignIn.controlSendAnotherUpdateMesaage(true);
                  canSendAnotherUpdateMesaage = true;
                  print('the active is ${canSendAnotherUpdateMesaage}');
                }),
                Navigator.pop(context)
              });
    }

    // if (status!.localVersion != status.storeVersion) {
    //   newVersion.launchAppStore(status.appStoreLink.toString());
    // }

    // var localVersion = status?.localVersion; // (1.2.1)
    // var storeVersion = status?.storeVersion; // (1.2.3)
    // var appStroeLink = status?.appStoreLink;
  }

  @override
  initState() {
    // timerFunctionForUpdateReminder();
    // newVersions();
    // getUidPrefrence();
    print('the shared auth Unupdated is $sharedAuth');
    // getUidPrefrence();
    // setPrefrence();
    getPrefrenceLanguage();
    setPrefrence(null);
    super.initState();

    // getLocalFromServer();
    _loadUserEmailPassword();
    // getSecureData();
  }

  getSecureData() async {
    // if (await secureStorage.readValue()) {
    setState(() {
      emailController.text = secureStorage.emailController!.text;
      passwordController.text = secureStorage.passwordController!.text;
    });
    // }
  }

//
  Future _handleGoogleSignIn() async {
    final sp = context.read<SignInProvider>();
    final ip = context.read<InternetProvider>();
    await ip.checkInternetConnection();
    if (!ip.hasInternet) {
      openSnackBar(
        context,
        'Check your internet connection',
        Colors.red,
      );
      googleController.reset();
    } else {
      await sp.signInWithGoogle().then((value) => {
            if (sp.hasError)
              {
                openSnackBar(
                  context,
                  sp.errorCode.toString(),
                  Colors.red,
                ),
                googleController.reset(),
              }
            else
              {
                //checking whether user exists or not
                sp.checkUserExist().then((value) async {
                  if (value == true) {
                    await sp
                        .getUserDataFromFirestore(sp.uid)
                        .then((value) => sp.saveUserDataToSharedPrefrences())
                        .then(
                          (value) => sp.setSignIn().then((value) => {
                                googleController.success(),
                                handleAfterSignIin(HomeScreen()),
                              }),
                        );
                    //user exists
                  } else {
                    sp
                        .saveDataToFireStore()
                        .then((value) => sp.saveUserDataToSharedPrefrences())
                        .then((value) => sp.setSignIn())
                        .then((value) => {
                              googleController.success(),
                              handleAfterSignIin(AveragePricePage()),
                            });
                  }
                })
              }
          });
    }
  }

  Future _handleFacebookSignIn() async {
    final sp = context.read<SignInProvider>();
    final ip = context.read<InternetProvider>();
    await ip.checkInternetConnection();
    if (!ip.hasInternet) {
      openSnackBar(
        context,
        'Check your internet connection',
        Colors.red,
      );
      facebookController.reset();
    } else {
      await sp.signInWithFacebook().then((value) => {
            if (sp.hasError)
              {
                openSnackBar(
                  context,
                  sp.errorCode.toString(),
                  Colors.red,
                ),
                facebookController.reset(),
              }
            else
              {
                //checking whether user exists or not
                sp.checkUserExist().then((value) async {
                  if (value == true) {
                    //user exists
                    await sp
                        .getUserDataFromFirestore(sp.uid)
                        .then((value) => sp.saveUserDataToSharedPrefrences())
                        .then(
                          (value) => sp.setSignIn().then((value) => {
                                facebookController.success(),
                                handleAfterSignIin(const HomeScreen()),
                              }),
                        );
                    //user exists
                  } else {
                    sp
                        .saveDataToFireStore()
                        .then((value) => sp.saveUserDataToSharedPrefrences())
                        .then((value) => sp.setSignIn())
                        .then((value) => {
                              facebookController.success(),
                              handleAfterSignIin(const AveragePricePage()),
                            });
                  }
                })
              }
          });
    }
  }

  handleAfterSignIin(screen) {
    Future.delayed(const Duration(seconds: 1))
        .then((value) => {nextScreen(context, screen)});
  }

  Future login(BuildContext context) async {
    print('clicked');
    final sp = context.read<SignInProvider>();
    final ip = context.read<InternetProvider>();
    await ip.checkInternetConnection();
    if (ip.hasInternet) {
      FirebaseAuth.instance.verifyPhoneNumber(
          phoneNumber: '+905541524403',
          verificationCompleted: (AuthCredential credential) async {
            await FirebaseAuth.instance.signInWithCredential(credential);
          },
          verificationFailed: (FirebaseException e) {
            phoneAuthController.reset();
            print(e.message.toString());
            openSnackBar(context, e.toString(), Colors.red);
          },
          codeSent: (String verificationId, int? forceResendingtoken) {
            print('the verification id is ' + verificationId);
            showDialog(
                barrierDismissible: false,
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text('Enter code'),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextField(
                          controller: otpCodeController,
                          decoration: InputDecoration(
                              prefixIcon: const Icon(FontAwesomeIcons.code),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(
                                  color: Colors.red,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide:
                                      const BorderSide(color: Colors.grey))),
                        ),
                        SizedBox(
                          height: 15,
                        )
                      ],
                    ),
                  );
                });
          },
          codeAutoRetrievalTimeout: (String verification) {});
    } else {
      openSnackBar(context, 'Please your connection', Colors.red);
      print('came to retrieve the number');
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();

    if (timer!.isActive) {
      timer?.cancel();
    }

    print('the timer has been cancelled');
  }
}

// class DropDownLanguage extends StatefulWidget {
//   String dropDownValue;
//   DropDownLanguage({Key? key, required this.dropDownValue}) : super(key: key);
//
//   @override
//   State<DropDownLanguage> createState() => _DropDownLanguageState();
// }
//
// class _DropDownLanguageState extends State<DropDownLanguage> {
//   late String stateDropdownValue;
//
//   @override
//   void initState() {
//     super.initState();
//     stateDropdownValue = widget.dropDownValue;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return DropdownButtonHideUnderline(
//       child: DropdownButton<String>(
//         value: stateDropdownValue,
//         icon: const Icon(
//           Icons.arrow_drop_down,
//           size: 25,
//           color: Colors.deepOrangeAccent,
//         ),
//         elevation: 16,
//         style: TextStyle(color: Colors.grey.shade800),
//         onChanged: (String? value) {
//           widget.dropDownValue = value!;
//           // setState(() {
//           //   if (value == 'English') {
//           //     context.read<MyProvider>().changeLocale('en');
//           //     stateDropdownValue = value!;
//           //   }
//           // });
//           // FirebaseFirestore.instance
//           //     .collection('Restaurants')
//           //     .doc(FirebaseAuth.instance.currentUser!.uid)
//           //     .set({'active Locale': value}, SetOptions(merge: true)).then(
//           //         (value) => {print('successful')});
//           //
//           // setState(() {
//           //   if (value == 'French') {
//           //     context.read<MyProvider>().changeLocale('fr');
//           //   }
//           //   stateDropdownValue = value!;
//           // });
//         },
//         items: list.map<DropdownMenuItem<String>>((String value) {
//           return DropdownMenuItem<String>(
//             value: value,
//             child: Text(
//               widget.dropDownValue,
//               style: const TextStyle(
//                   color: Colors.deepOrangeAccent, fontWeight: FontWeight.bold),
//             ),
//           );
//         }).toList(),
//       ),
//     );
//   }
// }
