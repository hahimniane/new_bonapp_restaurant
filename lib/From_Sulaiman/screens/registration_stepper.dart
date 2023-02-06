import 'dart:async';

import 'package:bonapp_restaurant/From_Sulaiman/screens/home_screen.dart';
import 'package:bonapp_restaurant/From_Sulaiman/screens/registration_screen.dart';

import 'package:bonapp_restaurant/services/firbase.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../../Provders/provider.dart';

import '../../generated/l10n.dart';
import 'step2.dart';

class SignUpStepper extends StatefulWidget {
  const SignUpStepper({Key? key}) : super(key: key);

  @override
  State<SignUpStepper> createState() => _SignUpStepperState();
}

class _SignUpStepperState extends State<SignUpStepper> {
  String? email;

  DateTime? _selectedDate;

  RoundedLoadingButtonController nextButtonController =
      RoundedLoadingButtonController();

  void _updateEmail(String email) {
    setState(() {
      this.email = email;
    });
  }


  bool dateErrorVisible = false;
  int _currentStep = 0;

  var _step1Completed = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stepper(
          onStepContinue: () async {
            validateAndSignupUser();
          },
          controlsBuilder: (BuildContext context, ControlsDetails details) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                TextButton(
                  onPressed: details.onStepCancel,
                  child: Text(details.currentStep == 1 ? S.of(context).backString : ''),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 2.5),
                  child: RoundedLoadingButton(
                    borderRadius: 10,
                    elevation: 0,
                    width: MediaQuery.of(context).size.width * 0.20,
                    height: MediaQuery.of(context).size.height * 0.04,
                    color: Colors.deepOrange,

                    onPressed: details.onStepContinue,
                    controller: nextButtonController,
                    child: Text(
                      details.currentStep == 1 ? S.of(context).resendString : S.of(context).continueString,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                ),
              ],
            );
          },
          elevation: 4,
          margin: EdgeInsets.zero,
          currentStep: _currentStep,
          onStepTapped: (step) {
            setState(() {
              if (step == 1 && _currentStep != 1) {
                validateAndSignupUser();


              }
              if (step == 0) {
                print('going to step $_currentStep');
                _currentStep = step;
              }


            });
          },
          type: StepperType.horizontal,
          steps: [
            Step(

              state: _currentStep == 0 ? StepState.indexed : StepState.complete,

              content: SafeArea(
                child: Container(
                  // color: Colors.green,
                    height: MediaQuery.of(context).size.height *0.76,
                    child: RegistrationScreen(
                      updateEmail: _updateEmail,
                      dateErrorVisible: false,
                    ),),
              ),
              isActive: _currentStep == 0, title: Text(''),
            ),
            Step(
              title: Text(''),
              content: Step2(email: email,fromSignInPage: false,),
              isActive: _currentStep == 1,
            ),
          ],
          physics: _currentStep == 0
              ? AlwaysScrollableScrollPhysics()
              : NeverScrollableScrollPhysics(),
        ),
      ),
    );
  }

  FirebaseAuth auth = FirebaseAuth.instance;
  User? user;
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
  void dispose() {
    super.dispose();
    // _timer?.cancel();
    print('the timer has has been canceled');
  }

  @override
  void initState() {}

  Future<void> validateAndSignupUser() async {
    if (_currentStep == 0) {
      if (formKey.currentState!.validate()) {
        FirebaseAuthentications firebase = FirebaseAuthentications();
        bool result = await firebase.SignUpUser(
            context: context,
            email: email!,
            password: password.text,
            userName: restaurantName.text,
            fullAddress: restaurantFullAddress.text,
            phoneNumber: restaurantPhoneNumber.text,
            community: community!,
            restaurantFoundationDate:
                Provider.of<MyProvider>(context, listen: false).date,
            position: await getLocation(),
            averageTime: selectedAverageTime,
            averagePrice: selectedAveragePrice,
            controller: nextButtonController);

        if (result) {
          reloadUser();
          setState(() {
            _currentStep = 1;
          });
        } else {
          print('exception happened');
          nextButtonController.reset();
        }
      } else {
        nextButtonController.error();
        await Future.delayed(Duration(
          milliseconds: 500,
        ));
        nextButtonController.reset();
      }
    } else {
      print('at the final stage');
    }
  }
}
