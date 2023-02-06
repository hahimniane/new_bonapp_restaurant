import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Provders/provider.dart';

setLanguage(String language)async{
  SharedPreferences preferences=await SharedPreferences.getInstance();
  preferences.setString('language', language);
  print('coming from set Language method and the languea is set to $language');
}

Future<String?>getSavedLanguageSettings(BuildContext context)async {


  SharedPreferences instance = await SharedPreferences.getInstance();
  String? language= instance.getString('language');

  if(language==null){
    print('coming from the getSavedLnaguage and the language was null so setting it to  French');
    instance.setString('language', 'French');

  }
  print('coming from the getSavedLnaguage and the language is available and it is  $language');
  if(language=='English'){
    Provider.of<MyProvider>(context,listen: false).changeLocale('en');

  }
  else {
    Provider.of<MyProvider>(context,listen: false).changeLocale('fr');
  }

return language;
}