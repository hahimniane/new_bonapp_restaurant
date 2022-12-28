import 'package:flutter/services.dart';
import 'package:local_auth/error_codes.dart';

import 'package:local_auth/local_auth.dart';

class LocalAuth {
  static final _auth = LocalAuthentication();

  static Future<bool> _canAuthenticate() async =>
      await _auth.canCheckBiometrics || await _auth.isDeviceSupported();

  static Future<bool> authenticate() async {
    try {
      if (!await _canAuthenticate()) {
        return false;
      } else {
        final bool didAuthenticate = await _auth.authenticate(
            localizedReason: 'Please authenticate to login',
            options: const AuthenticationOptions(useErrorDialogs: false));
        print('the user authentication is $didAuthenticate');
        return didAuthenticate;
      }

      // ···
    } on PlatformException catch (e) {
      // if (e.code == _auth.notAvailable) {
      //   // Add handling of no hardware here.
      // } else if (e.code == auth_error.notEnrolled) {
      //   // ...
      // } else {
      //   // ...
      // }
      return false;
    }
  }
}
