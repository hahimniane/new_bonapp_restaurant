import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';
import 'dart:async';

import '../../generated/l10n.dart';
import 'home_screen.dart';

class Step2 extends StatefulWidget {
   Step2({
    Key? key,
    required this.email,
    required this.fromSignInPage
  }) : super(key: key);

  final String? email;
 final  bool? fromSignInPage;

  @override
  State<Step2> createState() => _Step2State();
}

class _Step2State extends State<Step2> {
  Timer? _timer;

  void reloadUser() {
    _timer = Timer.periodic(Duration(seconds: 3), (timer) async {
      User? user = await FirebaseAuth.instance.currentUser;
      await user?.reload();
      if (user!.emailVerified) {
        print('the email verification has been verified');
        _timer?.cancel();
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomeScreen()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height -
            MediaQuery.of(context).size.height * 0.12,
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Container(
                height: MediaQuery.of(context).size.height * 0.30,
                child: Lottie.asset('images/data.json')),
            Expanded(
              child: Container(

                width: MediaQuery.of(context).size.width,
                // height:MediaQuery.of(context).height,
                // color: Colors.grey,

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Align(
                      alignment: Alignment.topCenter,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Confirm your email!',
                          style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 60.0, right: 10),
                      child: Align(
                          alignment: Alignment.center,
                          child: RichText(
                            text: TextSpan(
                              style:
                              DefaultTextStyle.of(context).style,
                              children: <TextSpan>[
                                TextSpan(
                                    text:
                                    'We have sent an email to '),
                                TextSpan(
                                  text: ' ${widget.email} ',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    height: 1.5,
                                  ),
                                ),
                                TextSpan(
                                  text:
                                  'so that you  can activate your account.',
                                  style: TextStyle(

                                    height: 1.3,
                                  ),
                                ),
                              ],
                            ),
                          )


                      ),
                    ),

                    Align(
                      alignment: Alignment.topCenter,
                      child: Padding(
                        padding: const EdgeInsets.only(top:18.0),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),),
                          ),
                          onPressed: () {
                            FirebaseAuth auth=FirebaseAuth.instance;
                            // var emailVerifiedListener=auth.authStateChanges().listen((event) {
                            //   print('it is listening');
                            //   if(event!.emailVerified){
                            //     print('the email has been verified');
                            //   }
                            //
                            // });

                            auth.currentUser!.sendEmailVerification().then((value)  {
                              Fluttertoast.showToast(
                                textColor: Colors.white,
                                backgroundColor: Colors.green,
                                gravity: ToastGravity.TOP,
                                msg: S.of(context).emailWasSentString,

                              );
                              _timer?.cancel();
                              reloadUser();


                            });
                          },
                          child: Text('Re-send Email'

                          ),
                        ),
                      ),

                    )



                  ],
                ),
              ),
            )
          ],
        ));
  }

  @override
  void initState() {
    if(widget.fromSignInPage!){
      reloadUser();
    }

  }
}