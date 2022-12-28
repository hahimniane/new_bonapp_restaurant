import 'package:flutter/widgets.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  final storage = FlutterSecureStorage();
  TextEditingController? emailController;
  TextEditingController? passwordController;
  setValue(
      TextEditingController email, TextEditingController password, bool value) {
    if (value) {
      storage.write(key: 'remember me', value: value.toString());
      storage.write(key: 'email', value: email.text);
      storage.write(key: 'password', value: password.text);
      print(
          'the email ${email.text} and the password ${password.text} has been successfully saved to the safe storage');
    }
  }

  Future<bool> readValue() async {
    if (storage.read(key: 'remember me') == true) {
      emailController?.text = (await storage.read(key: 'email'))!;
      passwordController?.text = (await storage.read(key: 'password'))!;
      print(
          'the values has been succesfully returned from the secure storage. the email is ${emailController!.text} and the password is ${passwordController!.text}');
      return true;
    } else {
      return false;
    }

    // String? value=  await    storage.read(key: 'email');
    //
    //
    //
    //
    // String? value=  await    storage.read(key: 'password');
  }
}
