import 'package:flutter/material.dart';

class FormValidationProvider extends ChangeNotifier {
 late  final GlobalKey<FormState> _formKey;
  bool _isFormValid = false;




  bool get isFormValid => _isFormValid;


  initializeFormKey(GlobalKey<FormState> key){
    print('the initialize method was called. the ${key.currentContext?.owner}');
    _formKey=key;
    notifyListeners();

  }

   void  validateForm() {

    if (_formKey.currentState!.validate()) {

      _isFormValid = true;
      notifyListeners();
    }
  }

  void resetFormValidation() {
    _isFormValid = false;
    notifyListeners();
  }
}
