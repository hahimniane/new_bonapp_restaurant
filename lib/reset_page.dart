import 'package:bonapp_restaurant/services/firbase.dart';
import 'package:flutter/material.dart';


import 'components/methods.dart';

class ResetPasswordPage extends StatelessWidget {
  ResetPasswordPage({Key? key}) : super(key: key);
  TextEditingController userNameOrEmail = TextEditingController();
  FirebaseAuthentications firebaseAthentications = FirebaseAuthentications();
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          //ToDO: add translation for this page. and a remainder the email has not been received so far. so there is a bug somether. handle it after
          'Login',
          style:  TextStyle(
                color: Colors.white,
                letterSpacing: .20,
                fontWeight: FontWeight.w900),

        ),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: height * 0.02,
            ),
            buildTextField(
                width, height, 'example@gmail.com', 0.070, userNameOrEmail),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: SizedBox(
                child: buildTextButton(() async {
                  firebaseAthentications.resetPassword(userNameOrEmail.text);
                }, const Color(0xff2ACB81), 'SEND'),
                width: width * 0.95,
                height: height * 0.054,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
